addpath('../../../../../../../../matlab2tikz-master/src/');
outputFile = 'proj_zadanie5PID_bez_u1_y.tex';

y1 = dlmread('y1.csv','\t');
y2 = dlmread('y2.csv','\t');
y3 = dlmread('y3.csv','\t');
u1 = dlmread('u1.csv','\t');
u2 = dlmread('u2.csv','\t');
u3 = dlmread('u3.csv','\t');
u4 = dlmread('u4.csv','\t');
y1zad = dlmread('y1_zad.csv','\t');
y2zad = dlmread('y2_zad.csv','\t');
y3zad = dlmread('y3_zad.csv','\t');


% figure(1);
% 
% 
% subplot(4,1, 1);
% plot(u1);
%  ylabel('u_1');
%  xlabel('k');
% grid on;
% 
% subplot(4,1, 2);
% plot(u2);
% ylabel('u_2');
%  xlabel('k');
% grid on;
% 
% subplot(4,1, 3);
% plot(u3);
% ylabel('u_3');
%  xlabel('k');
% grid on;
% 
% subplot(4,1, 4);
% plot(u4);
% ylabel('u_4');
%  xlabel('k');
% grid on;

figure(2);

title('y');

subplot(3,1, 1);
plot(y1);
hold on;
plot(y1zad);
ylabel('y');
xlabel('k');
legend('y_1','y_{1zad}','Location', 'NorthEast');
grid on;
%ylim([0 4]);


subplot(3,1, 2);
plot(y2);
hold on;
plot(y2zad);
ylabel('y');
xlabel('k');
legend('y_2','y_{2zad}','Location', 'NorthEast');
grid on;
%ylim([0 4]);

subplot(3,1, 3);

plot(y3);
hold on;
plot(y3zad);
ylabel('y');
xlabel('k');
legend('y_3','y_{3zad}','Location', 'NorthEast');
grid on;
%ylim([0 4]);


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