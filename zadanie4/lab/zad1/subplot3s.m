addpath('../../../matlab2tikz-master/src/');
outputFile = '../../doc/lab/figure/zad1Setpoint.tex';

u = dlmread('u.csv','\t');
y = dlmread('y.csv','\t');
z = dlmread('z.csv','\t');
x = 1:length(u);

figure(1);


subplot(3,1, 1);
hold on;
plot(x,y);
xlim([min(x) max(x)]);
%title('y');
%xlabel('k');
ylabel('y');
legend('y', 'Location', 'NorthEast');
ylim([floor(min(y)) ceil(0.5+max(y))]);
grid on;
box on;

subplot(3,1, 2);
hold on;
stairs(x,u);
xlim([min(x) max(x)]);
%title('u');
%xlabel('k');
ylabel('u');
legend('u', 'Location', 'NorthEast');
grid on;
box on;

subplot(3,1, 3);
hold on;
stairs(x,z);
xlim([min(x) max(x)]);
%title('z');
xlabel('k');
ylabel('z');
legend('z', 'Location', 'NorthEast');
grid on;
box on;

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