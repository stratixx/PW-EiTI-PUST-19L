%Skrypt realizujacy algorytm cyfrowego regulatora PID
%inicjalizacja
kk=600; %koniec symulacji
ogr = 1; %wlaczanie ograniczen
E = 0;

%Tp = 0.5;
%Kr = 1.4;
%Td = 2.8;
if 1
if 1
if 1
%for Ti = 7:1:11
%for Kr = 0.5:0.5:2.5
%for Td = 0.5:0.75:6
E = 0;
%nastawy regulatora dyskretnego
r2 = Kr*Td/Tp;
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);

%warunki pocz¹tkowe
u = 0.8*ones(1,kk);
y = 2.2*ones(1,kk);
e = zeros(1,kk);
yzad = 2*ones(1,kk); 
yzad(1,20:300) = 2.5;
%yzad(1,300:600) = 1.5;
%yzad(1,600:1000) = 1.8;

for k=20:kk %g³ówna pêtla symulacyjna 
%symulacja obiektu 
     y(k) = symulacja_obiektu7Y(u(k-10), u(k-11), y(k-1), y(k-2)); 

     %uchyb regulacji 
     e(k) = yzad(k)-y(k); 
%sygna³ steruj¹cy regulatora PID 
     u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
     
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
% figure; 
% stairs(u,'y'); 
% title('Sygna³ sterujacy u');
% xlabel('k');
% print('zad4_PID_u','-dpng','-r400')
figure; 
stairs(y,'g'); 
hold on; 
stairs(yzad,':'); 
title(['Wykres wyjscia obiektu z PID-em y na tle wartosci zadanej yzad',sprintf('%g   ',Ti),sprintf('%g  ',Kr),sprintf('%g  ',Td)]); 
legend('y(k)','yzad(k)','Location','East')
xlabel('k');
%print('zad4_PID_y','-dpng','-r400')
end
end
end