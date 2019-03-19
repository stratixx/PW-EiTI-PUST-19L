run('danePoczatkowe.m');
u = 0.7;
start = 20;
kk=410; %koniec symulacji
%warunki poczatkowe
y=ones(1,kk)*Ypp;
yzad=ones(1,kk)*Upp; yzad(1,start:kk)=Upp+u;
for k=start:kk %glowna petla symulacyjna
    %symulacja obiektu   
    y(k) = symulacja_obiektu7Y(yzad(k-10), yzad(k-11), y(k-1), y(k-2));
end
plot(y)
hold on
plot(yzad)
y1 = y(20:220);
s = (y1-2)./u;
figure;
plot(s)
hold on 
title('Odpowiedz skokowa dla regulatora DMC')
xlabel('k')
ylabel('y(k)')

