function [g] = fun_przyn_lab(z)
g = zeros(3,1);
x = 25:0.1:59;
y = zeros(size(x));
y2 = zeros(size(x));
y3 = zeros(size(x));
for i = 1:10
    y(i) = x(i) - 25.001;
end
for i = 11:215
    y(i) = 1;
end
for i = 216:225
    y(i) = -x(i)+47.5;
end
for i = 216:225
    y2(i) = x(i)-46.5;
end
for i = 226:265
    y2(i) = 1;
end
for i = 266:275
    y2(i) = -x(i)+52.5;
end
for i = 266:275
    y3(i) = x(i)-51.5;
end
for i = 276:341
    y3(i) = 1;
end
y3(end)=0;
for i = 1:341
    if round(z,1) == round(x(i),1)
        break
    end
end
g(1) = y(i);
g(2) = y2(i);
g(3) = y3(i);
% size(y)
% size(y2)
% size(y3)
% size(x)
% figure;
% plot(x,y,'Linewidth', 1.2)
% hold on
% plot(x,y2,'Linewidth', 1.2)
% plot(x,y3,'Linewidth', 1.2) 
% grid on;
% box on;
% legend('w1','w2','w3','Location','East');
% xlabel('Temperatura obiektu')
% ylabel('Wartoœæ funkcji przynale¿noœci')
% ylim([-0.2 1.2])
% xlim([25 59])
% 
% addpath('../../matlab2tikz-master/src/');
% outputFile = '../doc/lab/figure/zad4fuzzyFunction.tex';
% 
% matlab2tikz(outputFile, ...
%     'showInfo', false, ...
%     'encoding', 'UTF-8');
% %    'extraCode', beforeFigure, ...
% %    'extraCodeAtEnd', afterFigure);
% hold off;