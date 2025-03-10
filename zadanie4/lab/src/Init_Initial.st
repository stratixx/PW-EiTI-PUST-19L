okres_probkowania := 4.0;
stala_czasowa := 10.0;
K_p_proces := 25.0;
u_k := 1.5; //wstepna wartosc sterowania

//Inicjalizacja MODBUS
Pomiar_MODBUS := 0;
Zapis_MODBUS := 0;

MOV(TRUE, K11, Slave_adres);
MOV(TRUE, K4, Function_code); //4-pomiar, 3-sterowanie
MOV(TRUE, K0, Modbus_adres); //zaczynamy liczyc od 0
MOV(TRUE, K7, Device_count); //7 pomiarow, 6 sterowan


MOV(TRUE, K500, W_1); 
MOV(TRUE, K500, W_2); 
MOV(TRUE, K0, W_3); 
MOV(TRUE, K0, W_4); 
MOV(TRUE, K320 , G_1); 
MOV(TRUE, K370, G_2); 
MOV(TRUE, K0, simTime);

//Ustawienie poczatkowe wyjsc procesu
ZRST(TRUE, D110, D120);

//timer 2n, ktorego odliczenie odczytujemy z SM414
SD414 := 2;  // ustawiony okres 4 sekundy

// początkowe wartości zadane
T_1_zad := 390;
T_3_zad := 410;

//Program: Init; Typ: Initial
//init regulatora PID_G1
PID_G1.K_gain := 30.1;
PID_G1.TI := 25.0;
PID_G1.TD := 1.0;
PID_G1.Ep0 := 0.0;
PID_G1.Ep1 := 0.0;
PID_G1.Ep2 := 0.0;
PID_G1.Rp0 := 0.0;
PID_G1.Rp1 := 0.0;
PID_G1.Rp2 := 0.0;
PID_G1.sampling_time := 4.0;
PID_G1.SV := 36.68;
PID_G1.MV := 32.0;

//Program: Init; Typ: Initial
//init regulatora PID_G2
PID_G2.K_gain := 30.7;
PID_G2.TI := 25.5;
PID_G2.TD := 1.0;
PID_G2.Ep0 := 0.0;
PID_G2.Ep1 := 0.0;
PID_G2.Ep2 := 0.0;
PID_G2.Rp0 := 0.0;
PID_G2.Rp1 := 0.0;
PID_G2.Rp2 := 0.0;
PID_G2.sampling_time := 4.0;
PID_G2.SV := 38.68;
PID_G2.MV := 37.0;
