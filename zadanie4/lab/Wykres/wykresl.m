
clear
addpath('../../../matlab2tikz-master/src/');
outputFile = 'skoki pid g1 g2 p 30 i 25 d 1.tex';
load('../DANE/skoki pid g1 g2 p 30 i 25 d 1.mat')

%DMC
%dmc g1 g2  75 75 75 0_2

%PID
%skoki pid g1 g2 p 15 i 250 d 0_001 powtorzone - pierwszy pid,
%proporcjonalny
%skoki pid g1 g2 p 15 i 250 d 0_001
%skoki pid g1 g2 p 30 i 25 d 0_001 - sprawdz - drugi PI
%skoki pid g1 g2 p 30 i 25 d 1 - sprawdz - PID dobrany
%skoki pidG1 p 30_1 i 250 d 0_001

%esy

%setpoint

%y1 = dlmread('y1.csv','\t');
% y2 = dlmread('y2.csv','\t');
% y3 = dlmread('y3.csv','\t');
% u1 = dlmread('u1.csv','\t');
% u2 = dlmread('u2.csv','\t');
% u3 = dlmread('u3.csv','\t');
% u4 = dlmread('u4.csv','\t');
% y1zad = dlmread('y1_zad.csv','\t');
% y2zad = dlmread('y2_zad.csv','\t');
% y3zad = dlmread('y3_zad.csv','\t');


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

subplot(2,1, 1);
plot(y1);
hold on;
plot(yz1);
plot(y2);
plot(yz2);
ylabel('y');
xlabel('k');
legend('y_1','y_{1zad}','y_2','y_{2zad}','Location', 'NorthEast');
grid on;
%ylim([0 4]);


subplot(2,1, 2);
plot(g1);
hold on;
plot(g2);
ylabel('y');
xlabel('k');
legend('u_1','u_{2}','Location', 'NorthEast');
grid on;
%ylim([0 4]);
%subplot(3,1, 3);

% plot(y3);
% hold on;
% plot(y3zad);
% ylabel('y');
% xlabel('k');
% legend('y_3','y_{3zad}','Location', 'NorthEast');
% grid on;
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