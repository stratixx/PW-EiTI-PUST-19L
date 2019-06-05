//Opoznienie po wlaczeniu sterownika - 
//zezwolenie komunikacji modbus ze stanowiskiem
OUT_T(TRUE,TC0,K20);

SET(LDP(TRUE,TS0),Pozwolenie_pomiar_MODBUS);
SET(LDP(TRUE,TS0),Pozwolenie_zapis_MODBUS);

EI(TRUE); //przerwania zalaczone

TIM_MAIN(PT:= T#200s);

CASE  Stan_MAIN  OF		
	0:
		IF NOT TIM_MAIN.Q THEN
			TIM_MAIN.IN := 1;
			Stan_MAIN := 1;
		END_IF;
	1:
		IF TIM_MAIN.Q THEN
			T_1_zad := 4000;
			T_3_zad := 4200;
			TIM_MAIN.IN := 0;
			Stan_MAIN := 2;		
		END_IF;			
	2:
		IF NOT TIM_MAIN.Q THEN
			TIM_MAIN.IN := 1;
			Stan_MAIN := 3;
		END_IF;
	3:
		IF TIM_MAIN.Q THEN
			T_1_zad := 5500;
			T_3_zad := 4200;
			TIM_MAIN.IN := 0;
			Stan_MAIN := 4;		
		END_IF;			
	4:
		IF NOT TIM_MAIN.Q THEN
			TIM_MAIN.IN := 1;
			Stan_MAIN := 5;
		END_IF;
	5:
		IF TIM_MAIN.Q THEN
			T_1_zad := 4000;
			T_3_zad := 4200;
			TIM_MAIN.IN := 0;
			Stan_MAIN := 6;		
		END_IF;		
	6:
		IF NOT TIM_MAIN.Q THEN
			TIM_MAIN.IN := 1;
			Stan_MAIN := 7;
		END_IF;
	7:
		IF TIM_MAIN.Q THEN
			T_1_zad := 4000;
			T_3_zad := 5700;
			TIM_MAIN.IN := 0;
			Stan_MAIN := 0;		
		END_IF;			
END_CASE;

// przypisanie wartosci zadanych
DMC_G1.SV := INT_TO_REAL(T_1_zad)/100.0;
DMC_G2.SV := INT_TO_REAL(T_3_zad)/100.0;
PID_G1.SV := INT_TO_REAL(T_1_zad)/100.0;
PID_G2.SV := INT_TO_REAL(T_3_zad)/100.0;

//G_1 := T_1_zad;
//G_2 := T_3_zad;
