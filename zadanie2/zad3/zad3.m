%skrypt do realizacji zadania 3
uz = 0;%wybor odpowiedzi u - 1/z - 0
Upp = 0;
Ypp = 0;
Zpp = 0;
start = 10;
kk=300; %koniec symulacji
%warunki poczatkowe
u = ones(1,kk)*Upp;
y = ones(1,kk)*Ypp;
z = ones(1,kk)*Zpp;
if uz == 1
    u(1,start:end) = 1;
else 
    z(1,start:end) = 1;
end

for k=start:kk %glowna petla symulacyjna
    %symulacja obiektu   
    y(k)=symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y(k-1),y(k-2));
end

y1 = y(start-1:end);
legend('s')
xlabel('k');
ylabel('S');
subplot(2,1,1)
hold on; 
grid on; 
plot(y1);
title('Odpowiedzi skokowe modelu')
if uz == 1
    s_u = y1(2:181);
    subplot(2,1,2)
    hold on; 
    grid on; 
    plot(u(start-1:end));
    title('Sterowanie modelu')
    legend('u')
    xlabel('k');
    ylabel('U');
else
    s_z = y1(2:76);
    subplot(2,1,2)
    hold on; 
    grid on; 
    plot(z(start-1:end));
    title('Zaklocenie modelu')
    legend('z')
    xlabel('k');
    ylabel('Z');
end