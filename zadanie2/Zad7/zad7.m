%zadanie 7 - Skrypt relizujacy algorytm DMC regulatora z zakloceniem szum
%nastawy regulatora DMC
D = 180;%horyzont dynamiki
Dz = 75;%horyzont dynamiki zaklocen
N = 180;%horyzont predykcji
Nu = 4;%horyzont sterowania
lambda = 9;

%warunki poczatkowe
kk = 1000; %koniec symulacji
start = 50; %start symulacji
start_z = 150; %start symulacji
u = zeros(1,kk);%sygnal sterujacy
E = 0;
zakl = 1;%czy sa zaklocenia 1-T/0-N
licz_z = 1;%czy mamy uwzgledniac 1-T/0-N
load('s_u.mat')
load('s_z.mat')
s = s_u;
%paramerty symulacji
u_delta = zeros(1,D-1);
z_delta = zeros(1,Dz);
y_zad = zeros(kk,1);
y_mod = zeros(kk,1);
y_zad(start:kk) = 1;
z = zeros(kk,1);
 if zakl == 1
    for i = start_z:kk
    z(i) = 1 + normrnd(0,0.5);
    end
 end

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

% Macierz Mzp
if zakl == 1 && licz_z == 1
    Mzp = zeros(N,Dz);
    for l = 1:Dz
    Mzp(1,l) = s_z(l);
    end
    for i = 2:N
       for j = 1:Dz-1
          if i+j <= Dz
             Mzp(i,j) = s_z(i+j-1)-s_z(j);
          else
             Mzp(i,j) = s_z(Dz)-s_z(j);
          end      
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
   
   if zakl == 1 && licz_z == 1
       for n = Dz:-1:2
            z_delta(n) = z_delta(n-1);
       end
       z_delta(1) = z(k) - z(k-1);
   end
   
   uchyb = y_zad(k) - y_mod(k);
   if zakl == 1 && licz_z == 1
       u_delta(1) = sum(K(1,:))*uchyb - K(1,:)*(Mp*u_delta' + Mzp*z_delta');
   else
       u_delta(1) = sum(K(1,:))*uchyb - K(1,:)*(Mp*u_delta');
   end
   u(k) = u(k-1) + u_delta(1);
   
   E = E + (y_zad(k) - y_mod(k))^2;
end
E
%wyniki
figure;
subplot(3,1,1);
hold on;
grid on;
stairs(y_mod,'m');
xlabel('k');
ylabel('y,y_z_a_d')
stairs(y_zad,'k--')
title({['Regulator DMC D = ',sprintf('%g',D),'; N = ',sprintf('%g',N),'; Nu = ',sprintf('%g',Nu),'; Lambda = ',sprintf('%g',lambda)];['Wyjscie modelu na tle wartosci zadanej \color{red}E = ',sprintf('%g',E)]});
legend('y','y_z_a_d','Location', 'northeast');
subplot(3,1,2);
hold on;
grid on;
stairs(u,'c')
title('Sterowanie modelu')
ylabel('u')
xlabel('k');
subplot(3,1,3);
hold on;
grid on;
stairs(z,'c')
title('Zaklocenie modelu')
ylabel('z')
xlabel('k');