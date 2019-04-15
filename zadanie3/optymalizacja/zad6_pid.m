%skrypt do realizacji zadania 6 - optymalizacja nastaw PID-a
%parametry poczatkowe
x0 = [0.3; 8.5; 0.2]; % ustalony punkt pocz¹tkowy
%x0 = x;                % u¿ycie poprzednich nastaw
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0.1;  1;  0.1];
ub = [100;  20;    10];

%ustawienie opcji symulacji
options = optimoptions('fmincon');
options.StepTolerance=1e-25;
options.OptimalityTolerance = 1e-16;
options.ConstraintTolerance = 1e-40;
options.Algorithm = 'sqp';
options.MaxFunctionEvaluations = 30000;
options.MaxIterations = 1000;
%[options.OptimalityTolerance,options.FunctionTolerance,options.StepTolerance];

%wywolanie optymalizacji
[x,resnorm,residual,exitflag,output] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,[],options);

Kr = x(1)
Ti = x(2)
Td = x(3)