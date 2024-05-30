library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(timer:                   in std_logic_vector(2 downto 0);
     instruction:             in std_logic_vector(15 downto 0);
     c,z,v,s:                 in std_logic;
     dest_reg,sour_reg:       out std_logic_vector(3 downto 0);
     offset:                  out std_logic_vector(7 downto 0);
     sst,sci,rec:             out std_logic_vector(1 downto 0);
     alu_func,alu_in_sel:     out std_logic_vector(2 downto 0);
     en_reg,en_pc,wr:         out std_logic);
end controller;

architecture behave of controller is
begin
	process(timer,instruction,c,z,v,s)
	variable temp1,temp2 : std_logic_vector(7 downto 0) ;
	variable temp3,temp4 : std_logic_vector(3 downto 0) ;
	variable alu_out_sel: std_logic_vector(1 downto 0);
	begin
	    for I in 7 downto 0 loop
		    temp1(I):=instruction(I+8);
		    temp2(I):=instruction(I);
	    end loop;
	    for I in 3 downto 0 loop
		    temp3(I):=instruction(I+4);
		    temp4(I):=instruction(I);
	    end loop;
		case timer is
		    when "100"=>
				dest_reg<="0000";
				sour_reg<="0000";
				offset<="00000000";
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="00";
			when "000"=>
				dest_reg<="0000";
				sour_reg<="0000";
				offset<="00000000";
				sci<="01";
				sst<="11";
				alu_out_sel:="10";
				alu_in_sel<="100";
				alu_func<="000";
				wr<='1';
				rec<="01";
			when "001"=>
				dest_reg<="0000";
				sour_reg<="0000";
				offset<="00000000";
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="10";
			when "011"=>
				wr<='1';
				rec<="00";
				case temp1 is
					when "00000000"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="000";
					when "00000001"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="001";
					when "00000010"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="010";
					when "00000011"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="001";
					when "00000100"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="100";
					when "00000101"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="010";
					when "00000110"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="011";
					when "00000111"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="11";
					alu_out_sel:="01";
					alu_in_sel<="001";
					alu_func<="000";
					when "00001000"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="01";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="001";
					when "00001001"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="01";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="000";
					when "00001010"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="101";
					when "00001011"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="110";
					when "00001100"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="10";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="000";
					when "00001101"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="00000000";
					sci<="10";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="001";
					when "01000000"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:="10";
					alu_in_sel<="011";
					alu_func<="000";
					when "01000100"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=c&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "01000101"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=(not c)&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "01000110"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=z&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "01000111"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=(not z)&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "01000001"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=s&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "01000011"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=(not s)&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "01111000"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="01";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="000";
					when "01111010"=>
					dest_reg<="0000";
					sour_reg<="0000";
					offset<=temp2;
					sci<="00";
					sst<="10";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="000";
					when others=>
					null;
				end case;
			when "101"=>
				alu_func<="000";
				wr<='1';
				sst<="11";
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="00000000";
				case temp1 is
					when "10000000" | "10000001"=>
					sci<="01";
					alu_out_sel:="10";
					alu_in_sel<="100";
					rec<="01";
					when "10000010"=> 
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="001";
					rec<="11";
					when "10000011"=>
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="010";
					rec<="11";
					when others=>
					null;
				end case;
			when "111"=>
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="00000000";
				sci<="00";
				sst<="11";
				alu_func<="000";
				rec<="00";
				case temp1 is
					when "10000010" | "10000001"=>
					alu_out_sel:="01";
					alu_in_sel<="101";
					wr<='1';
					when "10000000"=> 
					alu_out_sel:="10";
					alu_in_sel<="101";
					wr<='1';
					when "10000011"=>
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