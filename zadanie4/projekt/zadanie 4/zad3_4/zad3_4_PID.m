%zadanie 3 i 4 - Skrypt realizujacy algorytm cyfrowego wielowymiarowego regulatora PID
%inicjalizacja
clear all

E = 0;%wspolczynnik jakosci regualcji
ny = 3;
nu = 4;

Tp = 0.5;%czas probkowania

ster = 4;%odrzucany sygnal sterujacy

%nastawy regulatorow

% %eksperymentalnie
% if ster == 1
%     Kr1 = 1.5; Ti1 = 2; Td1 = 0.01;%u2 dla y3
%     Kr2 = 5.5; Ti2 = 0.4; Td2 = 0.2;%u3 dla y2
%     Kr3 = 2; Ti3 = 9; Td3 = 1;%u4 dla y1
% elseif ster == 2
%     Kr1 = 0.7; Ti1 = 0.2; Td1 = 0.3;%u1 dla y3
%     Kr2 = 3.5; Ti2 = 0.2; Td2 = 0.2;%u3 dla y2
%     Kr3 = 3; Ti3 = 7.5; Td3 = 0.8;%u4 dla y1
% elseif ster == 3
%     Kr1 = 0.7; Ti1 = 0.2; Td1 = 0.3;%u1 dla y3
%     Kr2 = 0.7; Ti2 = 1.8; Td2 = 0.6;%u2 dla y2
%     Kr3 = 1.4; Ti3 = 5.5; Td3 = 0.6;%u4 dla y1
% elseif ster == 4
%     Kr1 = 0.7; Ti1 = 0.2; Td1 = 0.3;%u1 dla y3
%     Kr2 = 0.6; Ti2 = 0.3; Td2 = 0.05;%u2 dla y2
%     Kr3 = 0.8; Ti3 = 0.4; Td3 = 0.4;%u3 dla y1
% end

%optymalizacja
if ster == 1
    Kr1 = 2.4380; Ti1 = 3.2542; Td1 = 0;%u2 dla y3
    Kr2 = 8.8647; Ti2 = 0.2623; Td2 = 0;%u3 dla y2
    Kr3 = 3.1042; Ti3 = 16.8144; Td3 = 1.0262;%u4 dla y1
elseif ster == 2
    Kr1 = 2.2901; Ti1 = 0.5102; Td1 = 0.0187;%u1 dla y3
    Kr2 = 0.0219; Ti2 = 0.0006; Td2 = 39.5656;%u3 dla y2
    Kr3 = 4.8545; Ti3 = 17.6086; Td3 = 0.4969;%u4 dla y1
elseif ster == 3
    Kr1 = 2.4231; Ti1 = 0.6438; Td1 = 0;%u1 dla y3
    Kr2 = 1.3759; Ti2 = 1.1730; Td2 = 0;%u2 dla y2
    Kr3 = 6.4637; Ti3 = 13.3023; Td3 = 0.0984;%u4 dla y1
elseif ster == 4
    Kr1 = 2.5885; Ti1 = 0.5918; Td1 = 0;%u1 dla y3
    Kr2 = 1.4396; Ti2 = 0.6631; Td2 = 0;%u2 dla y2
    Kr3 = 13.4882; Ti3 = 4.4987; Td3 = 0.0290;%u3 dla y1
end

%nastawy regulatorow dyskretnego
r21 = Kr1*Td1/Tp; r11 = Kr1*(Tp/(2*Ti1)-2*Td1/Tp-1); r01 = Kr1*(1+Tp/(2*Ti1)+Td1/Tp);

r22 = Kr2*Td2/Tp; r12 = Kr2*(Tp/(2*Ti2)-2*Td2/Tp-1); r02 = Kr2*(1+Tp/(2*Ti2)+Td2/Tp);

r23 = Kr3*Td3/Tp; r13 = Kr3*(Tp/(2*Ti3)-2*Td3/Tp-1); r03 = Kr3*(1+Tp/(2*Ti3)+Td3/Tp);

%parametry symulacji
kk = 1600;
start = 10;
e = zeros(1,kk);
u1 = zeros(1,kk);
u2 = zeros(1,kk);
u3 = zeros(1,kk);
u4 = zeros(1,kk);
y1 = zeros(1,kk);
y2 = zeros(1,kk);
y3 = zeros(1,kk);

Ey = zeros(ny,1);

