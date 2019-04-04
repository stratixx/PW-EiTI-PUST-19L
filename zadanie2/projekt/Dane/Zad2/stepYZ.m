addpath('../../../../matlab2tikz-master/src/');
outputFile = '../../../doc/projekt/figure/zad2StepYZ.tex';

u = dlmread('zad2_z.csv','\t');
y = dlmread('zad2_y_z.csv','\t');
%z = dlmread('zad1_z.csv','\t');
x = 1:length(u);

figure(1);


subplot(2,1, 1);
hold on;
y = dlmread('z/zad2_y_z2.csv','\t');
plot(x,y);
y = dlmread('z/zad2_y_z1.csv','\t');
plot(x,y);
y = dlmread('z/zad2_y_z0.csv','\t');
plot(x,y);
y = dlmread('z/zad2_y_z-1.csv','\t');
plot(x,y);
y = dlmread('z/zad2_y_z-2.csv','\t');
plot(x,y);
xlim([min(x) 150]);
%title('y');
%xlabel('k');
ylabel('y');
legend('2', '1', '0', '-1', '-2', 'Location', 'NorthEast');
grid on;
box on;

subplot(2,1, 2);
hold on;
u = dlmread('z/zad2_z 2.csv','\t');
stairs(x,u);
u = dlmread('z/zad2_z1.csv','\t');
stairs(x,u);
u = dlmread('z/zad2_z0.csv','\t');
stairs(x,u);
u = dlmread('z/zad2_z-1.csv','\t');
stairs(x,u);
u = dlmread('z/zad2_z-2.csv','\t');
stairs(x,u);
xlim([min(x) 150]);
%title('u');
xlabel('k');
ylabel('z');
legend('2', '1', '0', '-1', '-2', 'Location', 'NorthEast');
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