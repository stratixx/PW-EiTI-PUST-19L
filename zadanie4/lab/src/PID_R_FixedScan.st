simTime := simTime + 1;

//Program: PID_R; Typ: FixedScan 4000ms
IF PID_G1.Control_ON THEN
	//Ustawienie wartosci PV
	PID_G1.PV := INT_TO_REAL(T_1)/100.0;
		
	//Wyliczenie parametrow
	//r0 = K*( 1+(Tp/(2*Ti))+Td/Tp );
	PID_G1.Rp0 := PID_G1.K_gain*(
		1.0
		+(PID_G1.sampling_time/(2.0*PID_G1.TI))
		+PID_G1.TD/PID_G1.sampling_time
		);
	//r1 = K*( (Tp/(2*Ti))-(2*Td/Tp)-1 );
	PID_G1.Rp1 := PID_G1.K_gain*(
		(PID_G1.sampling_time/(2.0*PID_G1.TI))
		-(2.0*PID_G1.TD/PID_G1.sampling_time)
		-1.0
		);
	//K*Td/Tp;
	PID_G1.Rp2 := PID_G1.K_gain*PID_G1.TD/PID_G1.sampling_time;
	
	//Wyliczenie uchybu regulacji i przesuniecie historii
	PID_G1.Ep2 := PID_G1.Ep1;
	PID_G1.Ep1 := PID_G1.Ep0;
	PID_G1.Ep0 := PID_G1.SV - PID_G1.PV;

	//Obliczenie sterowania
	//u = R2*E2 + R1*E1 + R0*E0 + u;
	PID_G1.MV := PID_G1.Rp2*PID_G1.Ep2 
		+PID_G1.Rp1*PID_G1.Ep1 
		+PID_G1.Rp0*PID_G1.Ep0 
		+PID_G1.MV;
	
	//Ograniczenia sterowania
	IF (PID_G1.MV > 100.0) THEN
		PID_G1.MV := 100.0;
	END_IF;
	
	IF (PID_G1.MV < 0.0) THEN
		PID_G1.MV := 0.0;
	END_IF;
	
	G_1 := REAL_TO_INT(PID_G1.MV*10.0);
END_IF;

//Program: PID_R; Typ: FixedScan 4000ms
IF PID_G2.Control_ON THEN
	//Ustawienie wartosci PV
	PID_G2.PV := INT_TO_REAL(T_3)/100.0;
		
	//Wyliczenie parametrow
	//r0 = K*( 1+(Tp/(2*Ti))+Td/Tp );
	PID_G2.Rp0 := PID_G2.K_gain*(
		1.0
		+(PID_G2.sampling_time/(2.0*PID_G2.TI))
		+PID_G2.TD/PID_G2.sampling_time
		);
	//r1 = K*( (Tp/(2*Ti))-(2*Td/Tp)-1 );
	PID_G2.Rp1 := PID_G2.K_gain*(
		(PID_G2.sampling_time/(2.0*PID_G2.TI))
		-(2.0*PID_G2.TD/PID_G2.sampling_time)
		-1.0
		);
	//K*Td/Tp;
	PID_G2.Rp2 := PID_G2.K_gain*PID_G2.TD/PID_G2.sampling_time;
	
	//Wyliczenie uchybu regulacji i przesuniecie historii
	PID_G2.Ep2 := PID_G2.Ep1;
	PID_G2.Ep1 := PID_G2.Ep0;
	PID_G2.Ep0 := PID_G2.SV - PID_G2.PV;

	//Obliczenie sterowania
	//u = R2*E2 + R1*E1 + R0*E0 + u;
	PID_G2.MV := PID_G2.Rp2*PID_G2.Ep2 
		+ PID_G2.Rp1*PID_G2.Ep1 
		+ PID_G2.Rp0*PID_G2.Ep0 
		+ PID_G2.MV;
	
	//ANTI WIND UP
	IF (PID_G2.MV > 100.0) THEN
		PID_G2.MV := 100.0;
	END_IF;
	
	IF (PID_G2.MV < 0.0) THEN
		PID_G2.MV := 0.0;
	END_IF;
	
	G_2 := REAL_TO_INT(PID_G2.MV*10.0);
END_IF;
