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
		ram(0)<="11010000";  --MVRD��Ŀ��0�żĴ���
		ram(1)<="00000011";  --д��3��0�żĴ���
		ram(2)<="11010100";  --MVRD��Ŀ��1�żĴ���
		ram(3)<="00000001";  --д��1��1�żĴ���
		ram(4)<="00000001";  --ADD��0�żĴ�����1�żĴ�����ӽ��д��0�żĴ���
		ram(5)<="11000000";  --JMPA
		ram(6)<="00000000";  --��ת��0�ŵ�ַ��Ԫִ��
		IF wr='0'THEN
			ram(conv_integer(adr))<=din;  --wr=0ʱ��din����д��adrָ�����ڴ浥Ԫ
			dout<=(others=>'Z');
		ELSE
			dout<=ram(conv_integer(adr));  --wr=1ʱ����adrָ�����ڴ浥Ԫ������
		END IF;
	END PROCESS;
END rtl;