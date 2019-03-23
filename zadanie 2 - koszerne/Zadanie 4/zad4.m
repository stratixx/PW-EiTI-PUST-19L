%zadanie 4 - Skrypt relizujacy algorytm DMC regulatora
%nastawy regulatora DMC
D = 180;%horyzont dynamiki
N = 180;%horyzont predykcji
Nu = 4;%horyzont sterowania
lambda = 9;

%warunki poczatkowe
kk = 300; %koniec symulacji
start = 50; %start symulacji
u = zeros(1,kk);%sygnal sterujacy
E = 0;
load('s_u.mat')
s = s_u;
%paramerty symulacji
u_delta = zeros(1,D-1);
y_zad = zeros(kk,1);
y_mod = zeros(kk,1);
y_zad(start:500) = 1;
z = zeros(kk,1);

% Macierz predykcji
Mp = zeros(N,D-1);
for i = 1:N
   for j = 1:D-1
      if i+j <= D
         Mp(i,j) = s(i+j)-s(j);
      else
         Mp(i,j) = s(D)-s(j);
      end      
   end
end

% Macierz M
M = zeros(N,Nu);
for i = 1:N
   for j = 1:Nu
      if (i >= j)
         M(i,j) = s(i-j+1);
      end
   end
end

% Obliczanie parametrów regulatora
mac_lam = lambda*eye(Nu);
psi = eye(N);
K = ((M'*psi*M+mac_lam)^(-1))*M'*psi;

% Symulacja
for k = 20:kk
   % Równanie ró?nicowe z puntku drugiego
   y_mod(k)=symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y_mod(k-1),y_mod(k-2));
   
   % Regulator 
   for n = D-1:-1:2
       u_delta(n) = u_delta(n-1);
   end
   
   uchyb = y_zad(k) - y_mod(k);
   u_delta(1) = sum(K(1,:))*uchyb - K(1,:)*Mp*u_delta';   
   u(k) = u(k-1) + u_delta(1);
   
   E = E + (y_zad(k) - y_mod(k))^2;
end
E
%wyniki
subplot(2,1,1);
hold on;
grid on;
stairs(y_mod,'m');
xlabel('k');
ylabel('y,y_z_a_d')
stairs(y_zad,'k--')
title({['Regulator DMC D = ',sprintf('%g',D),'; N = ',sprintf('%g',N),'; Nu = ',sprintf('%g',Nu),'; Lambda = ',sprintf('%g',lambda)];['Wyjscie modelu na tle wartosci zadanej \color{red}E = ',sprintf('%g',E)]});
legend('y','y_z_a_d','Location', 'northeast');
subplot(2,1,2);
hold on;
grid on;
stairs(u,'c')
title('Sterowanie modelu')
ylabel('u')
xlabel('k');