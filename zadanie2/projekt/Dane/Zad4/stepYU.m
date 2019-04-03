addpath('../../../../matlab2tikz-master/src/');
outputFile = '../../../doc/projekt/figure/zad4YU.tex';
% 
% u = dlmread('zad2_u.csv','\t');
u = dlmread('zad4_y_best.csv','\t');
%z = dlmread('zad1_z.csv','\t');
x = 1:length(u);

figure(1);


subplot(2,1, 1);
hold on;
y = dlmread('zad4_y_1.csv','\t');
plot(x,y);
y = dlmread('zad4_y_best.csv','\t');
plot(x,y);
xlim([min(x) 150]);
%title('y');
%xlabel('k');
ylabel('y');
legend('y1', 'ybest', 'Location', 'NorthEast');
grid on;
box on;

subplot(2,1, 2);
hold on;
u = dlmread('zad4_u_1.csv','\t');
stairs(x,u);
u = dlmread('zad4_u_best.csv','\t');
stairs(x,u);
xlim([min(x) 150]);
%title('u');
xlabel('k');
ylabel('u');
legend('u1', 'ubest', 'Location', 'NorthEast');
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