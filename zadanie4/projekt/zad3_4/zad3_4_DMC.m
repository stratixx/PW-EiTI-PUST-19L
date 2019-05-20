%zadanie 3 i 4 - Skrypt relizujacy algorytm DMC regulatora uproszczonego wielowymiarowego
clear all

%nastawy regulatora DMC
D = 350;%horyzont dynamiki

N = 200;%horyzont predykcji
Nu = 10;%horyzont sterowania


%dobrane eksperymentalnie

% lambda1 = 0.15;
% lambda2 = 0.2;
% lambda3 = 0.7;
% lambda4 = 0.1;
% psi1 = 1;
% psi2 = 1;
% psi3 = 1;

%optymalizacja

lambda1 = 0.9004;
lambda2 = -5.5093;
lambda3 = 12.1642;
lambda4 = -0.0569;
psi1 = -0.5147;
psi2 = -9.3173;
psi3 = 3.2215;

%warunki poczatkowe
nu = 4;
ny = 3;
load('s.mat')
%Macierz odopowiedzi skokowych
for i = 1:D
    S(i)={[s11(i) s12(i) s13(i) s14(i);...
           s21(i) s22(i) s23(i) s24(i);...
           s31(i) s32(i) s33(i) s34(i)]};
end

% Macierz predykcji
for i = 1:N
   for j = 1:D-1
      if i+j <= D
         Mp{i,j} = S{i+j}-S{j};
      else
         Mp{i,j} = S{D}-S{j};
      end      
   end
end

% Macierz M
for i=1:Nu
    M(i:N,i)=S(1:N-i+1);
    M(1:i-1,i)={[0 0 0 0; 0 0 0 0; 0 0 0 0]};
end

% Obliczanie parametrów regulatora

%Macierz lambda
for i=1:Nu
    for j=1:Nu
        if i==j
            Lambda{i,j}=[lambda1 0 0 0; 0 lambda2 0 0;...
                         0 0 lambda3 0; 0 0 0 lambda4];
        else
            Lambda{i,j}=[0 0 0 0; 0 0 0 0;...
                         0 0 0 0; 0 0 0 0;];
        end
    end
end

%Macierz Psi
for i=1:N
    for j=1:N
        if i==j
            Psi{i,j}=[psi1 0 0; 0 psi2 0; 0 0 psi3];
        else
            Psi{i,j}=[0 0 0; 0 0 0; 0 0 0];
        end
    end
end

%Macierz K
for i = 1:Nu
    size(i) = nu;
end
for i=1:N
    size2(i) = ny;
end

M_temp = cell2mat(M);
M_temp_tr = M_temp';
Psi_temp = cell2mat(Psi);
M_temp_tr = M_temp_tr * Psi_temp;
M_temp = mat2cell(M_temp_tr*M_temp,size,size);
for i=1:Nu
    for j=1:Nu
        L{i,j} = M_temp{i,j}+Lambda{i,j}; %Dodanie Lambdy
    end
end
L_temp = cell2mat(L);
L_temp_rev = mat2cell(L_temp^(-1),size,size);
L_temp_rev = cell2mat(L_temp_rev);

K = mat2cell(L_temp_rev * M_temp_tr,size,size2);

%oszczedny DMC
Mp_tmp = cell2mat(Mp);
K1 = cell2mat(K(1,:));
Ku = K1*Mp_tmp;
for i = 1:nu
    for j = 1:ny
        Ke(i,j) = sum(K1(i,j:3:N*ny));
    end
end

%Macierze do przechowywania danych
u_d = zeros(nu,1);
for i = 1:D-1
    u_delta(i,1) = {u_d};
end

y_z = zeros(ny,1);
for i = 1:N
    y_zad_mod(i,1) = {y_z};
end

Y_dmc = zeros(ny,1);
for i=1:N
    y_mod(i,1)={Y_dmc};
end

for i=1:N
    Y0(i,1)={[0;0]};
