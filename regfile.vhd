library ieee;
use ieee.std_logic_1164.all;

entity regfile is
    port(  
        DR        : in std_logic_vector(1 downto 0);   -- ѡ��Ŀ��Ĵ������ź�
        SR        : in std_logic_vector(1 downto 0);   -- ѡ��Դ�Ĵ������ź�
        reg_sel   : in std_logic_vector(1 downto 0);  -- ѡ����ĸ��Ĵ���������ź�
        reset     : in std_logic;                      -- ��λ�ź�
        write     : in std_logic;                      -- дʹ���ź�
        clk       : in std_logic;                      -- ʱ���ź�
        d_input   : in std_logic_vector(7 downto 0);  -- ��������
        output_DR : out std_logic_vector(7 downto 0); -- Ŀ��Ĵ����������
        output_SR : out std_logic_vector(7 downto 0); -- Դ�Ĵ����������
        reg_out   : out std_logic_vector(7 downto 0);  -- ѡ��ļĴ����������
        en        : in std_logic                      -- д��ʹ���ź�
    );
end regfile;

architecture struct of regfile is 

    component reg is 
        port(
            reset    : in std_logic;                           -- ��λ�ź�
            d_input  : in std_logic_vector(7 downto 0);       -- ��������
            clk      : in std_logic;                           -- ʱ���ź�
            write    : in std_logic;                           -- дʹ���ź�
            en       : in std_logic;                           -- д��ʹ���ź�
            sel      : in std_logic;                           -- ѡ���ź�
            q_output : out std_logic_vector(7 downto 0)       -- �������
        );
    end component;

    component mux_4_to_1 is 
        port(
            input0,
            input1,
            input2,
            input3  : in std_logic_vector(7 downto 0);        -- ��������
            sel     : in std_logic_vector(1 downto 0);        -- ѡ���ź�
            out_put : out std_logic_vector(7 downto 0)        -- �������
        );
    end component;

    component decoder_2_to_4 is 
        port(
            sel     : in std_logic_vector(1 downto 0);        -- ����ѡ���ź�
            sel00   : out std_logic;                          -- ���ѡ���ź�
            sel01   : out std_logic;                          -- ���ѡ���ź�
            sel02   : out std_logic;                          -- ���ѡ���ź�
            sel03   : out std_logic                           -- ���ѡ���ź�
        );
    end component;

    signal reg00,reg01,reg02,reg03: std_logic_vector(7 downto 0);  -- �Ĵ�������
    signal sel00,sel01,sel02,sel03: std_logic;                     -- ѡ���ź�

begin

    -- ʵ�����Ĵ���
    Areg00: reg port map(
        reset    => reset,            -- ��λ�ź�
        d_input  => d_input,          -- ��������
        clk      => clk,              -- ʱ���ź�
        write    => write,            -- дʹ���ź�
        en       => en,               -- д��ʹ���ź�
        sel      => sel00,            -- ѡ���ź�
        q_output => reg00             -- �������
    );

    Areg01: reg port map(
        reset    => reset,            -- ��λ�ź�
        d_input  => d_input,          -- ��������
        clk      => clk,              -- ʱ���ź�
        write    => write,            -- дʹ���ź�
        en       => en,               -- д��ʹ���ź�
        sel      => sel01,            -- ѡ���ź�
        q_output => reg01             -- �������
    );

    Areg02: reg port map(
        reset    => reset,            -- ��λ�ź�
        d_input  => d_input,          -- ��������
        clk      => clk,              -- ʱ���ź�
        write    => write,            -- дʹ���ź�
        en       => en,               -- д��ʹ���ź�
        sel      => sel02,            -- ѡ���ź�
        q_output => reg02             -- �������
    );

    Areg03: reg port map(
        reset    => reset,            -- ��λ�ź�
        d_input  => d_input,          -- ��������
        clk      => clk,              -- ʱ���ź�
        write    => write,            -- дʹ���ź�
        en       => en,               -- д��ʹ���ź�
        sel      => sel03,            -- ѡ���ź�
        q_output => reg03             -- �������
    );

    -- 2-4���������� 2 λѡ���ź�ת��Ϊ 4 λѡ���ź�
    des_decoder: decoder_2_to_4 port map(
        sel      => DR,               -- ����ѡ���ź�
        sel00    => sel00,            -- ���ѡ���ź�
        sel01    => sel01,            -- ���ѡ���ź�
        sel02    => sel02,            -- ���ѡ���ź�
        sel03    => sel03             -- ���ѡ���ź�
    );

    -- 4ѡ1ѡ������ѡ��Ŀ��Ĵ���
    muxA: mux_4_to_1 port map(
        input0    => reg00,           -- ��������
        input1    => reg01,           -- ��������
        input2    => reg02,           -- ��������
        input3    => reg03,           -- ��������
        sel       => DR,              -- ѡ���ź�
        out_put   => output_DR        -- �������
    );

    -- 4ѡ1ѡ������ѡ��Դ�Ĵ���
    muxB: mux_4_to_1 port map(
        input0    => reg00,           -- ��������
        input1    => reg01,           -- ��������
        input2    => reg02,           -- ��������
        input3    => reg03,           -- ��������
        sel       => SR,              -- ѡ���ź�
        out_put   => output_SR        -- �������
    );

    -- ����ѡ��ļĴ����������Ӧ������
    reg_out <= reg00 when reg_sel = "00" else   -- ��� reg_sel �� "00"����� reg00
               reg01 when reg_sel = "01" else   -- ��� reg_sel �� "01"����� reg01
               reg02 when reg_sel = "10" else   -- ��� reg_sel �� "10"����� reg02
               reg03;                           -- ��� reg_sel �� "11"����� reg03

end struct;