y1_zad = zeros(1,kk);
y1_zad(start:400) = 1;
y1_zad(400:800) = 1.5;
y1_zad(800:1200) = 0.6;
y1_zad(1200:kk) = 2.5;

y2_zad = zeros(1,kk);
y2_zad(start:400) = 2;
y2_zad(400:800) = 1.2;
y2_zad(800:1200) = 0;
y2_zad(1200:kk) = 1.5;

y3_zad = zeros(1,kk);
y3_zad(start:400) = 1.5;
y3_zad(400:800) = 0.8;
y3_zad(800:1200) = 2;
y3_zad(1200:kk) = 0.2;

for k = start:kk %glowna petla symulacyjna 
    %symulacja obiektu 
       [y1(k),y2(k),y3(k)] = symulacja_obiektu7(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
       u2(k-1),u2(k-2),u2(k-3),u2(k-4),u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
       u4(k-1),u4(k-2),u4(k-3),u4(k-4),y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
       y2(k-1),y2(k-2),y2(k-3),y2(k-4),y3(k-1),y3(k-2),y3(k-3),y3(k-4)); 
   
   %uchyb regulacji
    e(1,k) = y1_zad(k) - y1(k);
    e(2,k) = y2_zad(k) - y2(k);
    e(3,k) = y3_zad(k) - y3(k); 

    if ster == 1
        u2(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u2(k-1);%y3 od u2
        u3(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u3(k-1);%y2 od u3
        u4(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u4(k-1);%y1 od u4
    elseif ster == 2
        u1(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u1(k-1);%y3 od u1
        u3(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u2(k-1);%y2 od u3
        u4(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u4(k-1);%y1 od u4
    elseif ster == 3
        u1(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u1(k-1);%y3 od u1
        u2(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u2(k-1);%y2 od u2
        u4(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u4(k-1);%y1 od u4 
    elseif ster == 4
        u1(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u1(k-1);%y3 dla u1
        u2(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u2(k-1);%y2 dla u2
        u3(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u3(k-1);%y1 dla u3
    end
     
     %bledy
   Ey(1) = Ey(1) + (e(1,k))^2;
   Ey(2) = Ey(2) + (e(2,k))^2;
   Ey(3) = Ey(3) + (e(3,k))^2;
end
E = sum(Ey)

%wyniki symulacji 
figure;
subplot(3,1,1);
hold on;
grid on;
stairs(y1,'m');
xlabel('k');
ylabel('y1,y1_z_a_d')
stairs(y1_zad,'k--')
title('Regulator PID - wyjscie 1')
legend('y1','y1_z_a_d','Location', 'northeast');
subplot(3,1,2);
hold on;
grid on;
stairs(y2,'m');
xlabel('k');
ylabel('y2,y2_z_a_d')
stairs(y2_zad,'k--')
title('Regulator PID - wyjscie 2')
legend('y2','y2_z_a_d','Location', 'northeast');
subplot(3,1,3);
hold on;
grid on;
stairs(y3,'m');
xlabel('k');
ylabel('y1,y1_z_a_d')
stairs(y3_zad,'k--')
title('Regulator PID - wyjscie 3')
legend('y3','y3_z_a_d','Location', 'northeast');
figure;
subplot(4,1,1);
hold on;
grid on;
stairs(u1,'g');
xlabel('k');
ylabel('u1')
title('Regulator PID - sterowanie 1')
legend('u1','Location', 'northeast');
subplot(4,1,2);
hold on;
grid on;
stairs(u2,'g');
xlabel('k');
ylabel('u2')
title('Regulator PID - sterowanie 2')
legend('u2','Location', 'northeast');
subplot(4,1,3);
hold on;
grid on;
stairs(u3,'g');
xlabel('k');
ylabel('u3')
title('Regulator PID - sterowanie 3')
legend('u3','Location', 'northeast');
subplot(4,1,4);
hold on;
grid on;
stairs(u4,'g');
xlabel('k');
ylabel('u4')
title('Regulator PID - sterowanie 4')
legend('u4','Location', 'northeast');

% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/y1.csv", y1, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/y2.csv", y2, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/y3.csv", y3, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/u1.csv", u1, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/u2.csv", u2, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/u3.csv", u3, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/u4.csv", u4, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/y1_zad.csv", y1_zad, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/y2_zad.csv", y2_zad, '\t');
% dlmwrite("../Dane/Zad3_4/PID/PID_bez_u4/y3_zad.csv", y3_zad, '\t');