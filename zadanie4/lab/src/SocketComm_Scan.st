// Sprawdzenie otwartego polaczenia
SP_SOCCINF( SD10680.0 , 'U0' , K1 , Control_data_SOCCINF , Conn_info_SOCCINF );


OUT(SD10680.0 AND SM412, Y17);

//IF AUTO_SEND AND LDP(TRUE, SM414) THEN
IF AUTO_SEND AND LDP(TRUE, SM414) THEN

//Generacja tesktu do wyslania przez socket communication
/*
	text_temp := 'Y1=';
	text_temp := CONCAT(text_temp,REAL_TO_STRING(y_k));
	text_temp := CONCAT(text_temp,';Y2=');		
	text_temp := CONCAT(text_temp,REAL_TO_STRING(y_k+10.0));		
	text_temp := CONCAT(text_temp,';U1=');	
	text_temp := CONCAT(text_temp,REAL_TO_STRING(u_k));	
	text_temp := CONCAT(text_temp,';U2=');		
	text_temp := CONCAT(text_temp,REAL_TO_STRING(u_k+4.0));	
	text_temp := CONCAT(text_temp,';YZ1=');		
	text_temp := CONCAT(text_temp, REAL_TO_STRING(12.3));	
	text_temp := CONCAT(text_temp,';YZ2=');			
	text_temp := CONCAT(text_temp, REAL_TO_STRING(43.0));	
	text_temp := CONCAT(text_temp,';$L');	
*/

	//text_temp := 'W1=';
	//text_temp := CONCAT(text_temp, INT_TO_STRING(W_1));
	//text_temp := CONCAT(text_temp,';W2=');	
	//text_temp := CONCAT(text_temp, INT_TO_STRING(W_2));	
	//text_temp := CONCAT(text_temp,';W3=');	
	//text_temp := CONCAT(text_temp, INT_TO_STRING(W_3));	
	//text_temp := CONCAT(text_temp,';W4=');	
	//text_temp := CONCAT(text_temp, INT_TO_STRING(W_4));	
	
	text_temp := 'G1=';	
	//text_temp := CONCAT(text_temp,';G1=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(G_1));	
	text_temp := CONCAT(text_temp,';G2=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(G_2));	
	text_temp := CONCAT(text_temp,';T1=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(T_1));	
	text_temp := CONCAT(text_temp,';T2=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(T_2));	
	text_temp := CONCAT(text_temp,';T3=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(T_3));	
	text_temp := CONCAT(text_temp,';K=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(simTime));	
	text_temp := CONCAT(text_temp,';T1_ZAD=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(T_1_zad));	
	text_temp := CONCAT(text_temp,';T3_ZAD=');	
	text_temp := CONCAT(text_temp, INT_TO_STRING(T_3_zad));	
	
	
	text_temp := CONCAT(text_temp,';$L');	

	//Dlugosc tekstu
	text_length := INT_TO_WORD( LEN(text_temp) );
	
	Trigger_Send := 1;
	
END_IF;


SP_SOCSND(AUTO_SEND AND LDP(TRUE, Trigger_Send) AND SD10680.0 , 'U0' , K1 , Control_data_SOCSND , text_length , M300 );

IF M300 AND NOT M301 THEN
	Trigger_Send := 0;
END_IF;





