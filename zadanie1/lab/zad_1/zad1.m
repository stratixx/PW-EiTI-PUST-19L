%skrypt do realizacji zadania 1
load('pp.mat');
y1 = y(302:500);
u1 = u(302:500);
f = figure('visible','on');
subplot(2,1,1)
hold on; 
grid on; 
plot(y1,'m');
title('Wyjscie obiektu')
legend('y')
xlabel('k');
ylabel('y(k)');
ylim([30 40]);
subplot(2,1,2)
hold on; 
grid on; 
plot(u1,'g');
title('Sterowanie obiektu')
legend('u');
xlabel('k');
ylabel('u(k)');
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 'y','-dpdf','-bestfit')