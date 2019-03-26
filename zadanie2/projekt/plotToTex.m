name = '../doc/projekt/zad2charstat_y.tex';

%u = zad2charstatu;
y = zad2charstaty;
%z = zad2charstatz;
x = 1:length(y);

figure(1);

plot(x,y);
hold on;
xlim([min(x) max(x)]);
title('u');
xlabel('czas');
ylabel('oœ Y');
grid on;
box on;

matlab2tikz(name,'showInfo', false, 'encoding', 'UTF-8');
close(1)