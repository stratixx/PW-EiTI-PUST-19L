function [E] = fun(in)

Kr=in(1);
Ti=in(2);
Td=in(3);

Tp = 0.5;
kk = 600;
r2 = Kr*Td/Tp;
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
E = 0;
%warunki pocz¹tkowe
u = 0.8*ones(1,kk);
y = 2*ones(1,kk);
e = zeros(1,kk);
yzad = 2*ones(1,kk); 
yzad(1,100:300) = 2.5;
for k=20:kk %g³ówna pêtla symulacyjna
    y(k) = symulacja_obiektu7Y(u(k-10), u(k-11), y(k-1), y(k-2));
   
%uchyb regulacji 
     e(k) = yzad(k)-y(k); 
%sygna³ steruj¹cy regulatora PID 
     u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
     
     
     if u(k) - u(k-1) > 0.2
          u(k) = 0.2 + u(k-1);
     end 
     if u(k) - u(k-1) < -0.2
          u(k) = u(k-1)-0.2;
     end
     if u(k) > 1.5
         u(k) = 1.5;
     end
     if u(k) < 0.1
         u(k) = 0.1;
     end
     E = E + (yzad(k) - y(k))^2;
end

if 0
    figure(1)
    hold on;
    plot(y)
    plot(yzad)
    title('y, y_z_a_d');
    figure(2)
    hold on;
    plot(u)
    title('u');
end
end
