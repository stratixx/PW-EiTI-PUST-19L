%skrypt do realizacji zadania 2
Upp = 0;
Ypp = 0;
for x = -1:0.5:1
    start = 10;
    kk=300; %koniec symulacji
    %warunki poczatkowe
    u = ones(1,kk)*Upp;
    y = ones(1,kk)*Ypp;
    u(1,start:end) = x;

    for k=start:kk %glowna petla symulacyjna
        %symulacja obiektu   
        y(k)=symulacja_obiektu7y(u(k-5),u(k-6),y(k-1),y(k-2));
    end
    
    subplot(2,1,1)
    hold on; 
    grid on; 
    plot(y);
    title('Odpowiedzi skokowe modelu')
    legend('Y(-1)','Y(0,5)','Y(0)','Y(0,5)','Y(1)')
    xlabel('k');
    ylabel('Y');
    subplot(2,1,2)
    hold on; 
    grid on; 
    plot(u);
    title('Sterowanie modelu')
    legend('U = -1','U = -0,5','U = 0','U = 0,5','U = 1')
    xlabel('k');
    ylabel('U');
    dlmwrite(['../Dane/zad2/zad2_u',sprintf('%g',u(end)),'.csv'], u, '\t');
    dlmwrite(['../Dane/zad2/zad2_y',sprintf('%g',y(end)),'.csv'], y, '\t');
end