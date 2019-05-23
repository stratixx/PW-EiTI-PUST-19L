figure(6)

% y1 = t1/100;
% y2 = t3/100;
% 
% u1 = g1/10;
% u2 = g2/10;


subplot(2,1,1); 
stairs(y1_real); 
hold on; 
stairs(y2_real); 
hold off; 
title('Wyjœcie'); 
xlabel('iteracja');
legend('T1', 'T3');

subplot(2,1,2); 
stairs(u1_real); 
hold on; 
stairs(u2_real); 
hold off; 
title('Sterowanie'); 
xlabel('iteracja');
legend('G1', 'G2');
