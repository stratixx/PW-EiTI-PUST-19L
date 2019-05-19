%zadanie 5 - Skrypt sluzacy do optymalizacji parametrow algorytmu PID
x0 = [0.7,0.2,0.3,0.6,0.3,0.05,0.8,0.4,0.4];
options = optimoptions('fmincon');
options.StepTolerance = 1e-12;
options.OptimalityTolerance = 1e-10;
options.ConstraintTolerance = 1e-10;
options.Algorithm = 'sqp';
options.MaxFunctionEvaluations = 3000;
options.MaxIterations = 1000;
[x,resnorm,residual,exitflag,output] = fmincon(@PID_fun,x0,[],[],[],[],[0,0,0,0,0,0,0,0,0],[],[],options);