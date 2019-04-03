%skrypt pomagaj¹cy przy przycinaniu wektorów

kk=1000;
start = length(u)-k; % ucina nieu¿yty pocz¹tek wektorów
start =102;
end_ = length(u);   
%end_ = 450;

y = y(start:end_);
u = u(start:end_);
z = z(start:end_);
y_zad = y_zad(start:end_);


%dlmwrite("u.csv", u, '\t');
dlmwrite("z_0_10.csv", z, '\t');
dlmwrite("y_0_10.csv", y, '\t');
%dlmwrite("y_zad.csv", y_zad, '\t');
%plot(y)