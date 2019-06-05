EI(TRUE); //przerwania zalaczone

TIM_MAIN(PT:= T#100s);

CASE  Stan_MAIN  OF		
	0:
		IF NOT TIM_MAIN.Q THEN
			TIM_MAIN.IN := 1;
			Stan_MAIN := 1;
		END_IF;
	1:
		IF TIM_MAIN.Q THEN
			TANK_1_zad := 150;
			TANK_2_zad := 150;
			TANK_3_zad := 150;
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
			TANK_1_zad := 175;
			TANK_2_zad := 150;
			TANK_3_zad := 150;
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
			TANK_1_zad := 150;
			TANK_2_zad := 150;
			TANK_3_zad := 150;
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
			TANK_1_zad := 150;
			TANK_2_zad := 175;
			TANK_3_zad := 150;
			TIM_MAIN.IN := 0;
			Stan_MAIN := 8;		
		END_IF;		
	8:
		IF NOT TIM_MAIN.Q THEN
			TIM_MAIN.IN := 1;
			Stan_MAIN := 9;
		END_IF;
	9:
		IF TIM_MAIN.Q THEN
			TANK_1_zad := 150;
			TANK_2_zad := 150;
			TANK_3_zad := 150;
			TIM_MAIN.IN := 0;
			Stan_MAIN := 10;		
		END_IF;		
	10:
		IF NOT TIM_MAIN.Q THEN
			TIM_MAIN.IN := 1;
			Stan_MAIN := 11;
		END_IF;
	11:
		IF TIM_MAIN.Q THEN
			TANK_1_zad := 150;
			TANK_2_zad := 150;
			TANK_3_zad := 175;
			TIM_MAIN.IN := 0;
			Stan_MAIN := 0;		
		END_IF;			
END_CASE;

// przypisanie wartosci zadanych
PID_VALVE1.SV := INT_TO_REAL(TANK_1_zad)/100.0;
PID_VALVE2.SV := INT_TO_REAL(TANK_2_zad)/100.0;
PID_VALVE3.SV := INT_TO_REAL(TANK_3_zad)/100.0;

//VALVE1 := TANK_1_zad;
//VALVE2 := TANK_2_zad;
//VALVE3 := TANK_3_zad;
