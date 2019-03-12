%Skrypt realizujacy algorytm cyfrowego regulatora PID
%inicjalizacja
kk=420; %koniec symulacji

Tp = 0.5;
Kr = 1.35;
Ti = 12;
Td = 2.2;

%nastawy regulatora dyskretnego
r2 = Kr*Td/Tp;
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);

%warunki pocz¹tkowe
u = 0.1*ones(1,kk);
y = zeros(1,kk);
e = zeros(1,kk);
yzad = zeros(1,kk); 
yzad(1,20:kk) = 2;

for k=20:kk %g³ówna pêtla symulacyjna 
%symulacja obiektu 
     y(k) = symulacja_obiektu7Y(u(k-10), u(k-11), y(k-1), y(k-2)); 
%uchyb regulacji 
     e(k) = yzad(k)-y(k); 
%sygna³ steruj¹cy regulatora PID 
     u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
     
     if u(k) > 1.5
         u(k) = 1.5;
     end
     if u(k) < 0.1
         u(k) = 0.1;
     end
%      if u(k) - u(k) > 0.2
%          u(k) = 0.2;
%      end 
     
end

%wyniki symulacji 
figure; 
stairs(u,'y'); 
title('Sygna³ sterujacy u');
xlabel('k');
print('zad4_PID_u','-dpng','-r400')
figure; 
stairs(y,'g'); 
hold on; 
stairs(yzad,':'); 
title('Wykres wyjscia obiektu z PID-em y na tle wartosci zadanej yzad'); 
legend('y(k)','yzad(k)','Location','East')
xlabel('k');
%print('zad4_PID_y','-dpng','-r400')