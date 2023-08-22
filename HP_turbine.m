function [T0_5,P0_5] = HP_turbine(T0_4,P0_4,etta_t,T0_3,T0_2,etta_m,f)
C_P_a=1.005; %kJ/kg
C_P_g=1.148; %kJ/kg

delta=((C_P_a*(T0_3-T0_2))/(etta_m*C_P_g))/(1+f);
TPR=(1-(delta/(etta_t*T0_4)))^((-1.33)/(0.33));
T0_5=T0_4-delta;

P0_5=P0_4/TPR;

end

