library ieee;
use ieee.std_logic_1164.all;

entity reg_mux is
	port(reg_0:   in std_logic_vector(15 downto 0);
	     reg_1:   in std_logic_vector(15 downto 0);
		 reg_2:   in std_logic_vector(15 downto 0);
		 reg_3:   in std_logic_vector(15 downto 0);
		 reg_4:   in std_logic_vector(15 downto 0);
		 reg_5:   in std_logic_vector(15 downto 0);
		 reg_6:   in std_logic_vector(15 downto 0);
		 reg_7:   in std_logic_vector(15 downto 0);
		 reg_8:   in std_logic_vector(15 downto 0);
		 reg_9:   in std_logic_vector(15 downto 0);
		 reg_a:   in std_logic_vector(15 downto 0);
		 reg_b:   in std_logic_vector(15 downto 0);
		 reg_c:   in std_logic_vector(15 downto 0);
   		 reg_d:   in std_logic_vector(15 downto 0);
		 reg_e:   in std_logic_vector(15 downto 0);
		 reg_f:   in std_logic_vector(15 downto 0);
		 dest_reg:in std_logic_vector(3 downto 0);
		 sour_reg:in std_logic_vector(3 downto 0);
		 reg_sel: in std_logic_vector(3 downto 0);
		 en:      in std_logic;
		 en_0:    out std_logic;
	     en_1:    out std_logic;
		 en_2:    out std_logic;
		 en_3:    out std_logic;
		 en_4:    out std_logic;
		 en_5:    out std_logic;
		 en_6:    out std_logic;
		 en_7:    out std_logic;
		 en_8:    out std_logic;
		 en_9:    out std_logic;
		 en_a:    out std_logic;
		 en_b:    out std_logic;
		 en_c:    out std_logic;
   		 en_d:    out std_logic;
		 en_e:    out std_logic;
		 en_f:    out std_logic;
		 dr:      out std_logic_vector(15 downto 0);
	     sr:      out std_logic_vector(15 downto 0);
	     reg_out: out std_logic_vector(15 downto 0));
end reg_mux;

architecture behave of reg_mux is
begin
	process(dest_reg,sour_reg,reg_sel,reg_0,reg_1,
	        reg_2,reg_3,reg_4,reg_5,reg_6,
	        reg_7,reg_8,reg_9,reg_a,reg_b,
	        reg_c,reg_d,reg_e,reg_f,en)
	variable temp : std_logic_vector(15 downto 0);
	begin
		case dest_reg is
		when "0000"=>
			dr<=reg_0;
			temp := "0000000000000001";
		when "0001"=>
			dr<=reg_1;
			temp := "0000000000000010";
		when "0010"=>
			dr<=reg_2;
			temp := "0000000000000100";
		when "0011"=>
			dr<=reg_3;
			temp := "0000000000001000";
		when "0100"=>
			dr<=reg_4;
			temp := "0000000000010000";
		when "0101"=>
			dr<=reg_5;
			temp := "0000000000100000";
		when "0110"=>
			dr<=reg_6;
			temp := "0000000001000000";
		when "0111"=>
			dr<=reg_7;
			temp := "0000000010000000";
		when "1000"=>
			dr<=reg_8;
			temp := "0000000100000000";
		when "1001"=>
			dr<=reg_9;
			temp := "0000001000000000";
		when "1010"=>
			dr<=reg_a;
			temp := "0000010000000000";
		when "1011"=>
			dr<=reg_b;
			temp := "0000100000000000";
		when "1100"=>
			dr<=reg_c;
			temp := "0001000000000000";
		when "1101"=>
			dr<=reg_d;
			temp := "0010000000000000";
		when "1110"=>
			dr<=reg_e;
			temp := "0100000000000000";
		when "1111"=>
			dr<=reg_f;
			temp := "1000000000000000";
		end case;
		if en = '0' then
			temp := "0000000000000000";
		end if;
		en_0 <= temp(0);
		en_1 <= temp(1);
		en_2 <= temp(2);
		en_3 <= temp(3);
		en_4 <= temp(4);
		en_5 <= temp(5);
		en_6 <= temp(6);
		en_7 <= temp(7);
		en_8 <= temp(8);
		en_9 <= temp(9);
		en_a <= temp(10);
		en_b <= temp(11);
		en_c <= temp(12);
		en_d <= temp(13);
		en_e <= temp(14);
		en_f <= temp(15);
		case sour_reg is
		when "0000"=>
			sr<=reg_0;
		when "0001"=>
			sr<=reg_1;
		when "0010"=>
			sr<=reg_2;
		when "0011"=>
			sr<=reg_3;
		when "0100"=>
			sr<=reg_4;
		when "0101"=>
			sr<=reg_5;
		when "0110"=>
			sr<=reg_6;
		when "0111"=>
			sr<=reg_7;
		when "1000"=>
			sr<=reg_8;
		when "1001"=>
			sr<=reg_9;
		when "1010"=>
			sr<=reg_a;
		when "1011"=>
			sr<=reg_b;
		when "1100"=>
			sr<=reg_c;
		when "1101"=>
			sr<=reg_d;
		when "1110"=>
			sr<=reg_e;
		when "1111"=>
			sr<=reg_f;
		end case;
		case reg_sel is
		when "0000"=>
			reg_out<=reg_0;
		when "0001"=>
			reg_out<=reg_1;
		when "0010"=>
			reg_out<=reg_2;
		when "0011"=>
			reg_out<=reg_3;
		when "0100"=>
			reg_out<=reg_4;
		when "0101"=>
			reg_out<=reg_5;
		when "0110"=>
			reg_out<=reg_6;
		when "0111"=>
			reg_out<=reg_7;
		when "1000"=>
			reg_out<=reg_8;
		when "1001"=>
			reg_out<=reg_9;
		when "1010"=>
			reg_out<=reg_a;
		when "1011"=>
			reg_out<=reg_b;
		when "1100"=>
			reg_out<=reg_c;
		when "1101"=>
			reg_out<=reg_d;
		when "1110"=>
			reg_out<=reg_e;
		when "1111"=>
			reg_out<=reg_f;
		end case;
	end process;
end behave;