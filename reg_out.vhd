library ieee;
use ieee.std_logic_1164.all;


entity reg_out is
    port(
        ir, pc, reg_in, reg_testa:  in std_logic_vector(7 downto 0);  -- ����Ĵ������ݣ�8λ
        offset, alu_a, alu_b, alu_out:  in std_logic_vector(7 downto 0);  -- ���� ALU ���ݣ�8λ
        reg_sel:  in std_logic_vector(1 downto 0);  -- ѡ��Ĵ����źţ�4λ
        sel:      in std_logic_vector(1 downto 0);  -- ѡ���źţ�2λ
        reg_data: out std_logic_vector(7 downto 0)  -- ����Ĵ������ݣ�8λ
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
                -- ���ѡ���ź�Ϊ "00"�����������Ĵ�������
                reg_data <= reg_in;
            when "01"=>
                -- ���ѡ���ź�Ϊ "01"�������ѡ��ļĴ����ź������Ӧ������
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
                        reg_data <= (others => '0');  -- ����������������ȫ��
                end case;
            when "11"=>
                -- ���ѡ���ź�Ϊ "11"�������ѡ��ļĴ����ź������Ӧ������
                case reg_sel is
                    when "1110"=>
                        reg_data <= pc;
                    when "1111"=>
                        reg_data <= ir;
                    when others=>
                        reg_data <= (others => '0');  -- ����������������ȫ��
                end case;
            when others=>
                reg_data <= (others => '0');  -- ��������ѡ���ź�ֵ�����ȫ��
        end case;
    end process;
end behave;
