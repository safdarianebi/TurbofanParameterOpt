function [T_2,P_2,V_2,Aj_mdot] = nozzle(T0_1,P0_1,etta_j,P_a,gama,C_P)

r_c=1/((1-(1/etta_j)*((gama-1)/(gama+1)))^(gama/(gama-1)));

R=287;

if (P0_1/P_a)>(r_c)
    
    T_2=T0_1*(2/(gama+1));
    P_2=P0_1/r_c;
    rho_2=((P_2)/(R*T_2))*1000;
    V_2=sqrt(gama*R*T_2);
    Aj_mdot=1/(rho_2*V_2);
    
else
    
    T_2=T0_1-etta_j*T0_1*(1-(1/((P0_1/P_a)^((gama-1)/gama))));
    P_2=P_a;
    rho_2=((P_2)/(R*T_2))*1000;
    V_2=sqrt(2*C_P*1000*(T0_1-T_2));
    Aj_mdot=1/(rho_2*V_2);
    
end

end

