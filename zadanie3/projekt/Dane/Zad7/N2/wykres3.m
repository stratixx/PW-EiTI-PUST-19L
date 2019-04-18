addpath('../../../../../matlab2tikz-master/src/');
outputFile = '../../../../doc/projekt/figure/z7DMC2.tex';

load('nastawy_blad');
y = dlmread('y.csv','\t');
yzad = dlmread('y_zad.csv','\t');
%y2 = dlmread('y3.csv','\t');
%y3 = dlmread('y4.csv','\t');
%y4 = dlmread('y5.csv','\t');
u = dlmread('u.csv','\t');

%%z = dlmread('zad6_z_best_nie_licz_zakl.csv','\t');
x = 1:length(u);

figure(1);


subplot(2,1, 1);
hold on;
plot(x,y);
plot(x,yzad, '--');
%plot(x,y2);
%plot(x,y3);
%plot(x,y4);
xlim([min(x) max(x)]);
title1 = strcat('E= ', num2str(E));
title2 = strcat('N= [',num2str(N, 4), ']');
title3 = strcat('N_u= [',num2str(Nu, 4), ']');
title4 = strcat('lambda= [',num2str(lambda, 4), ']');
title({title1,title2,title3,title4});
xlabel('k');
ylabel('y');
legend('Wyjœcie y', 'Wartoœæ zadana y_{zad}', 'Location', 'NorthEast');
%ylim([floor(min(y)) ceil(0.5+max(y))]);
grid on;
box on;

 subplot(2,1, 2);
 hold on;
 %stairs(x,u);
 plot(x,u);
 %plot(x,u1);
% plot(x,u2);
% plot(x,u3);
% plot(x,u4);
 xlim([min(x) max(x)]);
 %title('u');
xlabel('k');
 ylabel('u');
 legend('Sterowanie u', 'Location', 'NorthEast');
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