%skrypt do realizacji zadania 2
load('skokG132-35W150.mat');
y1 = y(750:1000);
u1 = u(750:1000);
yp = y1(200:end);
y1 = [y1 yp yp yp yp];
up = u1(50:100);
u1 = [u1 up up up up];
load('skokG132-44W150.mat');
y2 = y(43:500);
u2 = u(43:500);
load('skokG132-55W150.mat');
y3 = y(280:730);
u3 = u(280:730);
f = figure('visible','on');
subplot(2,1,1)
hold on; 
grid on; 
plot(y1,'m');
plot(y2,'g');
plot(y3,'r');
title('Wyjscie obiektu')
legend('y(35)','y(44)','y(55)')
xlabel('k');
ylabel('y(k)');
%ylim([30 40]);
subplot(2,1,2)
hold on; 
grid on; 
plot(u1,'m');
plot(u2,'g');
plot(u3,'r');
title('Sterowanie obiektu')
legend('u(35)','u(44)','u(55)');
xlabel('k');
ylabel('u(k)');
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 'zad2y','-dpdf','-bestfit')