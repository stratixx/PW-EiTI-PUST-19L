addpath('../../../../../matlab2tikz-master/src/');
outputFile = '../przynalN2.tex';

y = dlmread('y1.csv','\t');
y1 = dlmread('y2.csv','\t');
% y2 = dlmread('y3.csv','\t');
% y3 = dlmread('y4.csv','\t');
% y4 = dlmread('y5.csv','\t');
x = dlmread('x.csv','\t');

%%z = dlmread('zad6_z_best_nie_licz_zakl.csv','\t');
%x = 1:length(x);

figure(1);


%subplot(2,1, 1);
hold on;
plot(x,y);
plot(x,y1);
% plot(x,y2);
% plot(x,y3);
% plot(x,y4);
xlim([min(x) max(x)]);
%title('y');
%xlabel('k');
ylabel('w');
legend('w1', 'w2', 'Location', 'NorthEast');
%ylim([floor(min(y)) ceil(0.5+max(y))]);
grid on;
box on;

% subplot(,1, 2);
% hold on;
% %stairs(x,u);
% plot(x,u);
% plot(x,u1);
% plot(x,u2);
% plot(x,u3);
% plot(x,u4);
% xlim([min(x) max(x)]);
% %title('u');
% %xlabel('k');
% ylabel('u');
% legend('u', 'Location', 'NorthEast');
% grid on;
% box on;

% subplot(3,1, 3);
% hold on;
% stairs(x,z);
% xlim([min(x) max(x)]);
% %title('z');
% xlabel('k');
% ylabel('z');
% legend('z', 'Location', 'NorthEast');
% grid on;
% box on;

% dwie linijki poni�ej zapewniaj� poprawne ustawienie wykresu w pdf-ie
% oraz pozwalaj� nazwa� wykres pod spodem
%beforeFigure = [sprintf('\\begin{figure}[H] \n\\centering')];
%afterFigure = [sprintf('\\caption{%s}\n\\end{figure}', title)];

matlab2tikz(outputFile, ...
    'showInfo', false, ...
    'encoding', 'UTF-8');
%    'extraCode', beforeFigure, ...
%    'extraCodeAtEnd', afterFigure);
hold off;
%close(1)