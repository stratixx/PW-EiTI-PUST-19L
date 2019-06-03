addpath('../../../../../../../../matlab2tikz-master/src/');
outputFile = 'proj_zadanie5PID_bez_u3_u.tex';

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

subplot(4,1, 1);
plot(u1);
hold on;
%plot(y1zad);
ylabel('u');
xlabel('k');
legend('u1','Location', 'NorthEast');
grid on;
%ylim([0 4]);


subplot(4,1, 2);
plot(u2);
hold on;
%plot(y2zad);
ylabel('u');
xlabel('k');
legend('u2','Location', 'NorthEast');
grid on;
%ylim([0 4]);

subplot(4,1, 3);

plot(u3);
hold on;
%plot(y3zad);
ylabel('u');
xlabel('k');
legend('u3','Location', 'NorthEast');
grid on;
%ylim([0 4]);

subplot(4,1, 4);

plot(u4);
hold on;
%plot(y3zad);
ylabel('u');
xlabel('k');
legend('u4','Location', 'NorthEast');
grid on;


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