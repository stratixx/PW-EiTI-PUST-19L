addpath('../../../matlab2tikz-master/src/');
outputFile = '../../doc/lab/figure/zad4PIDfuzzy.tex';


load('dataPIDfuzzy.mat')
start_ = 500;
end_ = 1800;

u = u(start_:end_);
y = y(start_:end_);
yzad = yzad(start_:end_);

E = sum(abs(y-yzad))/length(y)
x = 1:length(u);

figure(1);

subplot(2,1,1);
hold on;
plot(x,y);
stairs(x,yzad, '--','Linewidth', 1.2);
xlim([min(x) max(x)]);
%title('y');
xlabel('k');
ylabel('y, y^{zad}');
legend('y', 'y^{zad}', 'Location', 'NorthEast');
ylim([floor(min(y)) ceil(0.5+max(y))]);
grid on;
box on;

subplot(2,1,2);
hold on;
plot(x,u);
xlim([min(x) max(x)]);
%title('y');
xlabel('k');
ylabel('u');
legend('u', 'Location', 'NorthEast');
ylim([floor(min(u)) ceil(0.5+max(u))]);
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