function [T0_6,P0_6] = LP_turbine(T0_5,P0_5,etta_t,T0_2,T0_1,etta_m,B,f)
C_P_a=1.005; %kJ/kg
C_P_g=1.148; %kJ/kg

delta=((B+1)/(1+f))*((C_P_a*(T0_2-T0_1))/(etta_m*C_P_g));
TPR=(1-(delta/(etta_t*T0_5)))^((-1.33)/(0.33));
T0_6=T0_5-delta;

P0_6=P0_5/TPR;

end

