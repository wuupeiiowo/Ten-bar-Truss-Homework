function object = fun(r)
m(1) = 7860*pi*r(1).^2*9.14;
m(2) = 7860*pi*r(2).^2*12.9259;
object = 6*m(1)+4*m(2);
end

