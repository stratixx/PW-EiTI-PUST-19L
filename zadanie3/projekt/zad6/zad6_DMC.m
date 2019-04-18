%zadanie 6 - Skrypt relizujacy algorytm DMC regulatora rozmytego
%nastawy regulatora DMC
% D = 70;%horyzont dynamiki
% N = 50;%horyzont predykcji
% Nu = 6;%horyzont sterowania
lambda = 1;
kk = 1800;
y_zad=zeros(1,kk);
y_zad(1,20:200) = -2;
y_zad(1,200:400) = -4.5;
y_zad(1,400:600) = -3;
y_zad(1,600:800) = -1.5;
y_zad(1,800:1000) = -3.5;
y_zad(1,1000:1200) = -1.2;
y_zad(1,1200:1400) = -0.3;
y_zad(1,1400:1600) = 0;
y_zad(1,1600:kk) = 0.1;

fuzzyN = 2;%ilosc regulatorow
[D,N,Nu] = nastawy_DMC(fuzzyN);%nastawy dla opd. ilosci regulatorow
settings = [];

for n=1:fuzzyN
    settings(n).D = D(n);
    settings(n).N = N(n);
    settings(n).Nu = Nu(n);
    [Mp,K,u_delta] = parametry_DMC(settings(n).D,settings(n).N,settings(n).Nu,fuzzyN,n);
    settings(n).Mp = Mp;
    settings(n).K = K;
    settings(n).u_delta = u_delta;
	settings(n).lambda = 1;
    settings(n).u1 = 0;
end

%warunki poczatkowe
kk = 1800; %koniec symulacji
start = 50; %start symulacji
u=zeros(1,kk);%sygnal sterujacy
E = 0;

%paramerty symulacji
%y
y_mod = zeros(kk,1);

% Symulacja
for k = 20:kk
   % Równanie ró?nicowe z puntku drugiego
   y_mod(k)=symulacja_obiektu7y(u(k-5),u(k-6),y_mod(k-1),y_mod(k-2));  
   
   for n = 1:fuzzyN
   % Regulator 
       for i = settings(n).D-1:-1:2
           settings(n).u_delta(i) = settings(n).u_delta(i-1);
       end
       u_ = zeros(1, fuzzyN);
       uchyb = y_zad(k) - y_mod(k);
       settings(n).u_delta(1) = sum(settings(n).K(1,:))*uchyb - settings(n).K(1,:)*settings(n).Mp*settings(n).u_delta';   
       u_(n) = u(k-1) + settings(n).u_delta(1);
       %ograniczenia
         if u_(n) > 1.0
             u_(n) = 1.0;
         end
         if u_(n) < -1.0
             u_(n) = -1.0;
         end
       settings(n).u1 = u_(n);
        %funkcja wagi regulatora
        g = f_przyn(round(y_mod(k),2),fuzzyN);
        u_(n) = u_(n) * g(n);
   end
   u(k) = sum(u_);
   %ograniczenia
         if u(k) > 1.0
             u(k) = 1.0;
         end
         if u(k) < -1.0
             u(k) = -1.0;
         end
   
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
% dlmwrite('../Dane/Zad6/DMC/N2/u.csv', u, '\t');
% dlmwrite('../Dane/Zad6/DMC/N2/y.csv', y_mod, '\t');
% dlmwrite('../Dane/Zad6/DMC/N2/y_zad.csv', y_zad, '\t');