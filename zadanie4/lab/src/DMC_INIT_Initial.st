//Parametry regulatora DMC1
DMC_G1.D_ := 75;
DMC_G1.N_ := 75;
DMC_G1.Nu := 75;
DMC_G1.lambda := 0.200000;
//Parametry regulatora DMC2
DMC_G2.D_ := 75;
DMC_G2.N_ := 75;
DMC_G2.Nu := 75;
DMC_G2.lambda := 0.200000;
// Przeliczone wartosci do sterowania DMC1
DMC_G1.Ke := 1.650272;
// Przeliczone wartosci do sterowania DMC2
DMC_G2.Ke := 1.686157;

DMC_G1.Ku[0] := 0.597954;
DMC_G1.Ku[1] := 0.749775;
DMC_G1.Ku[2] := 0.907605;
DMC_G1.Ku[3] := 1.026848;
...
DMC_G1.Ku[71] := 0.009323;
DMC_G1.Ku[72] := 0.005970;
DMC_G1.Ku[73] := 0.002869;

DMC_G2.Ku[0] := 0.555568;
DMC_G2.Ku[1] := 0.684826;
DMC_G2.Ku[2] := 0.816335;
DMC_G2.Ku[3] := 0.947948;
...
DMC_G2.Ku[71] := 0.013145;
DMC_G2.Ku[72] := 0.008487;
DMC_G2.Ku[73] := 0.004111;

DMC_G1.delta_u_past[0] := 0.000000;
DMC_G1.delta_u_past[1] := 0.000000;
DMC_G1.delta_u_past[2] := 0.000000;
...
DMC_G1.delta_u_past[71] := 0.000000;
DMC_G1.delta_u_past[72] := 0.000000;
DMC_G1.delta_u_past[73] := 0.000000;

DMC_G2.delta_u_past[0] := 0.000000;
DMC_G2.delta_u_past[1] := 0.000000;
DMC_G2.delta_u_past[2] := 0.000000;
...
DMC_G2.delta_u_past[71] := 0.000000;
DMC_G2.delta_u_past[72] := 0.000000;
DMC_G2.delta_u_past[73] := 0.000000;
