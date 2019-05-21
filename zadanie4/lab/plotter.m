figure(1)

% y1 = t1/100;
% y2 = t3/100;
% 
% u1 = g1/10;
% u2 = g2/10;


subplot(2,1,1); 
stairs(y1); 
hold on; 
stairs(y2); 
hold off; 
title('Wyjœcie'); 
xlabel('iteracja');
legend('T1', 'T3');

subplot(2,1,2); 
stairs(u1); 
hold on; 
stairs(u2); 
hold off; 
title('Sterowanie'); 
xlabel('iteracja');
legend('G1', 'G2');
