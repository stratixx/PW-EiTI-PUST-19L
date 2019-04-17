%wyznaczenie przebiegu funkcji rozmycia dla zadanych punktów pracy.
% punkty pracy podane jako dwa punkty tworz¹ce prost¹
%potrzebne wektory: 
%   Y(U) - charakterystyka statyczna obiektu,
%   U    - sterowanie obiektu

%punkty prostych do wyznaczenia
x0 = -0.5;  y0 = -1.475;
x1 = -0.9;  y1 = -4.098;
x2 = 0.88; y2 = 0.143;
x3 = 0.33; y3 = 0.1118;
x4 = -0.42; y4 = -0.84;
x5 = -0.04; y5 = -0.03888;

%proste wyznaczoen z par punktów
a1 = (y0-y1)/(x0-x1);
b1 = y0-a1*x0;
a2 = (y2-y3)/(x2-x3);
b2 = y2-a2*x2;
a3 = (y4-y5)/(x4-x5);
b3 = y4-a3*x4;

%wyliczenie wartoœci z wyznaczonych funkcji
Y1 = U .* a1 + b1;
Y2 = U .* a2 + b2;
Y3 = U .* a3 + b3;

%wyznaczenie b³êdu aproksymacji prostej
w1 =  Y - Y1;
w2 =  Y - Y2; 
w3 =  Y - Y3;
%modu³ b³êdu
w1 = abs(w1);
w2 = abs(w2);
w3 = abs(w3);
%przeskalowanie przebiegów
scale1 = ((w1+w2+w3)./1);
w1 = w1 ./ scale1;
w2 = w2 ./ scale1;
w3 = w3 ./ scale1;
%przesuniêcie i obrócenie przebiegów
maxErr = max([max(w1), max(w2), max(w3)])
% maxErr = 0.9287;
w1 = maxErr - w1;
w2 = maxErr - w2;
w3 = maxErr - w3;
%ponowne przeskalowanie przebiegów
scale2  = ((w1+w2+w3) ./ 1);
w1 = w1 ./ scale2;
w2 = w2 ./ scale2;
w3 = w3 ./ scale2;

close all
figure(1);
hold on;
plot(U,Y,'-.');
plot(U,Y1);
plot(U,Y2);
plot(U,Y3);
legend('y','w1','w2', 'w3');
ylim([min(Y)-1,max(Y)+1])
grid on;


figure(3);
hold on;
plot(U,w1);
plot(U,w2);
plot(U,w3);
plot(U,w1+w2+w3);
legend('w1','w2', 'w3', 'w1+w2+w3');
grid on;

