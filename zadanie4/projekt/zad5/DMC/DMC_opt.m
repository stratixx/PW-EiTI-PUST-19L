%zadanie 5 - Skrypt sluzacy do optymalizacji parametrow algorytmu DMC
x0 = [0.9002,-5.5084,12.1635,-0.0569,-0.5143,-9.3176,3.2209];
options = optimoptions('fmincon');
options.StepTolerance = 1e-12;
options.OptimalityTolerance = 1e-10;
options.ConstraintTolerance = 1e-10;
options.Algorithm = 'sqp';
options.MaxFunctionEvaluations = 300;
options.MaxIterations = 100;
[x,resnorm,residual,exitflag,output] = fmincon(@DMC_fun,x0,[],[],[],[],[],[],[],options);