name = '../doc/projekt/zad2charstat_u_y.tex';

u = zad2charstatu;
y = zad2charstaty;
%z = zad2charstatz;
x = 1:length(u);

figure(1);

subplot(2,1, 1);
hold on;
plot(x,u);
xlim([min(x) max(x)]);
title('u');
xlabel('czas');
ylabel('oœ Y');
grid on;
box on;

subplot(2,1, 2);
hold on;
plot(x,y);
xlim([min(x) max(x)]);
title('y');
xlabel('czas');
ylabel('oœ Y');
grid on;
box on;

matlab2tikz(name,'showInfo', false, 'encoding', 'UTF-8');
close(1)