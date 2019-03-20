%zadanie 4 i 5 - Skrypt realizujacy algorytm cyfrowego regulatora PID
%inicjalizacja
kk=2500; %koniec symulacji
ogr = 1; %wlaczanie ograniczen
E = 0;%wspolczynnik jakosci regualcji
%nastawy regulatora
Tp = 0.5;
Kr = 0.3;
Ti = 8.5;
Td = 0.2;
%nastawy regulatora dyskretnego
r2 = Kr*Td/Tp;
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);

%warunki pocz¹tkowe
u = 0.8*ones(1,kk);
y = 2*ones(1,kk);
e = zeros(1,kk);
yzad = 2*ones(1,kk); 
yzad(1,100:500) = 2.5;
yzad(1,500:900) = 1.8;
yzad(1,900:1300) = 2.2;
yzad(1,1300:1700) = 2.5;
yzad(1,1700:2100) = 2.0;
yzad(1,2100:kk) = 1.6;

for k=20:kk %glowna petla symulacyjna 
%symulacja obiektu 
     y(k) = symulacja_obiektu7Y(u(k-10), u(k-11), y(k-1), y(k-2)); 

     %uchyb regulacji 
     e(k) = yzad(k)-y(k); 
     %sygna³ steruj¹cy regulatora PID 
     u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
     %ograniczenia
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
     E = E + (yzad(k) - y(k))^2;
end
E
%wyniki symulacji 
f = figure('visible','on');
hold on;
grid on;
stairs(u,'m'); 
title('Sygna³ sterujacy u regulatora PID');
xlabel('k');
ylabel('u(k)');
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 'u_best','-dpdf','-bestfit')
g = figure('visible','on'); 
stairs(y,'g'); 
hold on;
grid on;
stairs(yzad,':'); 
title({'Wykres wyjscia obiektu z PID-em y na tle wartosci zadanej y_z_a_d';['\color[rgb]{0 .5 .5}Kr = ',sprintf('%g',Kr),' Ti = ',sprintf('%g',Ti),' Td = ',sprintf('%g',Td),' E = ',sprintf('%g',E)]}); 
legend('y(k)','yzad(k)','Location','Southeast')
xlabel('k');
ylabel('y,y_z_a_d');
fig_pos = g.PaperPosition;
g.PaperSize = [fig_pos(3) fig_pos(4)];
print(g, 'y_best','-dpdf','-bestfit')