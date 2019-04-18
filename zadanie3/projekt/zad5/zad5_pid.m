%zadanie 5 - Skrypt realizujacy algorytm rozmytego cyfrowego regulatora PID
%inicjalizacja
kk=1800; %koniec symulacji
start = 20;
E = 0;%wspolczynnik jakosci regualcji
Tp = 0.5;
fuzzyN = 5;%ilosc regulatorow
% regulacja z u?yciem regulatora PID fuzzy 
[Kr,Ti,Td] = nastawy_PID(fuzzyN);%nastawy dla opd. ilosci regulatorow
settings = [];

for n=1:fuzzyN
    settings(n).Tp = Tp;
    settings(n).r0 = Kr(n)*(1+Tp/(2*Ti(n))+Td(n)/Tp);
    settings(n).r1 = Kr(n)*(Tp/(2*Ti(n))-2*Td(n)/Tp-1);
    settings(n).r2 = Kr(n)*Td(n)/Tp;
    settings(n).u1 = 0;
end

%warunki pocz¹tkowe
u = zeros(1,kk);
y = zeros(1,kk);
e = zeros(1,kk);
yzad = zeros(1,kk);
yzad(1,20:200) = -2;
yzad(1,200:400) = -4.5;
yzad(1,400:600) = -3;
yzad(1,600:800) = -1.5;
yzad(1,800:1000) = -3.5;
yzad(1,1000:1200) = -1.2;
yzad(1,1200:1400) = -0.3;
yzad(1,1400:1600) = 0;
yzad(1,1600:kk) = 0.1;


for k=20:kk %glowna petla symulacyjna 
%symulacja obiektu 
     y(k)=symulacja_obiektu7y(u(k-5),u(k-6),y(k-1),y(k-2)); 
     g = f_przyn(round(y(k),2),fuzzyN);
     %uchyb regulacji 
     e(k) = yzad(k)-y(k);
     
     u_ = zeros(1, fuzzyN);
    for n=1:fuzzyN
        %wyznaczenie nowej warto?ci sterowania od regulatora
        u_(n) = (settings(n).r2*e(k-2)+settings(n).r1*e(k-1)+settings(n).r0*e(k)+u(k-1))*g(n);
        %na?o?enie ogranicze? sterowania
        if( u_(n)>1.0 ) 
            u_(n) = 1.0;
        elseif( u_(n)<-1.0 )
            u_(n) = -1.0;
        end
        u_(n) = u_(n)*g(n);
        %regulator mo?e u?y? poprzedniej warto?ci sterowania
        settings(n).u1 = u_(n);

    end    
     % wyznaczenie sterowania rozmytego
     u(k) = sum(u_);
     %ograniczenia
     if u(k) > 1.0
         u(k) = 1.0;
     end
     if u(k) < -1.0
         u(k) = -1.0;
     end
     E = E + (yzad(k) - y(k))^2;
end
E
%wyniki symulacji 
subplot(2,1,1);
stairs(y,'g'); 
hold on;
grid on;
stairs(yzad,':'); 
title({'Wykres wyjscia obiektu z rozmytym PID-em y na tle wartosci zadanej y_z_a_d';['\color[rgb]{0 .5 .5}Kr = ',sprintf('%g',Kr),' Ti = ',sprintf('%g',Ti),' Td = ',sprintf('%g',Td),' E = ',sprintf('%g',E)]}); 
legend('y(k)','yzad(k)','Location','Southeast')
xlabel('k');
ylabel('y,y_z_a_d');
subplot(2,1,2);
hold on;
grid on;
stairs(u,'m'); 
title('Sygna³ sterujacy u regulatora PID');
xlabel('k');
ylabel('u(k)');
% dlmwrite('../Dane/Zad5/PID/PID5/u.csv', u, '\t');
% dlmwrite('../Dane/Zad5/PID/PID5/y.csv', y, '\t');
% dlmwrite('../Dane/Zad5/PID/PID5/y_zad.csv', yzad, '\t');