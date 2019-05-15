%skrypt do realizacji zadania 2
start = 5;
kk = 904; %koniec symulacji
%warunki poczatkowe
u1 = zeros(1,kk);
u2 = zeros(1,kk);
u3 = zeros(1,kk);
u4 = zeros(1,kk);
y1 = zeros(1,kk);
y2 = zeros(1,kk);
y3 = zeros(1,kk);
m = 3;
n = 4;
i = 1;

for j = 1:n
    u1 = zeros(1,kk);
    u2 = zeros(1,kk);
    u3 = zeros(1,kk);
    u4 = zeros(1,kk);
    y1 = zeros(1,kk);
    y2 = zeros(1,kk);
    y3 = zeros(1,kk);
    if j == 1
        u1 = ones(start,kk);
    elseif j == 2
        u2 = ones(start,kk);
    elseif j == 3
        u3 = ones(start,kk); 
    elseif j == 4
        u4 = ones(start,kk);
     end
    for k = start:kk %glowna petla symulacyjna
        %symulacja obiektu   
        [y1(k),y2(k),y3(k)] = symulacja_obiektu7(u1(k-1),u1(k-2),u1(k-3),u1(k-4),u2(k-1),u2(k-2),u2(k-3),u2(k-4),u3(k-1),u3(k-2),u3(k-3),u3(k-4),u4(k-1),u4(k-2),u4(k-3),u4(k-4),y1(k-1),y1(k-2),y1(k-3),y1(k-4),y2(k-1),y2(k-2),y2(k-3),y2(k-4),y3(k-1),y3(k-2),y3(k-3),y3(k-4));
    end
    y1 = y1(start:end);
    y2 = y2(start:end);
    y3 = y3(start:end);
    if j == 1
        s11 = y1;
        s21 = y2;
        s31 = y3;
    elseif j == 2
        s12 = y1;
        s22 = y2;
        s32 = y3;
    elseif j == 3
        s13 = y1;
        s23 = y2;
        s33 = y3;
    elseif j == 4
        s14 = y1;
        s24 = y2;
        s34 = y3;
     end
    subplot(4,3,i)
    grid on; 
    plot(y1);
    hold on;
    title(['y_1 od u_',num2str(j)])
    xlabel('k');
    ylabel('y_1(k)');
    subplot(4,3,i+1)
    grid on; 
    plot(y2);
    hold on;
    title(['y_2 od u_',num2str(j)])
    xlabel('k');
    ylabel('y_2(k)');
    subplot(4,3,i+2)
    grid on; 
    plot(y3);
    hold on;
    title(['y_3 od u_',num2str(j)])
    xlabel('k');
    ylabel('y_3(k)');
    i = i+3;
    if j == 1
        dlmwrite("../Dane/Zad2/u1/zad2_y1_u1.csv", y1, '\t');
        dlmwrite("../Dane/Zad2/u1/zad2_y2_u1.csv", y2, '\t');
        dlmwrite("../Dane/Zad2/u1/zad2_y3_u1.csv", y3, '\t');
    elseif j == 2
        dlmwrite("../Dane/Zad2/u2/zad2_y1_u2.csv", y1, '\t');
        dlmwrite("../Dane/Zad2/u2/zad2_y2_u2.csv", y2, '\t');
        dlmwrite("../Dane/Zad2/u2/zad2_y3_u2.csv", y3, '\t');
    elseif j == 3
        dlmwrite("../Dane/Zad2/u3/zad2_y1_u3.csv", y1, '\t');
        dlmwrite("../Dane/Zad2/u3/zad2_y2_u3.csv", y2, '\t');
        dlmwrite("../Dane/Zad2/u3/zad2_y3_u3.csv", y3, '\t');
    elseif j == 4
        dlmwrite("../Dane/Zad2/u4/zad2_y1_u4.csv", y1, '\t');
        dlmwrite("../Dane/Zad2/u4/zad2_y2_u4.csv", y2, '\t');
        dlmwrite("../Dane/Zad2/u4/zad2_y3_u4.csv", y3, '\t');
    end
end