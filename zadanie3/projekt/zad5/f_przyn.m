n =4;
x = - 4.77:0.01:0.15;
y = zeros(size(x));
y2 = zeros(size(x));
y3 = zeros(size(x));
y4 = zeros(size(x));
y5 = zeros(size(x));
if n == 2
    for i = 1:100
        y(i) = x(i) + 4.7747;
    end
    for i = 101:467
        y(i) = 1;
    end
    for i = 468:473
        y(i) = -16.67*x(i)-0.8337;
    end
    for i = 468:473
        y2(i) = 16.67*x(i)+1.8337;
    end
    for i = 473:493
        y2(i) = 1;
    end
    y2(end)=0;
end
if n == 3
    for i = 1:100
        y(i) = x(i) + 4.7747;
    end
    for i = 101:450
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
    for i = 469:474
        y2(i) = -16.67*x(i)-0.6700;
    end
    for i = 469:474
        y3(i) = 16.67*x(i)+1.6700;
    end
    for i = 474:493
        y3(i) = 1;
    end
    y3(end)=0;
end
if n == 4
    for i = 1:100
        y(i) = x(i) + 4.7747;
    end
    for i = 101:441
        y(i) = 1;
    end
    for i = 442:447
        y(i) = -16.67*x(i)-5.1679;
    end
    for i = 442:447
        y2(i) = 16.67*x(i)+6.1679;
    end
    for i = 448:457
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
plot(x,y)
hold on
plot(x,y2)
if n >= 3
    plot(x,y3)
end
if n >=4  
    plot(x,y4)
end
if n == 5
    plot(x,y5)
end
    