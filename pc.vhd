library ieee;
use ieee.std_logic_1164.all;

entity pc is
    port(
        alu_out : in std_logic_vector(7 downto 0);  -- ALU �����8λ
        en      : in std_logic;                     -- ʹ���ź�
        clk     : in std_logic;                     -- ʱ���ź�
        reset   : in std_logic;                     -- ��λ�ź�
        q       : out std_logic_vector(7 downto 0)  -- ��� PC �Ĵ�����ֵ��8λ
    );
end pc;

architecture behave of pc is
begin
    process(clk, reset)
    begin
        if reset = '0' then
            -- �����λ�ź�Ϊ�͵�ƽ���� PC �Ĵ�����ֵ����
            q <= (others => '0');
        elsif rising_edge(clk) then
            -- �������ش���ʱ���ź�ʱִ��
            if en = '1' then
                -- ���ʹ���ź�Ϊ�ߵ�ƽ���� PC �Ĵ�����ֵ����Ϊ ALU ���ֵ
                q <= alu_out;
            end if;
        end if;
    end process;
end behave;
