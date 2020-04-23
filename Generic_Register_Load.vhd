LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Generic_Register_Load IS
	GENERIC
	(
		N	:	INTEGER
	);
	
	PORT
	(
		IN_A	:	INOUT	STD_LOGIC_VECTOR	(N-1 DOWNTO 0);	-- INPUT USER
		IN_B	:	IN		STD_LOGIC;									--	LOAD
		IN_C	:	INOUT	STD_LOGIC;									-- SHIFT
		SEL	:	IN		STD_LOGIC;									-- SELECT
		OUT_X	:	OUT	STD_LOGIC									-- OUTPUT
	);
END Generic_Register_Load;

ARCHITECTURE Gen_Register_Load OF Generic_Register_Load IS
	SIGNAL	INPUT	: STD_LOGIC_VECTOR	(N-1 DOWNTO 0);
	SIGNAL	FLAG_1,FLAG_2	: INTEGER;
	
	BEGIN
		Generic_Reg_Load : PROCESS (IN_A,IN_B,IN_C,SEL)
		BEGIN
			IF	IN_B = '1' THEN
				INPUT(0)		<= IN_A(0);
				INPUT(1)		<= IN_A(1);
				INPUT(2)		<= IN_A(2);
				INPUT(3)		<= IN_A(3);
				INPUT(4)		<= IN_A(4);
				INPUT(5)		<= IN_A(5);
				INPUT(6)		<= IN_A(6);
				INPUT(7)		<= IN_A(7);
				INPUT(8)		<= IN_A(8);
				INPUT(9)		<= IN_A(9);
				INPUT(10)	<= IN_A(10);
				INPUT(11)	<= IN_A(11);
				INPUT(12)	<= IN_A(12);
				INPUT(13)	<= IN_A(13);
				INPUT(14)	<= IN_A(14);
				INPUT(15)	<= IN_A(15);
				
			END IF;

			IF	IN_C = '1' THEN
				OUT_X <= INPUT(0);
				INPUT(0)		<= INPUT(1);
				INPUT(1)		<= INPUT(2);
				INPUT(2)		<= INPUT(3);
				INPUT(3)		<= INPUT(4);
				INPUT(4)		<= INPUT(5);
				INPUT(5)		<= INPUT(6);
				INPUT(6)		<= INPUT(7);
				INPUT(7)		<= INPUT(8);
				INPUT(8)		<= INPUT(9);
				INPUT(9)		<= INPUT(10);
				INPUT(10)	<= INPUT(11);
				INPUT(11)	<= INPUT(12);
				INPUT(12)	<= INPUT(13);
				INPUT(13)	<= INPUT(14);
				INPUT(14)	<= INPUT(15);
				
				IF SEL = '1' THEN
					INPUT(15)	<=	'1';
				ELSE
					INPUT(15)	<= '0';
				END IF;
			END IF;
		END PROCESS GeneriC_Reg_Load;	
END Gen_Register_Load;