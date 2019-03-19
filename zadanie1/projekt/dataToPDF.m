f = figure('visible','on');
%f = figure(1);

grid on;
plot(y);
title('odp u 1.5');


fig_pos = f.PaperPosition;
f.PaperSize = [fig_pos(3) fig_pos(4)];

%print(f, 'zad2/img/odp_u_1_5','-dpdf','-bestfit')