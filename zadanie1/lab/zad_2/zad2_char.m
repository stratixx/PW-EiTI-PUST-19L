%skrypt do realizacji zadania 2 char stat
y1 = [36.8 37.8 40.8 44.5];
u1 = [33 35 44 55];
f = figure('visible','on');
plot(u1,y1)
hold on; 
grid on; 
title('Charakterystyka statyczna obiektu')
legend('y(u)');
xlabel('U');
ylabel('Y');
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 'char_stat','-dpdf','-bestfit')