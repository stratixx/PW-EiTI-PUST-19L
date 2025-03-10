%skrypt do realizacji zadania 2 - rysowanie charakterystyki statycznej
run('../danePoczatkowe.m');
start = 20;
kk=410; %koniec symulacji
%warunki poczatkowe
Y = zeros(1,29);
U = zeros(1,29);
for i = 0.1:0.05:1.5
    y=ones(1,kk)*Ypp;
    yzad=ones(1,kk)*Upp; yzad(1,start:kk)=i;
    for k=start:kk %g��wna ptla symulacyjna
        %symulacja obiektu   
        y(k) = symulacja_obiektu7Y(yzad(k-10), yzad(k-11), y(k-1), y(k-2));
    end
    Y(end) = y(end);
    Y = circshift(Y,[0,-1]);
    U(end) = i;
    U = circshift(U,[0,-1]);
    
end
f = figure('visible','on');
hold on; 
grid on; 
plot(U,Y); 
legend('y(u)','Location','East')
title('Charakterystyka statyczna obiektu Y(U)')
xlabel('U')
ylabel('Y')
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 'char_stat','-dpdf','-bestfit')