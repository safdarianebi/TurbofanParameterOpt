function [T0_1,P0_1] = intake(T_a,P_a,etta_i,M_a)
gama=1.4;

P0_1=P_a*((1+etta_i*((gama-1)/2)*(M_a^2))^(gama/(gama-1)));
T0_1=T_a*(1+((gama-1)/2)*(M_a^2));

end

