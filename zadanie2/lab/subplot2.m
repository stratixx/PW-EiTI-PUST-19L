addpath('../../../matlab2tikz-master/src/');
outputFile = '../../doc/lab/figure/zad2StepsZ.tex';

%u = dlmread('z.csv','\t');
y = dlmread('y_0_10.csv','\t');
z = dlmread('z_0_10.csv','\t');
u=z;
x = 1:length(u);

figure(1);


subplot(2,1, 1);
hold on;
y = dlmread('y_0_30.csv','\t');
plot(y);
y = dlmread('y_0_15.csv','\t');
plot(y);
y = dlmread('y_0_10.csv','\t');
plot(y);
xlim([0 350]);
%title('y');
%xlabel('k');
ylabel('y');
legend('y1', 'y2', 'y3', 'Location', 'NorthEast');
%ylim([floor(min(y)) ceil(0.5+max(y))]);
grid on;
box on;


subplot(2,1,2);
hold on;
z = dlmread('z_0_30.csv','\t');
stairs(z);
z = dlmread('z_0_15.csv','\t');
stairs(z);
z = dlmread('z_0_10.csv','\t');
stairs(z);
xlim([0 350]);
%title('z');
xlabel('k');
ylabel('z');
legend('z1', 'z2', 'z3', 'Location', 'NorthEast');
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