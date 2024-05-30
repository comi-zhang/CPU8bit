library ieee;
use ieee.std_logic_1164.all;

entity pc is
    port(
        alu_out : in std_logic_vector(7 downto 0);  -- ALU 输出，8位
        en      : in std_logic;                     -- 使能信号
        clk     : in std_logic;                     -- 时钟信号
        reset   : in std_logic;                     -- 复位信号
        q       : out std_logic_vector(7 downto 0)  -- 输出 PC 寄存器的值，8位
    );
end pc;

architecture behave of pc is
begin
    process(clk, reset)
    begin
        if reset = '0' then
            -- 如果复位信号为低电平，则将 PC 寄存器的值清零
            q <= (others => '0');
        elsif rising_edge(clk) then
            -- 在上升沿触发时钟信号时执行
            if en = '1' then
                -- 如果使能信号为高电平，则将 PC 寄存器的值设置为 ALU 输出值
                q <= alu_out;
            end if;
        end if;
    end process;
end behave;
