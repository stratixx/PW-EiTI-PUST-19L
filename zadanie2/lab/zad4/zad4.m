%zadanie 6 - Skrypt relizujacy algorytm DMC regulatora z zakloceniem sinus
%nastawy regulatora DMC

addpath ('F:\SerialCommunication') ; % add a path
initSerialControl COM5 % initialise com port

load('../zad3/s_skok_s_32_55_approx.mat');
load('../zad3/s_skok_z_0_30_approx.mat');
load('u_max.mat');
D = length(s); % horyzont dynamiki
Dz = length(s_z); % horyzont dynamiki
N = 200;%horyzont predykcji
Nu = 10;%horyzont sterowania
lambda = 0.8;

%warunki poczatkowe
kk = 2000; %koniec symulacji
start = 1880; %start symulacji
start_z = 100; %start symulacji
u=ones(1,kk)*39;%sygnal sterujacy
E = 0;
zakl = 1;%czy sa zaklocenia 1-T/0-N
licz_z = 0;%czy mamy uwzgledniac 1-T/0-N

%paramerty symulacji
u_delta = zeros(1,D-1);
z_delta = zeros(1,Dz);
y_zad=ones(1, kk+D)*37.8; 
y_zad(1, D+50:kk+D)=37.8
y = ones(1, kk)*38; % wektor wyjsc obiektu
z = zeros(1, kk);

if zakl == 1
    z(start_z+D:kk) = 30;
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


    
 %% sending new values of control signals
sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , u(1) , 0]) ;

% Regulacja
for k = D:kk
   % Równanie ró?nicowe z puntku drugiego
   %y_mod(k)=symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y_mod(k-1),y_mod(k-2));
    %% obtaining measurements
    measurements = readMeasurements (1:7) ; % read measurements
    y(k)=measurements(1); % powiekszamy wektor y o element Y
   
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
   
   uchyb = y_zad(k) - y(k);
   if zakl == 1 && licz_z == 1
       u_delta(1) = sum(K(1,:))*uchyb - K(1,:)*(Mp*u_delta' + Mzp*z_delta');
   else
       u_delta(1) = sum(K(1,:))*uchyb - K(1,:)*(Mp*u_delta');
   end
   u(k) = u(k-1) + u_delta(1);
    
    % ograniczenia sterowania
    if u(k)>u_max
        u(k)=u_max;
    end
    if u(k)<0.0
        u(k) = 0.0;
    end
   
    u_delta(1) = u(k) - u(k-1);
    
   E = E + (y_zad(k) - y(k))^2;
   
    figure(1);
    clf(1);
    hold on;
    title('y');
    grid on;
    xlabel('time');
    ylabel('value');
    plot(y(1:k)); % wyswietlamy y w czasie
    
    
    plot(y_zad(1:k)); % wyswietlamy y w czasie
    legend('y','y_z_a_d')
    
    figure(2); 
    clf(2);
    hold on;
    title('u');
    grid on;
    xlabel('time');
    ylabel('value');
    plot(u(1:k)); % wyswietlamy u w czasie
    
    figure(3); 
    clf(3);
    hold on;
    title('z');
    grid on;
    xlabel('time');
    ylabel('value');
    plot(z(1:k)); % wyswietlamy u w czasie
    %legend('u')
    
    drawnow
    
    
     %% sending new values of control signals
    sendControlsToG1AndDisturbance(u(k), z(k));
    %% synchronising with the control process
    waitForNewIteration () ; % wait for new iteration
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

if licz_z == 1
    dlmwrite("../Dane/Zad6/zad6_y_best_licz_zakl.csv", y_mod, '\t');
    dlmwrite("../Dane/Zad6/zad6_u_best_licz_zakl.csv", u, '\t');
    dlmwrite("../Dane/Zad6/zad6_z_best_licz_zakl.csv", z, '\t');
else
    dlmwrite("../Dane/Zad6/zad6_y_best_nie_licz_zakl.csv", y_mod, '\t');
    dlmwrite("../Dane/Zad6/zad6_u_best_nie_licz_zakl.csv", u, '\t');
    dlmwrite("../Dane/Zad6/zad6_z_best_nie_licz_zakl.csv", z, '\t');
end