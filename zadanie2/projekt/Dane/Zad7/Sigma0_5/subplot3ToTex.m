addpath('../../../../../matlab2tikz-master/src/');
outputFile = '../../../../doc/projekt/figure/zad7liczSigma0_5.tex';
% outputFile = '../../../doc/projekt/figure/zad7nie_liczSigma0_5.tex';
% outputFile = '../../../doc/projekt/figure/zad6.tex';

u = dlmread('zad7_u_best_licz_zakl_sigma0_5.csv','\t');
y = dlmread('zad7_y_best_licz_zakl_sigma0_5.csv','\t');
%y_zad = dlmread('zad6_y_zad_best_nie_licz_zakl.csv','\t');
z = dlmread('zad7_z_best_licz_zakl_sigma0_5.csv','\t');
% u = dlmread('zad7_u_best_nie_licz_zakl_sigma0_5.csv','\t');
% y = dlmread('zad7_y_best_nie_licz_zakl_sigma0_5.csv','\t');
% %y_zad = dlmread('zad6_y_zad_best_nie_licz_zakl.csv','\t');
% z = dlmread('zad7_z_best_nie_licz_zakl_sigma0_5.csv','\t');

% u = dlmread('zad5_u_best_nie_licz_zakl.csv','\t');
% y = dlmread('zad5_y_best_nie_licz_zakl.csv','\t');
% y_zad = dlmread('zad5_y_zad_best_nie_licz_zakl.csv','\t');
% z = dlmread('zad5_z_best_nie_licz_zakl.csv','\t');

x = 1:length(u);

figure(1);

subplot(3,1, 2);
hold on;
stairs(x,u);
xlim([min(x) max(x)]);
%title('u');
%xlabel('k');
ylabel('u');
legend('Sterowanie', 'Location', 'NorthEast');
grid on;
box on;

subplot(3,1,1);
hold on;
stairs(x,y);
%stairs(x,y_zad);
xlim([min(x) max(x)]);
%title('y');
%xlabel('k');
ylabel('y');
legend('Wyjœcie',  'Location', 'NorthEast');
grid on;
box on;

subplot(3,1, 3);
hold on;
stairs(x,z);
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

%close(1)