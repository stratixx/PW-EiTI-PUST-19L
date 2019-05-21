%skrypt pomagaj¹cy przy przycinaniu wektorów

y1 = t1/100;
y2 = t3/100;

u1 = g1/10;
u2 = g2/10;

%%%%%%%%%%%%%%%%%%%

start =37;
end_ = length(u1);   
%end_ = 400;

y1 = y1(start:end_);
y2 = y2(start:end_);
u1 = u1(start:end_);
u2 = u2(start:end_);
%y_zad1 = y_zad1(start:end_);
%y_zad2 = y_zad2(start:end_);

%%%%%%%%%%%%%%%%%%%%%

t1 = 100*y1;
t3 = 100*y2;

g1 = 10*u1;
g2 = 10*u2;