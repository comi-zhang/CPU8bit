library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(timer:                   in std_logic_vector(2 downto 0);
     instruction:             in std_logic_vector(7 downto 0);
     c,z,v,s:                 in std_logic;
     dest_reg,sour_reg:       out std_logic_vector(2 downto 0);
     offset:                  out std_logic_vector(3 downto 0);
     sst,sci,rec:             out std_logic_vector(1 downto 0);
     alu_func,alu_in_sel:     out std_logic_vector(2 downto 0);
     en_reg,en_pc,wr:         out std_logic);
end controller;

architecture behave of controller is
begin
	process(timer,instruction,c,z,v,s)
	variable temp1,temp2 : std_logic_vector(3 downto 0) ;
	variable temp3,temp4 : std_logic_vector(1 downto 0) ;
	variable alu_out_sel: std_logic_vector(1 downto 0);
	begin
	    for I in 3 downto 0 loop
		    temp1(I):=instruction(I+4);
		    temp2(I):=instruction(I);
	    end loop;
	    for I in 1 downto 0 loop
		    temp3(I):=instruction(I+2);
		    temp4(I):=instruction(I);
	    end loop;
		case timer is
		    when "000"=>  --IR<-MEM
				dest_reg<="00";
				sour_reg<="01";
				offset<="0000";
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="00";
			when "001"=>  --PC fetch instruction
				dest_reg<="00";
				sour_reg<="00";
				offset<="0000";
				sci<="01";
				sst<="11";
				alu_out_sel:="10";
				alu_in_sel<="100";
				alu_func<="000";
				wr<='1';
				rec<="01";
			when "110"=>  --IR<-MEM
				dest_reg<="00";
				sour_reg<="00";
				offset<="0000";
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="10";
			when "011"=>  --OP-CODE
				wr<='1';
				rec<="00";
				case temp1 is
					when "0000"=>  --add
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="000";
					when "0001"=> --sub
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="001";
					when "0010"=> --and
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="010";
					when "0011"=>  --xor
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="100";
					when "0100"=>  --or
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="011";
					when "0101"=>  --INC
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="01";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="000";
					when "0110"=> --DEC
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="01";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="001";
					when "0111"=> --cmp
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="001";
					when "1000"=> --ADC
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="10";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="000";
					when "1001"=> --jr
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="11";
					alu_out_sel:="10";
					alu_in_sel<="011";
					alu_func<="000";
					when "1010"=> --jrc
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="11";
					alu_out_sel:=c&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "1011"=> --JRNC
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="11";
					alu_out_sel := (not c) & '0';
					alu_in_sel<="011";
					alu_func<="000";
					when others=>
					null;
				end case;
			when "101"=> --B class
				alu_func<="000";
				wr<='1';
				sst<="11";
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="0000";
				case temp1 is
					when "1100" | "1101"=> --JMPA MVRD
					sci<="01";
					alu_out_sel:="10";
					alu_in_sel<="100";
					rec<="01";
					when "1110"=>  --LDRR
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="001";
					rec<="11";
					when "1111"=>  --STRR
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="010";
					rec<="11";
					when others=>
					null;
				end case;
			when "111"=>  --read or write memory
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="0000";
				sci<="00";
				sst<="11";
				alu_func<="000";
				rec<="00";
				case temp1 is
					when "1110" | "1101"=> --LDRR MVRD
					alu_out_sel:="01";
					alu_in_sel<="101";
					wr<='1';
					when "1110"=> --JPMA
					alu_out_sel:="10";
					alu_in_sel<="101";
					wr<='1';
					when "1111"=> --STRR
					alu_out_sel:="00";
					alu_in_sel<="001";
					wr<='0';
					when others=>
					null;
				end case;
			when others=>
			null;
		end case;
		en_reg<=alu_out_sel(0);
		en_pc<=alu_out_sel(1);
	end process;
end behave;