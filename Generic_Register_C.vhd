LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Generic_Register_C IS
	GENERIC
	(
		N	:	INTEGER
	);
	
	PORT
	(
		C		:	INOUT	STD_LOGIC_VECTOR	(N-1 DOWNTO 0);
		SHIFT	:	INOUT	STD_LOGIC;
		C15	:	OUT	STD_LOGIC
	);
END Generic_Register_C;

ARCHITECTURE Gen_Register_C OF Generic_Register_C IS
	BEGIN
		Generic_Reg_C : PROCESS (C, SHIFT)
		BEGIN
			IF SHIFT = '1' AND SHIFT'EVENT THEN
				C	<= STD_LOGIC_VECTOR(SIGNED(C) + 1);
				IF	C = "1111" THEN
					C15 <= '1';
				ELSE
					C15 <= '0';
				END IF;
			END IF;
		END PROCESS GeneriC_Reg_C;	
END Gen_Register_c;