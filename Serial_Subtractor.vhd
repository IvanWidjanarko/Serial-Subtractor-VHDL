LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Serial_Subtractor IS
	PORT
	(
		XIN	:	INOUT	STD_LOGIC_VECTOR	(15 DOWNTO 0);
		YIN	:	INOUT	STD_LOGIC_VECTOR	(15 DOWNTO 0);
		ST		:	IN		STD_LOGIC;
		CLOCK	:	IN		STD_LOGIC;
		V		:	INOUT	STD_LOGIC
	);
END Serial_Subtractor;

ARCHITECTURE Serial_Sub	OF Serial_Subtractor IS
	SIGNAL	XO,YP,NOT_YP,S,CA,CB,OV,SHIFT,CLK,LOAD,C15	:	STD_LOGIC;
	SIGNAL	C	:	STD_LOGIC_VECTOR	(3 DOWNTO 0);
	
	COMPONENT Generic_Register_Control
		GENERIC
		(
			N	:	INTEGER
		);
		
		PORT
		(
			IN_A	:	IN		STD_LOGIC_VECTOR	(N-1 DOWNTO 0);	-- C
			IN_B	:	IN		STD_LOGIC;									-- ST
			CLOCK	:	IN		STD_LOGIC;									-- CLK	
			OUT_X	:	INOUT	STD_LOGIC;									-- SHIFT
			OUT_Y	:	OUT	STD_LOGIC									--	LOAD
			
		);
	END COMPONENT Generic_Register_Control;

	COMPONENT Generic_Register_C
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
	END COMPONENT Generic_Register_C;

	COMPONENT Generic_Register_Load
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
	END COMPONENT Generic_Register_Load;
		
	COMPONENT Generic_Full_Adder
		GENERIC
		(
			N	:	INTEGER
		);

		PORT
		(
			IN_A	:	IN		STD_LOGIC;
			IN_B	:	IN		STD_LOGIC;
			C_IN	:	IN		STD_LOGIC;
			C_OUT	:	OUT	STD_LOGIC;
			OUT_X	:	OUT	STD_LOGIC
		);
	END COMPONENT Generic_Full_Adder;
	
	COMPONENT Generic_D_FF
		GENERIC
		(
			N	:	INTEGER
		);
		
		PORT
		(
			D		:	IN		STD_LOGIC;
			CLOCK	:	IN		STD_LOGIC;
			Q_D	:	INOUT	STD_LOGIC
		);
	END COMPONENT Generic_D_FF;

	COMPONENT Generic_Register_Overflow
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
	END COMPONENT Generic_Register_Overflow;
	
BEGIN

	CONTROL : Generic_Register_Control
		GENERIC MAP(4)
		
		PORT MAP
		(
			IN_A	=>	C,
			IN_B	=>	ST,
			CLOCK	=>	CLK,
			OUT_X	=>	SHIFT,
			OUT_Y	=>	LOAD
			
		);
	
	Reg_C : Generic_Register_C
		GENERIC MAP(4)
		
		PORT MAP
		(
			C		=>	C,
			SHIFT	=>	SHIFT,
			C15	=>	C15
		);

	Reg_Load_X : Generic_Register_Load
		GENERIC MAP(16)
		
		PORT MAP
		(
			IN_A	=>	XIN,
			IN_B	=>	LOAD,
			IN_C	=>	SHIFT,
			SEL	=>	S,
			OUT_X	=>	XO
		);
		
	Reg_Load_Y : Generic_Register_Load
		GENERIC MAP(16)
		
		PORT MAP
		(
			IN_A	=>	YIN,
			IN_B	=>	LOAD,
			IN_C	=>	SHIFT,
			SEL	=>	S,
			OUT_X	=>	YP
		);
		
	NOT_YP	<=	NOT(YP);
	
	FA : Generic_Full_Adder
		GENERIC MAP(1)

		PORT MAP
		(
			IN_A	=>	XO,
			IN_B	=>	NOT_YP,
			C_IN	=>	CA,
			C_OUT	=>	CB,
			OUT_X	=>	S
		);
		
	Carry_FF : Generic_D_FF
		GENERIC MAP(0)
		
		PORT MAP
		(
			D		=>	CB,
			CLOCK	=>	SHIFT,
			Q_D	=>	CA
		);
	
	Overflow : Generic_Register_Overflow
		GENERIC MAP(0)
		
		PORT MAP
		(
			IN_A	=>	XO,
			IN_B	=>	NOT_YP,
			IN_C	=>	CB,
			IN_D	=>	C15,
			OUT_X	=>	OV
		);
		
	D_FF : Generic_D_FF
		GENERIC MAP(0)
		
		PORT MAP
		(
			D		=>	OV,
			CLOCK	=>	SHIFT,
			Q_D	=>	v
		);
		
END Serial_Sub;