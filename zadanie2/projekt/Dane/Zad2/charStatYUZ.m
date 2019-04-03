addpath('../../../../matlab2tikz-master/src/');
outputFile = '../../../doc/projekt/figure/zad2charStatYUZ.tex';

u = dlmread('zad2_char_stat_u.csv','\t');
z = dlmread('zad2_char_stat_z.csv','\t');
y = dlmread('zad2_char_stat_y.csv','\t');
x = 1:length(u);

figure(1);

mesh(u,z,y);

hold on;
%plot(x,y);
%xlim([min(x) max(x)]);
%title('y');
xlabel('U');
ylabel('Z');
zlabel('Y');
legend('Y(U, Z)', 'Location', 'NorthEast');
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