addpath('../../../../matlab2tikz-master/src/');
outputFile = '../../../doc/lab/figure/zad2charStat.tex';


load('charakterstat.mat')
start_ = 1;
end_ = 7;

u = uu(start_:end_);
y = yy(start_:end_);

x = u;

figure(1);


hold on;
plot(x,y, '*-');
xlim([min(x) max(x)]);
%title('y');
xlabel('U');
ylabel('Y');
legend('Y(U)', 'Location', 'NorthEast');
ylim([floor(min(y)) ceil(0.5+max(y))]);
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