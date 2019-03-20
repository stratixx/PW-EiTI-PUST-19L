%skrypt do realizacji zadania 3
load('zadanie3.mat');
y1 = s;
u1 = u;
f = figure('visible','on');
subplot(2,1,1)
hold on; 
grid on; 
plot(y1,'m');
title('Znormalizowana odpowiedz skokowa obiektu')
legend('y')
xlabel('k');
ylabel('y(k)');
%ylim([30 40]);
subplot(2,1,2)
hold on; 
grid on; 
plot(u1,'m');
title('Sterowanie obiektu')
legend('u');
xlabel('k');
ylabel('u(k)');
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 'zad3y','-dpdf','-bestfit')