clear
clc
close all
format compact

%% Data
[T_a,a,P,~]=atmosisa(35000);
M_a=0.78;
P_a=P/1000; %kPa
C_a=M_a*a;

C_P_a=1.005; %kJ/kg
C_P_g=1.148; %kJ/kg

gama_a=1.4;
gama_g=1.33;

R=287; %J/kg-k

etta_f=0.87;
etta_c=0.85;
etta_t=0.87;
etta_b=0.98;
etta_m=0.99;
etta_j=0.96;
etta_i=0.93;

Q_hv=43150; %kJ/kg

dP_b=0.04;  %0.04*P0_3
dP_c=0.01;  %0.01*P0_2

%% arrays
OPR=30:5:55;
B=3:1:15;
TIT=1200:10:2400;
F_s_max=0*TIT;
sfc_min=0*TIT;
min_sfc=0*B;
max_F_s=0*B;

name_1={'OPR=30  B=3' 'OPR=30  B=6' 'OPR=30  B=9' 'OPR=30  B=12' 'OPR=30  B=15';...
        'OPR=35  B=3' 'OPR=35  B=6' 'OPR=35  B=9' 'OPR=35  B=12' 'OPR=35  B=15';...
        'OPR=40  B=3' 'OPR=40  B=6' 'OPR=40  B=9' 'OPR=40  B=12' 'OPR=40  B=15';...
        'OPR=45  B=3' 'OPR=45  B=6' 'OPR=45  B=9' 'OPR=45  B=12' 'OPR=45  B=15';...
        'OPR=50  B=3' 'OPR=50  B=6' 'OPR=50  B=9' 'OPR=50  B=12' 'OPR=50  B=15';...
        'OPR=55  B=3' 'OPR=55  B=6' 'OPR=55  B=9' 'OPR=55  B=12' 'OPR=55  B=15'};
        
name_2={'OPR=30' 'OPR=35' 'OPR=40' 'OPR=45' 'OPR=50' 'OPR=55'};

%% compete

for i=1:length(OPR)
    
    FPR=1:0.01:OPR(i);
    F_s=0*FPR;
    sfc=0*FPR;
    
  for j=1:length(B)
      
      for k=1:length(TIT)
         
         for l=1:length(FPR) 
             
            %solving the engine equations:
            
            %point1:
            [T0_1,P0_1] =intake(T_a,P_a,etta_i,M_a);
            %point2:
            [T0_2,P0_2] =fan(T0_1,P0_1,etta_f,FPR(l));
            %point3:
            [T0_3,P0_3] =compressor(T0_2,P0_2,etta_c,OPR(i)/FPR(l));
            %point4:
            [T0_4,P0_4] =combustion_chamber(TIT(k),P0_3,dP_b);
            %fuel_ratio:
            f=(C_P_g*T0_4-C_P_a*T0_3)/(etta_b*Q_hv-C_P_g*T0_4);
            %point5:
            [T0_5,P0_5] =HP_turbine(T0_4,P0_4,etta_t,T0_3,T0_2,etta_m,f);
            %point6:
            [T0_6,P0_6] = LP_turbine(T0_5,P0_5,etta_t,T0_2,T0_1,etta_m,B(j),f);
            %point7:
            [T_7,P_7,Cj_h,Aj_mdot_h] =nozzle(T0_6,P0_6,etta_j,P_a,gama_g,C_P_g);
            %point8:
            [T_8,P_8,Cj_c,Aj_mdot_c] =nozzle(T0_2,P0_2*(1-dP_c),etta_j,P_a,gama_a,C_P_a);
            
            %F_s:
            F_s(l)=((1+f)/(1+B(j)))*Cj_h+(B(j)/(1+B(j)))*Cj_c-C_a+(((P_7-P_a)*(1+f)/(1+B(j)))*Aj_mdot_h+((P_8-P_a)/(1+B(j)))*Aj_mdot_c*B(j))*1000;
            
            %sfc:
            sfc(l)=(f/((1+B(j))*F_s(l)))*3600; %N/h-N
         
         end

         
         [corrected_matrix_1,corrected_matrix_2] = corrected_F_s(FPR,F_s);
         [corrected_matrix_3,corrected_matrix_4] = corrected_sfc(FPR,sfc);
         
if mod(B(j),3)==0 && mod(TIT(k),100)==0 && B(j)<=15 && TIT(k)<=2000
         n=((j-1)/3)+1;  
         figure(2*n-1+(i-1)*10)
         plot(corrected_matrix_1,corrected_matrix_2,'LineWidth',2);
         title(name_1(i,n));
         xlabel('FPR');
         ylabel('F_s-[N/kg]');
         grid;
         hold on;
         
         figure(2*n+(i-1)*10)
         plot(corrected_matrix_3,corrected_matrix_4,'LineWidth',2);
         title(name_1(i,n));
         xlabel('FPR');
         ylabel('sfc-[kg/N-h]');
         grid;
         hold on;
    
end
         
         F_s_max(k)=max(corrected_matrix_2);
         sfc_min(k)=min(corrected_matrix_4);
         
         
         
      end
 
      if mod(B(j),3)==0 && B(j)<=15 
      figure(2*n-1+(i-1)*10);
      legend('TIT=1200','TIT=1300','TIT=1400','TIT=1500','TIT=1600','TIT=1700','TIT=1800','TIT=1900','TIT=2000');
      figure(2*n+(i-1)*10)
      legend('TIT=1200','TIT=1300','TIT=1400','TIT=1500','TIT=1600','TIT=1700','TIT=1800','TIT=1900','TIT=2000');
        
      end
      
        p=polyfit(F_s_max,sfc_min,3);
        a=F_s_max(1);
        b=F_s_max(length(F_s_max))-25;
        F_s_max_corrected=a:(b-a)/200:b;
        sfc_min_corrected=polyval(p,F_s_max_corrected);
        
        if mod(B(j),3)==0 && B(j)<=21
        figure(5*length(OPR)*2+i);
        plot(F_s_max_corrected,sfc_min_corrected,'LineWidth',2);
        title(name_2(i));
        xlabel('F_s-[N/kg]');
        ylabel('sfc-[kg/N-h]');
        grid;
        hold on;
        end
        
        [min_sfc(j),k]=min(sfc_min_corrected);
        max_F_s(j)=F_s_max_corrected(k);

  end
  
  figure(5*length(OPR)*2+i);
  legend('BPR=3','BPR=6','BPR=9','BPR=12','BPR=15');

  p=polyfit(max_F_s,min_sfc,3);
  a=max_F_s(1);
  b=max_F_s(length(max_F_s));
  max_F_s_corrected=a:(b-a)/200:b;
  min_sfc_corrected=polyval(p,max_F_s_corrected);
  
      
  figure(5*length(OPR)*2+length(OPR)+1);
  plot(max_F_s_corrected,min_sfc_corrected,'LineWidth',2);
  xlabel('F_s-[N/kg]');
  ylabel('sfc-[kg/N-h]');
  grid;
  hold on;
      
  
  
    
end

figure(5*length(OPR)*2+length(OPR)+1);
legend('OPR=30','OPR=35','OPR=40','OPR=45','OPR=50','OPR=55');

