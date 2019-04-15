%skrypt do realizacji zadania 1
start = 10;
kk=300; %koniec symulacji
%warunki poczatkowe
u = zeros(1,kk);
y = zeros(1,kk);

for k=start:kk %glowna petla symulacyjna
    %symulacja obiektu   
    y(k)=symulacja_obiektu7y(u(k-5),u(k-6),y(k-1),y(k-2));
end
subplot(3,1,1)
hold on; 
grid on; 
plot(y);
title('Wyjscie modelu')
legend('y')
xlabel('k');
ylabel('y(k)');
subplot(2,1,2)
hold on; 
grid on; 
plot(u);
title('Sterowanie modelu')
legend('u');
xlabel('k');
ylabel('u(k)');
dlmwrite("../Dane/zad1/zad1_u.csv", u, '\t');
dlmwrite("../Dane/zad1/zad1_y.csv", y, '\t');