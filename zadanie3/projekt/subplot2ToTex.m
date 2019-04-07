addpath('../../matlab2tikz-master/src/');
outputFile = '../doc/projekt/figure/zad2StepYZ.tex';

z = dlmread('Dane/Zad2/zad2_z.csv','\t');
y = dlmread('Dane/Zad2/zad2_y_z.csv','\t');
%z = dlmread('zad1_z.csv','\t');
x = 1:length(u);

figure(1);


subplot(2,1, 1);
hold on;
plot(x,y);
xlim([min(x) max(x)]);
%title('y');
%xlabel('k');
ylabel('y');
legend('Wyj�cie', 'Location', 'NorthEast');
grid on;
box on;

subplot(2,1, 2);
hold on;
stairs(x,u);
xlim([min(x) max(x)]);
%title('u');
%xlabel('k');
ylabel('u');
ylabel('z');
legend('Sterowanie', 'Location', 'NorthEast');
legend('Zak��cenie', 'Location', 'NorthEast');
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

%close(1)