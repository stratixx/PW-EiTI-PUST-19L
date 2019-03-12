%Skrypt relizujacy algorytm DMC regulatora
D = 200;%horyzont dynamiki
N = 70;%horyzont predykcji
Nu = 10;%horyzont sterowania
kk = 1000; %koniec symulacji
start = 50; %start symulacji
u=0.8*ones(1,kk);%sygnal sterujacy
y=zeros(1,kk);%odpowiedz skokowa obiektu
ogr = 1;
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
lambda = 130;
mac_lam = lambda*eye(Nu);
psi = eye(N);
K = ((M'*psi*M+mac_lam)^(-1))*M'*psi;

u_delta=zeros(1,D-1);
y_zad=zeros(kk,1);
y_zad(1:kk) = 2;
y_mod = 2*ones(kk,1);
y_zad(start:kk) = 2.5;

% Symulacja
for k = 20:kk
   % Równanie ró¿nicowe z puntku drugiego
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
end

%wyniki
figure(1); 
subplot(2,1,1);
stairs(y_mod);
xlabel('k - numer próbki');
hold on;
ylabel('y,yzad')
stairs(y_zad,'k--')
title(['Regulator DMC D = ',sprintf('%g',D),'; N = ',sprintf('%g',N),'; Nu = ',sprintf('%g',Nu),'; Lambda = ',sprintf('%g',lambda)]);
legend('wyjœcie modelu','wartoœæ zadana','Location', 'southeast');
subplot(2,1,2);
stairs(u)
ylabel('u')
xlabel('k - numer próbki');
%print(['RegulatorDMC_', sprintf('%g',D),'_',sprintf('%g',N),'_',sprintf('%g',Nu),'_',sprintf('%g',lambda)], '-dpng', '-r400');