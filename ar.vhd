library ieee;
use ieee.std_logic_1164.all;

entity ar is
    port(
        alu_out : in std_logic_vector(7 downto 0);  -- ALU �����8λ
        pc      : in std_logic_vector(7 downto 0);  -- ���������ֵ��8λ
        rec     : in std_logic_vector(1 downto 0); -- ָ����������룬2λ
        clk     : in std_logic;                     -- ʱ���ź�
        reset   : in std_logic;                     -- ��λ�ź�
        q       : out std_logic_vector(7 downto 0)  -- ��� AR �Ĵ�����ֵ��8λ
    );
end ar;

architecture behave of ar is
begin
    process(clk, reset)
    begin
        if reset = '0' then
            -- �����λ�ź�Ϊ�͵�ƽ���� AR �Ĵ�����ֵ����
            q <= (others => '0');
        elsif rising_edge(clk) then
            -- �������ش���ʱ���ź�ʱִ��
            case rec is
                when "01"=>
                    -- ���ָ�����������Ϊ "01"���� AR �Ĵ�����ֵ����Ϊ�����������ֵ
                    q <= pc;
                when "11"=>
                    -- ���ָ�����������Ϊ "11"���� AR �Ĵ�����ֵ����Ϊ ALU �����ֵ
                    q <= alu_out;
                when others=>
                    -- ��������������� AR �Ĵ�����ֵ���ֲ���
                    null;
            end case;
        end if;
    end process;
end behave;
