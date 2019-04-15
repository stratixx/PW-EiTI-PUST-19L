function [g] = fun_przyn_lab(z)
g = zeros(3,1);
x = 25:0.001:59;
y = zeros(size(x));
y2 = zeros(size(x));
y3 = zeros(size(x));
for i = 1:1000
    y(i) = x(i) - 25.001;
end
for i = 1001:21500
    y(i) = 1;
end
for i = 21501:22500
    y(i) = -x(i)+47.5;
end
for i = 21501:22500
    y2(i) = x(i)-46.5;
end
for i = 22501:26500
    y2(i) = 1;
end
for i = 26501:27500
    y2(i) = -x(i)+52.5;
end
for i = 26501:27500
    y3(i) = x(i)-51.5;
end
for i = 27500:34001
    y3(i) = 1;
end
y3(end)=0;
for i = 1:34001
    if round(z,3) == round(x(i),3)
        break
    end
end
g(1) = y(i);
g(2) = y2(i);
g(3) = y3(i);
% figure;
% plot(x,y)
% hold on
% plot(x,y2)
% plot(x,y3)    