%skrypt do realizacji zadania 3
run('../danePoczatkowe.m');
u = 0.7;
start = 20;
kk=410; %koniec symulacji
%warunki poczatkowe
y=ones(1,kk)*Ypp;
yzad=ones(1,kk)*Upp; yzad(1,start:kk)=Upp+u;
for k=start:kk %glowna petla symulacyjna
    %symulacja obiektu   
    y(k) = symulacja_obiektu7Y(yzad(k-10), yzad(k-11), y(k-1), y(k-2));
end
%rysowanie wykresow
y1 = y(19:kk);
yzad1 = yzad(19:kk);
g = figure('visible','on');
plot(y1)
hold on
plot(yzad1)
title('Odpowiedz skokowa dla danego wymuszenia')
xlabel('k')
ylabel(['y,','u'])
legend('y(k)','u(k)','Location','East')
fig_pos = g.PaperPosition;
g.PaperSize = [fig_pos(3) fig_pos(4)];
print(g, 'y','-dpdf','-bestfit')
%tworzenie znormalizowanej odpowiedzi skokowej s
y1 = y(20:220);
s = (y1-2)./u;
f = figure('visible','on');
plot(s)
hold on 
title('Odpowiedz skokowa dla regulatora DMC')
xlabel('k')
ylabel('y(k)')
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
print(f, 's','-dpdf','-bestfit')

