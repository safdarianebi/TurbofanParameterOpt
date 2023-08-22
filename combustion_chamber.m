function [T0_4,P0_4] =combustion_chamber(TIT,P0_3,dP_b)

T0_4=TIT;
P0_4=P0_3*(1-dP_b);

end

