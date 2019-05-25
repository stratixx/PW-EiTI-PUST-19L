//Generacja tesktu do wyslania przez socket communication
// Otwarcie portu wykonuje sie automatycznie po uruchomieniu skryptu MATLAB
// Pojawia sie wowczas flaga SD10680.1 - dla drugiego po³¹czenia z ustawien Ethernet
// Wlaczenie automatycznego wysylania 

SET(Auto_Send AND SD10680.0 AND LDP(TRUE, SM412), Send_START);
IF Send_START THEN
	Temp_String := 'Y=';
	Temp_String := CONCAT(Temp_String,INT_TO_STRING(PID_TANK3.PV));

	Temp_String := CONCAT(Temp_String,';U=');

	Temp_String := CONCAT(Temp_String,INT_TO_STRING(PID_TANK3.CE));

	Temp_String := CONCAT(Temp_String,';Y_ZAD=');
	Temp_String := CONCAT(Temp_String,INT_TO_STRING(PID_TANK3.SP));
	Temp_String := CONCAT(Temp_String,';$L');
	Send_String := Temp_String;
	//Dlugosc tekstu
	String_Len := LEN(Send_String);

	Trigger_Send := 1;
	Send_START := 0;

END_IF; 

RST(LDP(TRUE, Trigger_Send), sent);
RST(LDP(TRUE, Trigger_Send), not_sent);
//bit 1 Conn 2 //Conn2
SP_SOCSND(LDP(TRUE, Trigger_Send) AND SD10680.0 , 'U0' , K1 , D3200 , String_Len ,M300 );

SET( LDP(TRUE, M300) AND NOT M301, sent);
SET( LDP(TRUE, M300) AND M301, not_sent);
IF M300 AND NOT M301 THEN
	Trigger_Send := 0;
END_IF; 