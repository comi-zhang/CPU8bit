library ieee;
use ieee.std_logic_1164.all;


entity reg_out is
    port(
        ir,pc,reg_in:  in std_logic_vector(7 downto 0);  -- 输入寄存器数据，8位
        offset,alu_a,alu_b,alu_out,reg_testa1,reg_testa2:  in std_logic_vector(7 downto 0);  -- 输入 ALU 数据，8位
        reg_sel:  in std_logic_vector(1 downto 0);  -- 选择寄存器信号，4位
        sel:      in std_logic_vector(1 downto 0);  -- 选择信号，2位
        reg_data1,reg_data2: out std_logic_vector(7 downto 0)  -- 输出寄存器数据，8位
    );
end reg_out;

architecture behave of reg_out is
begin
    process(ir, pc, reg_in, sel, reg_sel, offset, alu_a, alu_b, alu_out, reg_testa1, reg_testa2)
    variable temp: std_logic_vector(3 downto 0);
    begin
        temp := sel & reg_sel;
        case sel is
            when "00"=>
                -- 如果选择信号为 "00"，则输出输入寄存器数据
                reg_data2 <= reg_in;
            when "01"=>
                -- 如果选择信号为 "01"，则根据选择的寄存器信号输出对应的数据
                case reg_sel is
                    when "00"=>
                        reg_data2 <= offset;
                    when "01"=>
                        reg_data2 <= alu_a;
                    when "10"=>
                        reg_data2 <= alu_b;
                    when "11"=>
                        reg_data2 <= alu_out;
                end case;
            when "10"=>
				case reg_sel is
                    when "00"=>
                        reg_data2 <= pc;
                    when "01"=>
                        reg_data2 <= ir;
                    when others=>
						reg_data2 <= (others => '0');  -- 对于其他情况，输出全零
                end case;
            when "11"=>
                -- 如果选择信号为 "11"，则根据选择的寄存器信号输出对应的数据
                case reg_sel is
                    when "00"=>
						reg_data1 <= reg_testa1;
                        reg_data2 <= reg_testa2;
                    when others=>
                        reg_data2 <= (others => '0');  -- 对于其他情况，输出全零
                end case;
            when others=>
                reg_data2 <= (others => '0');  -- 对于其他选择信号值，输出全零
        end case;
    end process;
end behave;
