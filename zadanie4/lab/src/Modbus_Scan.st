SET(Pozwolenie_pomiar_MODBUS AND LDP(TRUE,SM414),Pomiar_MODBUS);
IF(Pomiar_MODBUS) THEN
	Function_code := 4;
	Device_count := 7;
	ADPRW( Pomiar_MODBUS AND NOT Zapis_MODBUS, Slave_adres , Function_code , Modbus_adres, Device_count , D100, M100);
	IF(M101) THEN
		RST(TRUE, Pomiar_MODBUS);
		RST(TRUE, M101);
		RST(TRUE, M100);
	END_IF;
		
	MOV(TRUE, D100, T_1);
	MOV(TRUE, D101, T_2);
	MOV(TRUE, D102, T_3);
END_IF;


IF(T_1 >= K15000) THEN
	SET(TRUE, T_1_alarm);
END_IF;

IF(T_3 >= K15000) THEN
	SET(TRUE, T_3_alarm);
END_IF;





IF(T_1_alarm) THEN
	MOV(TRUE, K0, G_1);
END_IF;

IF(T_3_alarm) THEN
	MOV(TRUE, K0, G_2);
END_IF;

	

SET(Pozwolenie_zapis_MODBUS AND LDF(TRUE,SM414),Zapis_MODBUS);
IF(Zapis_MODBUS) THEN
	
	MOV(TRUE, W_1, D110);
	MOV(TRUE, W_2, D111);
	MOV(TRUE, W_3, D112);
	MOV(TRUE, W_4, D113);
	
	MOV(TRUE, G_1, D114);
	MOV(TRUE, G_2, D115);
	
	Function_code := 16;
	Device_count := 6;
	ADPRW( Zapis_MODBUS AND NOT Pomiar_MODBUS, Slave_adres , Function_code , Modbus_adres, Device_count , D110, M110);
	IF(M111) THEN
		RST(TRUE, Zapis_MODBUS);
		RST(TRUE, M111);
		RST(TRUE, M110);
	END_IF;
	
	
END_IF;


