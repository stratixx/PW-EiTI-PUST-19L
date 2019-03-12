run('../danePoczatkowe.m');
start = 20;
kk=410; %koniec symulacji
%warunki pocztkowe
y=ones(1,kk)*Ypp;
yzad=ones(1,kk)*Upp; yzad(1,start:kk)=Upp+0.1;

for k=start:kk; %g��wna ptla symulacyjna
    %symulacja obiektu   
    y(k) = symulacja_obiektu7Y(yzad(k-10), yzad(k-11), y(k-1), y(k-2));
end
hold off;
figure(2); 
hold on; 
grid on; 
plot(y(start:end));  
%plot(u(start:end));  
legend('y', 'u')
