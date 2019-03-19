x0 = [4.0035; 5.7235; 3.9897];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0.1;  0.01;  0.001];
ub = [400;  20000;    100.1];

options = optimoptions('fmincon');
options.StepTolerance=1e-25;
options.OptimalityTolerance = 1e-16;
options.ConstraintTolerance = 1e-40;
options.Algorithm = 'sqp';
options.MaxFunctionEvaluations = 30000;
options.MaxIterations = 1000;
%[options.OptimalityTolerance,options.FunctionTolerance,options.StepTolerance];

[x,resnorm,residual,exitflag,output] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,[],options);

Kr=x(1)
Ti=x(2)
Td=x(3)