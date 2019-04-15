%zadanie 3 i 4 - Skrypt realizujacy algorytm cyfrowego regulatora PID
%inicjalizacja
kk=1800; %koniec symulacji
start = 20;
E = 0;%wspolczynnik jakosci regualcji
%nastawy regulatora
Tp = 0.5;
Kr = 0.145;
Ti = 3.3;
Td = 1.03;
%nastawy regulatora dyskretnego
r2 = Kr*Td/Tp;
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);

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

     %uchyb regulacji 
     e(k) = yzad(k)-y(k); 
     %sygna³ steruj¹cy regulatora PID 
     u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
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
title({'Wykres wyjscia obiektu z PID-em y na tle wartosci zadanej y_z_a_d';['\color[rgb]{0 .5 .5}Kr = ',sprintf('%g',Kr),' Ti = ',sprintf('%g',Ti),' Td = ',sprintf('%g',Td),' E = ',sprintf('%g',E)]}); 
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
dlmwrite('../Dane/zad3/u.csv', u, '\t');
dlmwrite('../Dane/zad3/y.csv', y, '\t');