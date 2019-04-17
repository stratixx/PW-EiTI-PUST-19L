addpath('../../../../matlab2tikz-master/src/');
outputFile = '../../../doc/lab/figure/zad1Setpoint.tex';

% u = dlmread('u.csv','\t');
% y = dlmread('y.csv','\t');
load('u32.mat')
start_ = 500;
end_ = 1000;

u = u(start_:end_);
y = y(start_:end_);

x = 1:length(u);

figure(1);


subplot(2,1, 1);
hold on;
plot(x,y);
xlim([min(x) max(x)]);
%title('y');
%xlabel('k');
ylabel('y');
legend('Wyjœcie', 'Location', 'NorthEast');
ylim([floor(min(y)) ceil(0.5+max(y))]);
grid on;
box on;

subplot(2,1, 2);
hold on;
stairs(x,u);
xlim([min(x) max(x)]);
%title('u');
%xlabel('k');
ylabel('u');
legend('Sterowanie', 'Location', 'NorthEast');
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
hold off;
%close(1)