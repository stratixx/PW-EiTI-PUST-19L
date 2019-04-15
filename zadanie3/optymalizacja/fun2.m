%funkcja realizujaca symulacje obiektu dla optymalizacji nastaw DMC
function [E] = fun2(in)

N=round(in(1));
Nu=round(in(2));
lambda=in(3);

doPlot = 1; % 0 albo 1, czy rysowaæ wykres
ErrLambda = 40; % kara za zmiennoœæ sterowania
D = 200;%horyzont dynamiki
kk = 2500; %koniec symulacji
start = 50; %start symulacji
u = 0.8*ones(1,kk);%sygnal sterujacy
y = zeros(1,kk);%odpowiedz skokowa obiektu
ogr = 1;
E =0;
load('s.mat')

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

u_delta=zeros(1,D-1);
y_zad=zeros(kk,1);
y_zad(1:kk) = 2;
y_mod = 2*ones(kk,1);
y_zad(start:500) = 2.5;
y_zad(500:1000) = 1.8;
y_zad(1000:1500) = 2.2;
y_zad(1,1500:2000) = 2.5;
y_zad(1,2000:kk) = 2.0;

% Symulacja
for k = 20:kk
   % Równanie ró?nicowe z puntku drugiego
   y_mod(k)=symulacja_obiektu7Y(u(k-10), u(k-11), y_mod(k-1), y_mod(k-2)); 
   
   % Regulator 
   for n = D-1:-1:2
       u_delta(n) = u_delta(n-1);
   end
   
   uchyb = y_zad(k) - y_mod(k);
   u_delta(1) = sum(K(1,:))*uchyb - K(1,:)*Mp*u_delta';   
   u(k) = u(k-1) + u_delta(1);
   if ogr == 1
         if u(k) - u(k-1) > 0.2
              u(k) = 0.2 + u(k-1);
         end 
         if u(k) - u(k-1) < -0.2
              u(k) = u(k-1)-0.2;
         end
     end
     if u(k) > 1.5
         u(k) = 1.5;
     end
     if u(k) < 0.1
         u(k) = 0.1;
     end     
     E = E + (y_zad(k) - y_mod(k))^2 + ErrLambda*(u(k)-u(k-1))^2;
end

if doPlot
    figure(1)
    hold on;
    plot(y_mod)
    plot(y_zad)
    title('y, y_z_a_d');
    figure(2)
    hold on;
    plot(u)
    title('u');
end
end
