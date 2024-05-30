LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY asynram IS
GENERIC(ram_width: POSITIVE :=8;
        adr_width : POSITIVE :=8);
PORT (  din  : IN  STD_LOGIC_VECTOR((ram_width-1) DOWNTO 0);
		dout : OUT STD_LOGIC_VECTOR((ram_width-1) DOWNTO 0);
		adr  : IN  STD_LOGIC_VECTOR((adr_width-1) DOWNTO 0);
		wr   : IN  STD_LOGIC
);
END asynram;

ARCHITECTURE rtl OF asynram IS
SUBTYPE ram_word IS STD_LOGIC_VECTOR(0 TO (ram_width-1) );
TYPE ram_type IS ARRAY (0 TO (64)) OF ram_word;
SIGNAL ram:ram_type;
BEGIN
	PROCESS(wr,adr,ram)BEGIN
		ram(0)<="11010000";  --MVRD，目标0号寄存器
		ram(1)<="00000011";  --写入3到0号寄存器
		ram(2)<="11010100";  --MVRD，目标1号寄存器
		ram(3)<="00000001";  --写入1到1号寄存器
		ram(4)<="00000001";  --ADD，0号寄存器与1号寄存器相加结果写入0号寄存器
		ram(5)<="11000000";  --JMPA
		ram(6)<="00000000";  --跳转到0号地址单元执行
		IF wr='0'THEN
			ram(conv_integer(adr))<=din;  --wr=0时将din内容写进adr指定的内存单元
			dout<=(others=>'Z');
		ELSE
			dout<=ram(conv_integer(adr));  --wr=1时读出adr指定的内存单元的内容
		END IF;
	END PROCESS;
END rtl;