end

du = zeros(nu,1);
for i=1:Nu
    dU_mod(i,1)={du};
end

%parametry symulacji
kk = 1600;
start = 10;
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

% Symulacja
for k = start:kk
   % Równanie róznicowe
   [y1(k),y2(k),y3(k)] = symulacja_obiektu7(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
       u2(k-1),u2(k-2),u2(k-3),u2(k-4),u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
       u4(k-1),u4(k-2),u4(k-3),u4(k-4),y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
       y2(k-1),y2(k-2),y2(k-3),y2(k-4),y3(k-1),y3(k-2),y3(k-3),y3(k-4)); 
   
   % Regulator 
    delta_y(1) = y1_zad(k) - y1(k);
    delta_y(2) = y2_zad(k) - y2(k);
    delta_y(3) = y3_zad(k) - y3(k);
    
    K1_tmp = Ke*delta_y';
    
    %obliczanie dU
    u_delta_tmp = cell2mat(u_delta);
    Ku_tmp = Ku*u_delta_tmp;
    du = K1_tmp - Ku_tmp;
    
    for n = D-1:-1:2
      u_delta(n) = u_delta(n-1);
    end
   
    u1(k) = u1(k-1) + du(1);
    u2(k) = u2(k-1) + du(2);
    u3(k) = u3(k-1) + du(3);
    u4(k) = u4(k-1) + du(4);
    u_delta(1,1) = {du};
   
   %bledy
   Ey(1) = Ey(1) + (y1_zad(k) - y1(k))^2;
   Ey(2) = Ey(2) + (y2_zad(k) - y2(k))^2;
   Ey(3) = Ey(3) + (y3_zad(k) - y3(k))^2;
   
end

E = sum(Ey)

figure;
subplot(3,1,1);
hold on;
grid on;
stairs(y1,'m');
xlabel('k');
ylabel('y1,y1_z_a_d')
stairs(y1_zad,'k--')
title('Regulator DMC - wyjscie 1')
legend('y1','y1_z_a_d','Location', 'northeast');
subplot(3,1,2);
hold on;
grid on;
stairs(y2,'m');
xlabel('k');
ylabel('y2,y2_z_a_d')
stairs(y2_zad,'k--')
title('Regulator DMC - wyjscie 2')
legend('y2','y2_z_a_d','Location', 'northeast');
subplot(3,1,3);
hold on;
grid on;
stairs(y3,'m');
xlabel('k');
ylabel('y1,y1_z_a_d')
stairs(y3_zad,'k--')
title('Regulator DMC - wyjscie 3')
legend('y3','y3_z_a_d','Location', 'northeast');
figure;
subplot(4,1,1);
hold on;
grid on;
stairs(u1,'g');
xlabel('k');
ylabel('u1')
title('Regulator DMC - sterowanie 1')
legend('u1','Location', 'northeast');
subplot(4,1,2);
hold on;
grid on;
stairs(u2,'g');
xlabel('k');
ylabel('u2')
title('Regulator DMC - sterowanie 2')
legend('u2','Location', 'northeast');
subplot(4,1,3);
hold on;
grid on;
stairs(u3,'g');
xlabel('k');
ylabel('u3')
title('Regulator DMC - sterowanie 3')
legend('u3','Location', 'northeast');
subplot(4,1,4);
hold on;
grid on;
stairs(u4,'g');
xlabel('k');
ylabel('u4')
title('Regulator DMC - sterowanie 4')
legend('u4','Location', 'northeast');

% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/y1.csv", y1, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/y2.csv", y2, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/y3.csv", y3, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/u1.csv", u1, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/u2.csv", u2, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/u3.csv", u3, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/u4.csv", u4, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/y1_zad.csv", y1_zad, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/y2_zad.csv", y2_zad, '\t');
% dlmwrite("../Dane/Zad3_4/DMC/DMC_best/y3_zad.csv", y3_zad, '\t');