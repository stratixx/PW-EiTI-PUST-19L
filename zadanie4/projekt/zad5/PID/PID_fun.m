%zadanie 5 - Skrypt relizujacy funkcje algorytmu PID regulatora wielowymiarowego
function [E] = PID_fun(x)
    %inicjalizacja

    E = 0;%wspolczynnik jakosci regualcji
    ny = 3;
    nu = 4;

    Tp = 0.5;%czas probkowania

    ster = 4;%odrzucany sygnal sterujacy

    %nastawy regulatorow
    if ster == 1
        Kr1 = x(1); Ti1 = x(2); Td1 = x(3);%u2 dla y3
        Kr2 = x(4); Ti2 = x(5); Td2 = x(6);%u3 dla y2
        Kr3 = x(7); Ti3 = x(8); Td3 = x(9);%u4 dla y1
    elseif ster == 2
        Kr1 = x(1); Ti1 = x(2); Td1 = x(3);%u1 dla y3
        Kr2 = x(4); Ti2 = x(5); Td2 = x(6);%u3 dla y2
        Kr3 = x(7); Ti3 = x(8); Td3 = x(9);%u4 dla y1
    elseif ster == 3
        Kr1 = x(1); Ti1 = x(2); Td1 = x(3);%u1 dla y3
        Kr2 = x(4); Ti2 = x(5); Td2 = x(6);%u2 dla y2
        Kr3 = x(7); Ti3 = x(8); Td3 = x(9);%u4 dla y1
    elseif ster == 4
        Kr1 = x(1); Ti1 = x(2); Td1 = x(3);%u1 dla y3
        Kr2 = x(4); Ti2 = x(5); Td2 = x(6);%u2 dla y2
        Kr3 = x(7); Ti3 = x(8); Td3 = x(9);%u3 dla y1
    end

    %nastawy regulatorow dyskretnego
    r21 = Kr1*Td1/Tp; r11 = Kr1*(Tp/(2*Ti1)-2*Td1/Tp-1); r01 = Kr1*(1+Tp/(2*Ti1)+Td1/Tp);

    r22 = Kr2*Td2/Tp; r12 = Kr2*(Tp/(2*Ti2)-2*Td2/Tp-1); r02 = Kr2*(1+Tp/(2*Ti2)+Td2/Tp);

    r23 = Kr3*Td3/Tp; r13 = Kr3*(Tp/(2*Ti3)-2*Td3/Tp-1); r03 = Kr3*(1+Tp/(2*Ti3)+Td3/Tp);

    %parametry symulacji
    kk = 1600;
    start = 10;
    e = zeros(1,kk);
    u1 = zeros(1,kk);
    u2 = zeros(1,kk);
    u3 = zeros(1,kk);
    u4 = zeros(1,kk);
    y1 = zeros(1,kk);
    y2 = zeros(1,kk);
    y3 = zeros(1,kk);

    Ey = zeros(ny,1);

    y1_zad = zeros(1,kk);
    y1_zad(start:400) = 1;
    y1_zad(400:800) = 1.5;
    y1_zad(800:1200) = 0.6;
    y1_zad(1200:kk) = 2.5;

    y2_zad = zeros(1,kk);
    y2_zad(start:400) = 2;
    y2_zad(400:800) = 1.2;
    y2_zad(800:1200) = 0;
    y2_zad(1200:kk) = 1.5;

    y3_zad = zeros(1,kk);
    y3_zad(start:400) = 1.5;
    y3_zad(400:800) = 0.8;
    y3_zad(800:1200) = 2;
    y3_zad(1200:kk) = 0.2;

    for k = start:kk %glowna petla symulacyjna 
        %symulacja obiektu 
           [y1(k),y2(k),y3(k)] = symulacja_obiektu7(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
           u2(k-1),u2(k-2),u2(k-3),u2(k-4),u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
           u4(k-1),u4(k-2),u4(k-3),u4(k-4),y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
           y2(k-1),y2(k-2),y2(k-3),y2(k-4),y3(k-1),y3(k-2),y3(k-3),y3(k-4)); 

       %uchyb regulacji
        e(1,k) = y1_zad(k) - y1(k);
        e(2,k) = y2_zad(k) - y2(k);
        e(3,k) = y3_zad(k) - y3(k); 

        if ster == 1
            u2(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u2(k-1);%y3 od u2
            u3(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u3(k-1);%y2 od u3
            u4(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u4(k-1);%y1 od u4
        elseif ster == 2
            u1(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u1(k-1);%y3 od u1
            u3(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u2(k-1);%y2 od u3
            u4(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u4(k-1);%y1 od u4
        elseif ster == 3
            u1(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u1(k-1);%y3 od u1
            u2(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u2(k-1);%y2 od u2
            u4(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u4(k-1);%y1 od u4 
        elseif ster == 4
            u1(k) = r21*e(3,k-2)+r11*e(3,k-1)+r01*e(3,k)+u1(k-1);%y3 dla u1
            u2(k) = r22*e(2,k-2)+r12*e(2,k-1)+r02*e(2,k)+u2(k-1);%y2 dla u2
            u3(k) = r23*e(1,k-2)+r13*e(1,k-1)+r03*e(1,k)+u3(k-1);%y1 dla u3
        end

         %bledy
       Ey(1) = Ey(1) + (e(1,k))^2;
       Ey(2) = Ey(2) + (e(2,k))^2;
       Ey(3) = Ey(3) + (e(3,k))^2;
    end
    E = sum(Ey);
end