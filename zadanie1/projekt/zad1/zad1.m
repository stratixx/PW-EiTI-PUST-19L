run('../danePoczatkowe.m');
start = 20;
kk=300; %koniec symulacji
%warunki pocztkowe
u = ones(1,kk)*Upp;
y = zeros(1,kk);
y(1,1:start) = Ypp;
e = zeros(1,kk);

for k=start:kk %g��wna ptla symulacyjna
    %symulacja obiektu   
    y(k) = symulacja_obiektu7Y(u(k-10), u(k-11), y(k-1), y(k-2));
end
figure; 
hold on; 
grid on; 
plot(y);    
legend('y')
figure;
plot(u);
legend('u')
