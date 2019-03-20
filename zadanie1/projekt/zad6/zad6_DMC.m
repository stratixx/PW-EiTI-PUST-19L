%skrypt do realizacji zadania 6 - optymalizacja nastaw DMC
%parametry poczatkowe
x0 = [200; 5; 5];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [1;  1;  0.001];
ub = [200;  200;    1000];

%parametry optymalizacji
options = optimoptions('fmincon');
options.StepTolerance=1e-12;
options.OptimalityTolerance = 1e-10;
options.ConstraintTolerance = 1e-10;
options.Algorithm = 'sqp';
options.MaxFunctionEvaluations = 300;
options.MaxIterations = 100;
%[options.OptimalityTolerance,options.FunctionTolerance,options.StepTolerance];

%optymalizacja
[x,resnorm,residual,exitflag,output] = fmincon(@fun2,x0,A,b,Aeq,beq,lb,ub,[],options);

N = round(x(1))
Nu = round(x(2))
lambda=x(3)