function [g] = f_przyn(z,n)
g = zeros(n,1);
x = -4.77:0.01:0.15;
y = zeros(size(x));
y2 = zeros(size(x));
y3 = zeros(size(x));
y4 = zeros(size(x));
y5 = zeros(size(x));
if n == 2
    for i = 1:467
        y(i) = 1;
    end
    for i = 467:473
        y(i) = -16.67*x(i)-0.8337;
    end
    for i = 467:473
        y2(i) = 16.67*x(i)+1.8337;
    end
    for i = 473:493
        y2(i) = 1;
    end
    y2(end)=0;
end
if n == 3
    for i = 1:450
        y(i) = 1;
    end
    for i = 451:456
        y(i) = -16.67*x(i)-3.6676;
    end
    for i = 451:456
        y2(i) = 16.67*x(i)+4.6676;
    end
    for i = 456:468
        y2(i) = 1;
    end
    for i = 468:474
        y2(i) = -16.67*x(i)-0.6700;
    end
    for i = 468:474
        y3(i) = 16.67*x(i)+1.6700;
    end
    for i = 474:493
        y3(i) = 1;
    end
    y3(end)=0;
end
if n == 4
    for i = 1:441
        y(i) = 1;
    end
    for i = 441:447
        y(i) = -16.67*x(i)-5.1679;
    end
    for i = 441:447
        y2(i) = 16.67*x(i)+6.1679;
    end
    for i = 447:457
        y2(i) = 1;
    end
    for i = 458:463
        y2(i) = -16.67*x(i)-2.3340;
    end
    for i = 458:463
        y3(i) = 16.67*x(i)+3.3340;
    end
    for i = 463:482
        y3(i) = 1;
    end
    for i = 483:488
        y3(i) = -16.67*x(i)+1.6668;
    end
    for i = 483:488
        y4(i) = 16.67*x(i)-0.6668;
    end
    for i = 488:493
        y4(i) = 1;
    end
    y4(end)=0;
end
if n == 5
    for i = 1:439
        y(i) = 1;
    end
    for i = 440:445
        y(i) = -16.67*x(i)-5.3346;
    end
    for i = 440:445
        y2(i) = 16.67*x(i)+6.3346;
    end
    for i = 445:462
        y2(i) = 1;
    end
    for i = 463:468
        y2(i) = -16.67*x(i)-1.5005;
    end
    for i = 463:468
        y3(i) = 16.67*x(i)+2.5005;
    end
    for i = 468:470
        y3(i) = 1;
    end
    for i = 471:477
        y3(i) = -16.67*x(i)-0.1669;
    end
    for i = 471:477
        y4(i) = 16.67*x(i)+1.1669;
    end
    for i = 477:483
        y4(i) = 1;
    end
    for i = 484:489
        y4(i) = -16.67*x(i)+2.0002;
    end
    for i = 484:489
        y5(i) = 16.67*x(i)-1.0002;
    end
    for i = 489:493
        y5(i) = 1;
    end
    y5(end)=0;
end
for i = 1:493
    if z == round(x(i),2)
        break
    end
end
g(1) = y(i);
g(2) = y2(i); 
%figure;
%plot(x,y)
%hold on
%plot(x,y2)
if n >= 3
    %plot(x,y3)
    g(3) = y3(i);
end
if n >=4  
    %plot(x,y4)
    g(4) = y4(i);
end
if n == 5
    %plot(x,y5)
    g(5) = y5(i);
end