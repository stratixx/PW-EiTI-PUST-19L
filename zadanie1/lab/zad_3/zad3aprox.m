T1=7.59;
T2=62.4;
K=0.32;
Td=10;
e(1:450)=0;
Y(1:450)=0;
y(1:450)=0;
u(1:450)=1;
Tpp=36.8;


OdpSkok = news;

alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:450
y(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*y(k-1)- a2*y(k-2);
end
e = OdpSkok' - y;
E=(norm(e))^2;

OdpSkok=OdpSkok(1:450);
y=y(1:450);

f = figure('visible','on');
stairs(OdpSkok);
hold on;
grid on;
stairs(y);
legend({'model na podstawie pomiaru','model na podstawie apryksomacji'},'location', 'southeast');
xlabel('i');
ylabel('si');
fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];
