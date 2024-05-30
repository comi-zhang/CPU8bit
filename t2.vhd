library ieee;
use ieee.std_logic_1164.all;

entity t2 is
    port(
        offset_8    : in std_logic_vector(7 downto 0);      -- 8λƫ��������
        offset_16   : out std_logic_vector(7 downto 0)      -- 8λƫ�������
    );
end t2;

architecture behave of t2 is
begin
    process(offset_8)
    begin
        -- �������ƫ����ֱ�����
        offset_16 <= offset_8;
    end process;
end behave;
