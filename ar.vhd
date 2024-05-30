library ieee;
use ieee.std_logic_1164.all;

entity ar is
    port(
        alu_out : in std_logic_vector(7 downto 0);  -- ALU 输出，8位
        pc      : in std_logic_vector(7 downto 0);  -- 程序计数器值，8位
        rec     : in std_logic_vector(1 downto 0); -- 指令接收器输入，2位
        clk     : in std_logic;                     -- 时钟信号
        reset   : in std_logic;                     -- 复位信号
        q       : out std_logic_vector(7 downto 0)  -- 输出 AR 寄存器的值，8位
    );
end ar;

architecture behave of ar is
begin
    process(clk, reset)
    begin
        if reset = '0' then
            -- 如果复位信号为低电平，则将 AR 寄存器的值清零
            q <= (others => '0');
        elsif rising_edge(clk) then
            -- 在上升沿触发时钟信号时执行
            case rec is
                when "01"=>
                    -- 如果指令接收器输入为 "01"，则将 AR 寄存器的值设置为程序计数器的值
                    q <= pc;
                when "11"=>
                    -- 如果指令接收器输入为 "11"，则将 AR 寄存器的值设置为 ALU 输出的值
                    q <= alu_out;
                when others=>
                    -- 对于其他情况，将 AR 寄存器的值保持不变
                    null;
            end case;
        end if;
    end process;
end behave;
