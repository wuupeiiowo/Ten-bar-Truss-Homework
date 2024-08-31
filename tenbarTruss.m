function [Q,Stress,R] = tenbarTruss(r)
% 桿件角度、長度、截面積
ang(1:4) = 180*pi/180;
ang(5:6) = -90*pi/180;
[ang(7),ang(9)] = deal(135*pi/180);
[ang(8),ang(10)] = deal(-135*pi/180);
L(1:6) = 9.14;
L(7:10) = 12.9259;
A(1:6) = pi*r(1)^2;
A(7:10) = pi*r(2)^2;

% 剛性矩陣
E = 200*10^9;
K = zeros(12);
element = [5 6 9 10;1 2 5 6;7 8 11 12;3 4 7 8;5 6 7 8;1 2 3 4;7 8 9 10;5 6 11 12;3 4 5 6;1 2 7 8];
for i=(1:10)
    C = cos(ang(i));
    S = sin(ang(i));
    k = A(i)*E/L(i)*[C^2 C*S -C^2 -C*S;C*S S^2 -C*S -S^2;-C^2 -C*S C^2 C*S;-C*S -S^2 C*S S^2];
    for I=(1:4)
        for H=(1:4)
        K(element(i,H),element(i,I)) = K(element(i,H),element(i,I)) + k(I,H);
        end
    end
end

% 位移Q計算(Q = K⁻¹*FT)
F = [0,0,0,-10^7,0,0,0,-10^7]; % 力矩陣
Q = inv(K(1:8,1:8))*F';
Q = [Q;0;0;0;0];
 
% 應力分析
Stress = zeros(10,1);

for i=(1:10)
    C = cos(ang(i));
    S = sin(ang(i));
    q = [Q(element(i,1),1);Q(element(i,2),1);Q(element(i,3),1);Q(element(i,4),1)];
    Stress(i,1) = E/L(i)*[-C -S C S]*q;
end

% 反作用力(R = KQ)
R = K(9:12,1:12)*Q;