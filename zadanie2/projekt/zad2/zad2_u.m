%skrypt do realizacji zadania 2
uz = 1;%wybor odpowiedzi u - 1/z - 0
Upp = 0;
Ypp = 0;
Zpp = 0;
for x = -2:1:2
    start = 10;
    kk=300; %koniec symulacji
    %warunki poczatkowe
    u = ones(1,kk)*Upp;
    y = ones(1,kk)*Ypp;
    z = ones(1,kk)*Zpp;
    if uz == 1
        u(1,start:end) = x;
    else 
        z(1,start:end) = x;
    end

    for k=start:kk %glowna petla symulacyjna
        %symulacja obiektu   
        y(k)=symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y(k-1),y(k-2));
    end
    
    subplot(2,1,1)
    hold on; 
    grid on; 
    plot(y);
    title('Odpowiedzi skokowe modelu')
    legend('Y(-2)','Y(-1)','Y(0)','Y(1)','Y(2)')
    xlabel('k');
    ylabel('Y');
    if uz == 1
        kstat = y(end)/u(end);
        subplot(2,1,2)
        hold on; 
        grid on; 
        plot(u);
        title('Sterowanie modelu')
        legend('U = -2','U = -1','U = 0','U = 1','U = 2')
        xlabel('k');
        ylabel('U');
    else
        kstat = y(end)/z(end);
        subplot(2,1,2)
        hold on; 
        grid on; 
        plot(z);
        title('Zaklocenie modelu')
        legend('Z = -2','Z = -1','Z = 0','Z = 1','Z = 2')
        xlabel('k');
        ylabel('Z');
    end
end
if uz == 1
       dlmwrite("../Dane/Zad2/zad2_u.csv", u, '\t');
       dlmwrite("../Dane/Zad2/zad2_y_u.csv", y, '\t');
else
    dlmwrite("../Dane/Zad2/zad2_z.csv", z, '\t');
    dlmwrite("../Dane/Zad2/zad2_y_z.csv", y, '\t');
end
