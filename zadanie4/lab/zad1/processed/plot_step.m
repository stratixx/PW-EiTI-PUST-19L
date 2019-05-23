load('zlozone.mat')

% pre = 0;
% post = 0;
% 
% y1 = [ ones(pre,1)*y1(1); y1; ones(post,1)*y1(end); ];
% y2 = [ ones(pre,1)*y2(1); y2; ones(post,1)*y2(end); ];
% u1 = [ ones(pre,1)*u1(1); u1; ones(post,1)*u1(end); ];
% u2 = [ ones(pre,1)*u2(1); u2; ones(post,1)*u2(end); ];

figure(1);
subplot(2,1,1)
hold on;
plot(y1_real); % wyswietlamy y w czasie
legend('y1_m_o_d_e_l', 'y1_r_e_a_l')

subplot(2,1,2)
hold on;
plot(y2_real); % wyswietlamy y w czasie
legend('y2_m_o_d_e_l', 'y2_r_e_a_l')

figure(2); 
subplot(2,1,1)
hold on;
plot(u1_real); % wyswietlamy u w czasie
legend('u1_m_o_d_e_l', 'u1_r_e_a_l')

subplot(2,1,2)
hold on;
plot(u2_real); % wyswietlamy u w czasie
legend('u2_m_o_d_e_l', 'u2_r_e_a_l')

