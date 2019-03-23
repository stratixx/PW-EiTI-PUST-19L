%skrypt do realizacji zadania 2 - rysowanie charakterystyki statycznej
start = 10;
kk = 300; %koniec symulacji
%warunki poczatkowe
Upp = 0;
Ypp = 0;
Zpp = 0;
Y = zeros(21);
i1 =1;
j1=1;
for i = -2:0.2:2
    for j = -2:0.2:2
    y = ones(1,kk)*Ypp;
    u = ones(1,kk)*Upp; 
    u(1,start:kk) = i;
    z = ones(1,kk)*Upp; 
    z(1,start:kk) = j;
    for k=start:kk %glowna petla symulacyjna
        %symulacja obiektu   
        y(k)=symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y(k-1),y(k-2));
    end
    Y(i1,j1) = y(end);
    j1 = j1+1;
    end
    i1 = i1+1;
    j1 = 1;
end
hold on; 
grid on;
u1 = -2:0.2:2;
z1 = -2:0.2:2;
surf(u1,z1,Y);
xlabel('U')
ylabel('Z')
zlabel('Y')
title('Charakterystyka statyczna obiektu Y(U,Z)')