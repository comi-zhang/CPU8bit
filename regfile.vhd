library ieee;
use ieee.std_logic_1164.all;

entity regfile is
    port(  
        DR        : in std_logic_vector(1 downto 0);   -- 选择目标寄存器的信号
        SR        : in std_logic_vector(1 downto 0);   -- 选择源寄存器的信号
        reg_sel   : in std_logic_vector(1 downto 0);  -- 选择从哪个寄存器输出的信号
        reset     : in std_logic;                      -- 复位信号
        write     : in std_logic;                      -- 写使能信号
        clk       : in std_logic;                      -- 时钟信号
        d_input   : in std_logic_vector(7 downto 0);  -- 输入数据
        output_DR : out std_logic_vector(7 downto 0); -- 目标寄存器输出数据
        output_SR : out std_logic_vector(7 downto 0); -- 源寄存器输出数据
        reg_out   : out std_logic_vector(7 downto 0);  -- 选择的寄存器输出数据
        en        : in std_logic                      -- 写入使能信号
    );
end regfile;

architecture struct of regfile is 

    component reg is 
        port(
            reset    : in std_logic;                           -- 复位信号
            d_input  : in std_logic_vector(7 downto 0);       -- 输入数据
            clk      : in std_logic;                           -- 时钟信号
            write    : in std_logic;                           -- 写使能信号
            en       : in std_logic;                           -- 写入使能信号
            sel      : in std_logic;                           -- 选择信号
            q_output : out std_logic_vector(7 downto 0)       -- 输出数据
        );
    end component;

    component mux_4_to_1 is 
        port(
            input0,
            input1,
            input2,
            input3  : in std_logic_vector(7 downto 0);        -- 输入数据
            sel     : in std_logic_vector(1 downto 0);        -- 选择信号
            out_put : out std_logic_vector(7 downto 0)        -- 输出数据
        );
    end component;

    component decoder_2_to_4 is 
        port(
            sel     : in std_logic_vector(1 downto 0);        -- 输入选择信号
            sel00   : out std_logic;                          -- 输出选择信号
            sel01   : out std_logic;                          -- 输出选择信号
            sel02   : out std_logic;                          -- 输出选择信号
            sel03   : out std_logic                           -- 输出选择信号
        );
    end component;

    signal reg00,reg01,reg02,reg03: std_logic_vector(7 downto 0);  -- 寄存器数据
    signal sel00,sel01,sel02,sel03: std_logic;                     -- 选择信号

begin

    -- 实例化寄存器
    Areg00: reg port map(
        reset    => reset,            -- 复位信号
        d_input  => d_input,          -- 输入数据
        clk      => clk,              -- 时钟信号
        write    => write,            -- 写使能信号
        en       => en,               -- 写入使能信号
        sel      => sel00,            -- 选择信号
        q_output => reg00             -- 输出数据
    );

    Areg01: reg port map(
        reset    => reset,            -- 复位信号
        d_input  => d_input,          -- 输入数据
        clk      => clk,              -- 时钟信号
        write    => write,            -- 写使能信号
        en       => en,               -- 写入使能信号
        sel      => sel01,            -- 选择信号
        q_output => reg01             -- 输出数据
    );

    Areg02: reg port map(
        reset    => reset,            -- 复位信号
        d_input  => d_input,          -- 输入数据
        clk      => clk,              -- 时钟信号
        write    => write,            -- 写使能信号
        en       => en,               -- 写入使能信号
        sel      => sel02,            -- 选择信号
        q_output => reg02             -- 输出数据
    );

    Areg03: reg port map(
        reset    => reset,            -- 复位信号
        d_input  => d_input,          -- 输入数据
        clk      => clk,              -- 时钟信号
        write    => write,            -- 写使能信号
        en       => en,               -- 写入使能信号
        sel      => sel03,            -- 选择信号
        q_output => reg03             -- 输出数据
    );

    -- 2-4译码器，将 2 位选择信号转换为 4 位选择信号
    des_decoder: decoder_2_to_4 port map(
        sel      => DR,               -- 输入选择信号
        sel00    => sel00,            -- 输出选择信号
        sel01    => sel01,            -- 输出选择信号
        sel02    => sel02,            -- 输出选择信号
        sel03    => sel03             -- 输出选择信号
    );

    -- 4选1选择器，选择目标寄存器
    muxA: mux_4_to_1 port map(
        input0    => reg00,           -- 输入数据
        input1    => reg01,           -- 输入数据
        input2    => reg02,           -- 输入数据
        input3    => reg03,           -- 输入数据
        sel       => DR,              -- 选择信号
        out_put   => output_DR        -- 输出数据
    );

    -- 4选1选择器，选择源寄存器
    muxB: mux_4_to_1 port map(
        input0    => reg00,           -- 输入数据
        input1    => reg01,           -- 输入数据
        input2    => reg02,           -- 输入数据
        input3    => reg03,           -- 输入数据
        sel       => SR,              -- 选择信号
        out_put   => output_SR        -- 输出数据
    );

    -- 根据选择的寄存器，输出相应的数据
    reg_out <= reg00 when reg_sel = "00" else   -- 如果 reg_sel 是 "00"，输出 reg00
               reg01 when reg_sel = "01" else   -- 如果 reg_sel 是 "01"，输出 reg01
               reg02 when reg_sel = "10" else   -- 如果 reg_sel 是 "10"，输出 reg02
               reg03;                           -- 如果 reg_sel 是 "11"，输出 reg03

end struct;
