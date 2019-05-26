
IF DMC_G1.Control_ON THEN
//	//Ustawienie wartości PV
	DMC_G1.PV := INT_TO_REAL(T_1)/100.0;
	
	// iloczyn wektorów współczynników Ku i przeszłych zmian sterowania delta_u_past
	// u(k|k) = u(k-1) + Ke*e(k) - Ku*deltaUp(k)
	// Źródło: wzór u(k|k), str. 90 skryptu do projektu 1 SMS
	DMC_G1.tmp := 0;
	FOR n := 0 TO DMC_G1.D-1 BY 1 DO
		DMC_G1.tmp := DMC_G1.tmp + DMC_G1.Ku[n]*DMC_G1.delta_u_past[n];
	END_FOR 

	// wyznaczenie nowej zmiany sterowania
	DMC_G1.delta_u := DMC_G1.Ke*(DMC_G1.SV - DMC_G1.PV) - DMC_G1.tmp;
	// wyznaczenie nowej wartości sterowania
	DMC_G1.tmp := DMC_G1.MV + DMC_G1.delta_u;
	// nałożenie ograniczeń na sterowanie
	if(DMC_G1.tmp >  100)
		DMC_G1.tmp :=  100;
	else if(DMC_G1.tmp < 0)
		DMC_G1.tmp := 0;
	// przekazanie do regulatora osiągniętej zmiany sterowania
	DMC_G1.delta_u := DMC_G1.tmp - DMC_G1.MV;
	DMC_G1.MV := DMC_G1.tmp;
	// przesunięcie wektora przeszłych zmian sterowania o jeden krok w tył i
	// wstawienie bieżącej zmiany sterowania na początek
	FOR n := DMC_G1.D-2 TO 0 BY -1 DO
		DMC_G1.delta_u_past[n+1] := DMC_G1.delta_u_past[n];
	END_FOR 
	DMC_G1.delta_u_past[0] := DMC_G1.delta_u;
	
	G_1 := REAL_TO_INT(DMC_G1.MV*10.0);
END_IF;



IF DMC_G2.Control_ON THEN
//	//Ustawienie wartości PV
	DMC_G2.PV := INT_TO_REAL(T_2)/100.0;
	
	// iloczyn wektorów współczynników Ku i przeszłych zmian sterowania delta_u_past
	// u(k|k) = u(k-1) + Ke*e(k) - Ku*deltaUp(k)
	// Źródło: wzór u(k|k), str. 90 skryptu do projektu 1 SMS
	DMC_G2.tmp := 0;
	FOR n := 0 TO DMC_G2.D-1 BY 1 DO
		DMC_G2.tmp := DMC_G2.tmp + DMC_G2.Ku[n]*DMC_G2.delta_u_past[n];
	END_FOR 

	// wyznaczenie nowej zmiany sterowania
	DMC_G2.delta_u := DMC_G2.Ke*(DMC_G2.SV - DMC_G2.PV) - DMC_G2.tmp;
	// wyznaczenie nowej wartości sterowania
	DMC_G2.tmp := DMC_G2.MV + DMC_G2.delta_u;
	// nałożenie ograniczeń na sterowanie
	if(DMC_G2.tmp >  100)
		DMC_G2.tmp :=  100;
	else if(DMC_G2.tmp < 0)
		DMC_G2.tmp := 0;
	// przekazanie do regulatora osiągniętej zmiany sterowania
	DMC_G2.delta_u := DMC_G2.tmp - DMC_G2.MV;
	DMC_G2.MV := DMC_G2.tmp;
	// przesunięcie wektora przeszłych zmian sterowania o jeden krok w tył i
	// wstawienie bieżącej zmiany sterowania na początek
	FOR n := DMC_G2.D-2 TO 0 BY -1 DO
		DMC_G2.delta_u_past[n+1] := DMC_G2.delta_u_past[n];
	END_FOR 
	DMC_G2.delta_u_past[0] := DMC_G2.delta_u;
	
	G_2 := REAL_TO_INT(DMC_G2.MV*10.0);
END_IF;


