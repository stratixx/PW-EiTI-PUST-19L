%skrypt do realizacji zadania 1
start = 5;
kk=300; %koniec symulacji
%warunki poczatkowe
u1 = zeros(1,kk);
u2 = zeros(1,kk);
u3 = zeros(1,kk);
u4 = zeros(1,kk);
y1 = zeros(1,kk);
y2 = zeros(1,kk);
y3 = zeros(1,kk);

for k=start:kk %glowna petla symulacyjna
    %symulacja obiektu   
    [y1(k),y2(k),y3(k)]=symulacja_obiektu7(u1(k-1),u1(k-2),u1(k-3),u1(k-4),u2(k-1),u2(k-2),u2(k-3),u2(k-4),u3(k-1),u3(k-2),u3(k-3),u3(k-4),u4(k-1),u4(k-2),u4(k-3),u4(k-4),y1(k-1),y1(k-2),y1(k-3),y1(k-4),y2(k-1),y2(k-2),y2(k-3),y2(k-4),y3(k-1),y3(k-2),y3(k-3),y3(k-4));
end
figure;
subplot(3,1,1)
grid on; 
plot(y1);
hold on;
title('Wyjscie y_1 modelu')
legend('y_1')
xlabel('k');
ylabel('y_1(k)');
subplot(3,1,2)
grid on; 
plot(y2);
hold on;
title('Wyjscie y_2 modelu')
legend('y_2')
xlabel('k');
ylabel('y_2(k)');
subplot(3,1,3)
grid on; 
plot(y3);
hold on;
title('Wyjscie y_3 modelu')
legend('y_3')
xlabel('k');
ylabel('y_3(k)');
figure;
subplot(4,1,1)
grid on; 
plot(u1);
hold on;
title('Sterowanie u_1 modelu')
legend('u_1')
xlabel('k');
ylabel('u_1(k)');
subplot(4,1,2)
grid on; 
plot(u2);
hold on;
title('Sterowanie u_2 modelu')
legend('u_2')
xlabel('k');
ylabel('u_2(k)');
subplot(4,1,3)
grid on; 
plot(u3);
hold on;
title('Sterowanie u_3 modelu')
legend('u_3')
xlabel('k');
ylabel('u_3(k)');
subplot(4,1,4)
grid on; 
plot(u1);
hold on;
title('Sterowanie u_4 modelu')
legend('u_4')
xlabel('k');
ylabel('u_4(k)');
dlmwrite("../Dane/Zad1/zad1_u1.csv", u1, '\t');
dlmwrite("../Dane/Zad1/zad1_u2.csv", u2, '\t');
dlmwrite("../Dane/Zad1/zad1_u3.csv", u3, '\t');
dlmwrite("../Dane/Zad1/zad1_u4.csv", u4, '\t');
dlmwrite("../Dane/Zad1/zad1_y1.csv", y1, '\t');
dlmwrite("../Dane/Zad1/zad1_y2.csv", y2, '\t');
dlmwrite("../Dane/Zad1/zad1_y3.csv", y3, '\t');
