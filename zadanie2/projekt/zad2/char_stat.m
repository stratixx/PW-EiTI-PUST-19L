%skrypt do realizacji zadania 2 - rysowanie charakterystyki statycznej
start = 10;
kk = 300; %koniec symulacji
%warunki poczatkowe
Upp = 0;
Ypp = 0;
Zpp = 0;
Y = zeros(21);
u1 = -2:0.05:2;
z1 = -2:0.05:2;
for i = 1:length(u1)
    for j = 1:length(z1)
    y = ones(1,kk)*Ypp;
    u = ones(1,kk)*u1(i); 
    z = ones(1,kk)*z1(j); 
    for k=start:kk %glowna petla symulacyjna
        %symulacja obiektu   
        y(k)=symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y(k-1),y(k-2));
    end
    Y(i,j) = y(k);
    end
end
surf(u1,z1,Y);
xlabel('U')
ylabel('Z')
zlabel('Y')
title('Charakterystyka statyczna obiektu Y(U,Z)')