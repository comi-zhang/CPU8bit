library ieee;
use ieee.std_logic_1164.all;

entity t3 is
    port(
        wr:      in std_logic;  -- 写使能信号
        alu_out: in std_logic_vector(7 downto 0);  -- ALU 输出数据，8位
        output:  out std_logic_vector(7 downto 0)  -- 输出数据，8位
    );
end t3;

architecture behave of t3 is
begin
    process(wr, alu_out)
    begin
        case wr is
            when '1'=>
                -- 如果写使能信号为 '1'，则输出高阻态（未连接）
                output <= (others => 'Z');
            when '0'=>
                -- 如果写使能信号为 '0'，则输出 ALU 输出数据
                output <= alu_out;
        end case;
    end process;
end behave;
