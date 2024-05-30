library ieee;
use ieee.std_logic_1164.all;


entity reg_out is
    port(
        ir, pc, reg_in, reg_testa:  in std_logic_vector(7 downto 0);  -- 输入寄存器数据，8位
        offset, alu_a, alu_b, alu_out:  in std_logic_vector(7 downto 0);  -- 输入 ALU 数据，8位
        reg_sel:  in std_logic_vector(1 downto 0);  -- 选择寄存器信号，4位
        sel:      in std_logic_vector(1 downto 0);  -- 选择信号，2位
        reg_data: out std_logic_vector(7 downto 0)  -- 输出寄存器数据，8位
    );
end reg_out;

architecture behave of reg_out is
begin
    process(ir, pc, reg_in, sel, reg_sel, offset, alu_a, alu_b, alu_out, reg_testa)
    variable temp: std_logic_vector(5 downto 0);
    begin
        temp := sel & reg_sel;
        case sel is
            when "00"=>
                -- 如果选择信号为 "00"，则输出输入寄存器数据
                reg_data <= reg_in;
            when "01"=>
                -- 如果选择信号为 "01"，则根据选择的寄存器信号输出对应的数据
                case reg_sel is
                    when "0000"=>
                        reg_data <= offset;
                    when "0001"=>
                        reg_data <= alu_a;
                    when "0010"=>
                        reg_data <= alu_b;
                    when "0011"=>
                        reg_data <= alu_out;
                    when "0100"=>
                        reg_data <= reg_testa;
                    when others=>
                        reg_data <= (others => '0');  -- 对于其他情况，输出全零
                end case;
            when "11"=>
                -- 如果选择信号为 "11"，则根据选择的寄存器信号输出对应的数据
                case reg_sel is
                    when "1110"=>
                        reg_data <= pc;
                    when "1111"=>
                        reg_data <= ir;
                    when others=>
                        reg_data <= (others => '0');  -- 对于其他情况，输出全零
                end case;
            when others=>
                reg_data <= (others => '0');  -- 对于其他选择信号值，输出全零
        end case;
    end process;
end behave;
