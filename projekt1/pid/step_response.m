start = 20;
kk=210; %koniec symulacji
%warunki pocztkowe
u=ones(1,kk)*0.8;
y=zeros(1,kk);
e=zeros(1,kk);

for k=start:kk; %g��wna ptla symulacyjna
    %symulacja obiektu   
    y(k) = symulacja_obiektu7Y(u(k-10), u(k-11), y(k-1), y(k-2));
end
%figure(2); hold on; plot(y);  legend('ynew')
begin = start;
stop = 210;
s = y(begin:stop);
plot(s);