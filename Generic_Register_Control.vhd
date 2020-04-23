LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Generic_Register_Control IS
	GENERIC
	(
		N	:	INTEGER
	);
	
	PORT
	(
		IN_A	:	IN		STD_LOGIC_VECTOR	(N-1 DOWNTO 0);	-- C15
		IN_B	:	IN		STD_LOGIC;									-- ST
		CLOCK	:	IN		STD_LOGIC;									-- CLK	
		OUT_X	:	INOUT	STD_LOGIC;									-- SHIFT
		OUT_Y	:	OUT	STD_LOGIC									--	LOAD
		
	);
END Generic_Register_Control;

ARCHITECTURE Gen_Register_Control OF Generic_Register_Control IS
	BEGIN
		Generic_Reg_Control_1 : PROCESS (IN_B)
		BEGIN
			IF IN_B = '1' THEN
				OUT_Y	<= '1';
			END IF;
		END PROCESS Generic_Reg_Control_1;
		
		Generic_Reg_Control_2 : PROCESS (IN_A,CLOCK)
		BEGIN
			IF CLOCK = '1' AND CLOCK'EVENT THEN
				IF IN_A /= "111" THEN
					OUT_X <= '1';
				END IF;
			END IF;
		END PROCESS GeneriC_Reg_Control_2;	
END Gen_Register_Control;