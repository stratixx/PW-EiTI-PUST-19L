%skrypt do realizacji zadania 2 - odpowiedzi skokowe
f = figure('visible','on');
for u = -0.6:0.3:0.6
run('../danePoczatkowe.m');
start = 20;
kk=415; %koniec symulacji
%warunki poczatkowe
y=ones(1,kk)*Ypp;
yzad=ones(1,kk)*Upp; yzad(1,start:kk)=Upp+u;

for k=start:kk %glowna petla symulacyjna
    %symulacja obiektu   
    y(k) = symulacja_obiektu7Y(yzad(k-10), yzad(k-11), y(k-1), y(k-2));
end
hold on;
grid on;
subplot(2,1,1);
plot(y(start:end));
legend('y(0,2)','y(0,5)','y(0,8)','y(1,1)','y(1,4)')
title('Odpowiedzi skokowe obiektu dla danego y_z_a_d')
xlabel('k')
ylabel('y(k)')
hold off;
hold on;
grid on;
subplot(2,1,2);
plot(yzad(start:end));  
legend('u(0,2)','u(0,5)','u(0,8)','u(1,1)','u(1,4)')
title('Wartosc sterowania obiektu dla danej odpowiedzi skokowej')
xlabel('k')
ylabel('u(k)')
end
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 'odp_skok','-dpdf','-bestfit')
