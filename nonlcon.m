% 降伏應力 & 位移限制
function [c,ceq]=nonlcon(x)
[Q,Stress] = tenbarTruss(x);
c(1) = (Q(3,1)^2+Q(4,1)^2)^0.5-0.02;
c(2) = max(abs(Stress))-250*10^6;
ceq = [];
end

