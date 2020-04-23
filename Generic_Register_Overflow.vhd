LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Generic_Register_Overflow IS
	GENERIC
	(
		N	:	INTEGER
	);
	
	PORT
	(
		IN_A	: 	IN		STD_LOGIC;
		IN_B	: 	IN		STD_LOGIC;
		IN_C	: 	IN		STD_LOGIC;
		IN_D	: 	IN		STD_LOGIC;
		OUT_X	:	OUT	STD_LOGIC
	);
END Generic_Register_Overflow;

ARCHITECTURE Gen_Register_Overflow OF Generic_Register_Overflow IS
	SIGNAL TEMP : STD_LOGIC;
	BEGIN
		Generic_Reg_Overflow : PROCESS (IN_A, IN_B, IN_C, IN_D)
		BEGIN
			IF IN_D = '1' THEN
				TEMP <= ((NOT(IN_A)) AND (NOT(IN_B)) AND IN_C) OR (IN_A AND IN_B AND (NOT(IN_C)));
				IF TEMP = '1' THEN
					OUT_X <= '1';
				ELSE
					OUT_X <= '0';
				END IF;
			END IF;
		END PROCESS GeneriC_Reg_Overflow;	
END Gen_Register_Overflow;