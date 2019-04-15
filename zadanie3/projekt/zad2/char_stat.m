%skrypt do realizacji zadania 2 - rysowanie charakterystyki statycznej
start = 10;
kk=300; %koniec symulacji
%warunki poczatkowe
Y = zeros(1,201);
U = zeros(1,201);
h = 1;
Ypp = 0;
Upp = 0;
for i = -1:0.01:1
    y=ones(1,kk)*Ypp;
    u=ones(1,kk)*Upp; 
    u(1,start:kk)=i;
    for k=start:kk %g��wna ptla symulacyjna
        %symulacja obiektu   
        y(k)=symulacja_obiektu7y(u(k-5),u(k-6),y(k-1),y(k-2));
    end
    Y(h) = y(end);
    U(h) = i;
    h = h+1;
end
hold on; 
grid on; 
plot(U,Y); 
legend('y(u)','Location','East')
title('Charakterystyka statyczna obiektu Y(U)')
xlabel('U')
ylabel('Y')
dlmwrite('../Dane/zad2/Char_stat/char_u.csv', U, '\t');
dlmwrite('../Dane/zad2/Char_stat/char_y.csv', Y, '\t');