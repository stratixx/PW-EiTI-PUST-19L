addpath('../../matlab2tikz-master/src/');
outputFile = '../doc/projekt/figure/subplot3.tex';

%u = dlmread('zad1_u.csv','\t');
%y = dlmread('zad1_y.csv','\t');
%z = dlmread('zad1_z.csv','\t');
x = 1:length(u);

figure(1);

subplot(3,1, 1);
hold on;
plot(x,u);
xlim([min(x) max(x)]);
%title('u');
%xlabel('k');
ylabel('u');
legend('Sterowanie', 'Location', 'NorthEast');
grid on;
box on;

subplot(3,1, 2);
hold on;
plot(x,y);
xlim([min(x) max(x)]);
%title('y');
%xlabel('k');
ylabel('y');
legend('Wyjœcie', 'Location', 'NorthEast');
grid on;
box on;

subplot(3,1, 3);
hold on;
plot(x,z);
xlim([min(x) max(x)]);
%title('z');
xlabel('k');
ylabel('z');
legend('Zak³ócenie', 'Location', 'NorthEast');
grid on;
box on;

% dwie linijki poniï¿½ej zapewniajï¿½ poprawne ustawienie wykresu w pdf-ie
% oraz pozwalajï¿½ nazwaï¿½ wykres pod spodem
%beforeFigure = [sprintf('\\begin{figure}[H] \n\\centering')];
%afterFigure = [sprintf('\\caption{%s}\n\\end{figure}', title)];

matlab2tikz(outputFile, ...
    'showInfo', false, ...
    'encoding', 'UTF-8');
%    'extraCode', beforeFigure, ...
%    'extraCodeAtEnd', afterFigure);

close(1)