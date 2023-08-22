function [corrected_matrix_8,corrected_matrix_7] = corrected_sfc(matrix_2,matrix_1)

n=0;

for i=1:length(matrix_1)
    
    if isreal(matrix_1(i))==1
        n=n+1;
    end
    
end

corrected_matrix_1=zeros(1,n);
corrected_matrix_2=zeros(1,n);
n=0;

for i=1:length(matrix_1)
    
    if isreal(matrix_1(i))==1
        n=n+1;
        corrected_matrix_1(n)=matrix_1(i);
        corrected_matrix_2(n)=matrix_2(i);
    end
    
end
    

for i=2:length(corrected_matrix_1)
    
    if corrected_matrix_1(i)<corrected_matrix_1(i-1)
        
        p=i;
        break;
        
    end
    
end

for i=1:length(corrected_matrix_1)
    
    if corrected_matrix_1(length(corrected_matrix_1)-i)<corrected_matrix_1(length(corrected_matrix_1)-(i-1))
        
        q=length(corrected_matrix_1)-i;
        break;
        
    end
    
end
    
corrected_matrix_3=zeros(1,(q-p)+1+2);
corrected_matrix_4=zeros(1,(q-p)+1+2);

for i=1:length(corrected_matrix_3)
    
    corrected_matrix_3(i)=corrected_matrix_1(p-2+i);
    corrected_matrix_4(i)=corrected_matrix_2(p-2+i);
    
end

degree=5;

p=polyfit(corrected_matrix_4,corrected_matrix_3,degree);


a=corrected_matrix_4(1);
b=corrected_matrix_4(length(corrected_matrix_4));
corrected_matrix_6=a:(b-a)/1000:b;
corrected_matrix_5=polyval(p,corrected_matrix_6);

[y,~]=max(corrected_matrix_5);

if y==corrected_matrix_5(1)
    
    P=figure;
    plot(corrected_matrix_6,corrected_matrix_5);
    hold on;
    plot(corrected_matrix_6,corrected_matrix_5(length(corrected_matrix_5)*ones(1,length(corrected_matrix_5))));
    [x,~]=intersections(corrected_matrix_6,corrected_matrix_5,corrected_matrix_6,corrected_matrix_5(length(corrected_matrix_5)*ones(1,length(corrected_matrix_5))));
    a=x(1);
    b=corrected_matrix_6(length(corrected_matrix_5));
    corrected_matrix_8=a:(b-a)/1000:b;
    corrected_matrix_7=polyval(p,corrected_matrix_8);
    close(P);
    
else
    
    P=figure;
    plot(corrected_matrix_6,corrected_matrix_5);
    hold on;
    plot(corrected_matrix_6,corrected_matrix_5(1)*ones(1,length(corrected_matrix_5)));
    [x,~]=intersections(corrected_matrix_6,corrected_matrix_5,corrected_matrix_6,corrected_matrix_5(1)*ones(1,length(corrected_matrix_5)));
    b=x(2);
    a=corrected_matrix_6(1);
    corrected_matrix_8=a:(b-a)/1000:b;
    corrected_matrix_7=polyval(p,corrected_matrix_8);
    close(P);
    
    
end

end
