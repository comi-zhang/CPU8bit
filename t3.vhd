library ieee;
use ieee.std_logic_1164.all;

entity t3 is
    port(
        wr:      in std_logic;  -- дʹ���ź�
        alu_out: in std_logic_vector(7 downto 0);  -- ALU ������ݣ�8λ
        output:  out std_logic_vector(7 downto 0)  -- ������ݣ�8λ
    );
end t3;

architecture behave of t3 is
begin
    process(wr, alu_out)
    begin
        case wr is
            when '1'=>
                -- ���дʹ���ź�Ϊ '1'�����������̬��δ���ӣ�
                output <= (others => 'Z');
            when '0'=>
                -- ���дʹ���ź�Ϊ '0'������� ALU �������
                output <= alu_out;
        end case;
    end process;
end behave;
