function [T0_2,P0_2] =fan(T0_1,P0_1,etta_f,FPR)

delta=(T0_1/etta_f)*(FPR^(0.4/1.4)-1);
T0_2=delta+T0_1;

P0_2=FPR*P0_1;

end

