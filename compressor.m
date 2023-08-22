function [T0_3,P0_3] =compressor(T0_2,P0_2,etta_c,CPR)

delta=(T0_2/etta_c)*(CPR^(0.4/1.4)-1);
T0_3=delta+T0_2;

P0_3=CPR*P0_2;

end

