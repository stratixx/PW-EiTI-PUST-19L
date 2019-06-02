addpath('../../../../../../matlab2tikz-master/src/');
outputFile = 'proj_zadanie1u.tex';

y1 = dlmread('zad1_y1.csv','\t');
y2 = dlmread('zad1_y2.csv','\t');
y3 = dlmread('zad1_y3.csv','\t');
u1 = dlmread('zad1_u1.csv','\t');
u2 = dlmread('zad1_u2.csv','\t');
u3 = dlmread('zad1_u3.csv','\t');
u4 = dlmread('zad1_u4.csv','\t');

%%z = dlmread('zad6_z_best_nie_licz_zakl.csv','\t');
%x = 1:length(x);

figure(1);


subplot(4,1, 1);
plot(u1);
ylabel('u_1');
xlabel('k');
grid on;
legend('u1', 'Location', 'NorthEast');

subplot(4,1, 2);
plot(u2);
ylabel('u_2');
 xlabel('k');
grid on;
legend('u2', 'Location', 'NorthEast');

subplot(4,1, 3);
plot(u3);
ylabel('u_3');
 xlabel('k');
grid on;
legend('u3', 'Location', 'NorthEast');

subplot(4,1, 4);
plot(u4);
ylabel('u_4');
 xlabel('k');
grid on;
legend('u4', 'Location', 'NorthEast');

% figure(2);
% 
% subplot(3,1, 1);
% plot(y1);
% ylabel('y_1');
%  xlabel('k');
% grid on;
% 
% subplot(3,1, 2);
% plot(y2);
% ylabel('y_2');
%  xlabel('k');
% grid on;
% 
% subplot(3,1, 3);
% 
% plot(y3);
% %xlim([min(x) max(x)]);
% %title('y');
% %xlabel('k');
% 
% ylabel('y_3');
%  xlabel('k');
%legend('y', 'Location', 'NorthEast');
%ylim([floor(min(y)) ceil(0.5+max(y))]);
grid on;
box on;

% subplot(,1, 2);
% hold on;
% %stairs(x,u);
% plot(x,u);
% plot(x,u1);
% plot(x,u2);
% plot(x,u3);
% plot(x,u4);
% xlim([min(x) max(x)]);
% %title('u');
% %xlabel('k');
% ylabel('u');
% legend('u', 'Location', 'NorthEast');
% grid on;
% box on;

% subplot(3,1, 3);
% hold on;
% stairs(x,z);
% xlim([min(x) max(x)]);
% %title('z');
% xlabel('k');
% ylabel('z');
% legend('z', 'Location', 'NorthEast');
% grid on;
% box on;

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