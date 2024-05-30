library ieee;
use ieee.std_logic_1164.all;

entity regfile is port(  
	   DR        : in std_logic_vector(1 downto 0);
       SR        : in std_logic_vector(1 downto 0);
       reset     : in std_logic; 
       write     : in std_logic;
       clk       : in std_logic;
       d_input   : in std_logic_vector(7 downto 0);
       reg_sel	 : in std_logic_vector(1 downto 0);
       
       output_SR : out std_logic_vector(7 downto 0);
       output_DR : out std_logic_vector(7 downto 0);
       output	 : out std_logic_vector(7 downto 0)
);
end regfile;

architecture struct of regfile is 

component reg is port(
           reset    : in std_logic;
           d  : in std_logic_vector(7 downto 0);
           clk      : in std_logic;
           en    : in std_logic;
           sel      : in std_logic;
           q : out std_logic_vector(7 downto 0)
);
end component;

 component mux_4_to_1 is port(
      input0,
	  input1,
	  input2,
	  input3  : in std_logic_vector(7 downto 0);
	  sel     : in std_logic_vector(1 downto 0);
	  
	  out_put : out std_logic_vector(7 downto 0)
);
 end component;

 component decoder_2_to_4 is port(
     sel     : in std_logic_vector(1 downto 0);
     
	 sel00   : out std_logic;
	 sel01   : out std_logic;
	 sel02   : out std_logic;
	 sel03   : out std_logic
);
 end component;

signal reg00,reg01,reg02,reg03:std_logic_vector(7 downto 0);
signal sel00,sel01,sel02,sel03:std_logic;

begin
  Areg00: reg port map(             --¼Ä´æÆ÷R0
          reset    =>reset,
          d  =>d_input,
          clk      =>clk,
          en    =>write,
          sel      =>sel00,
          q =>reg00
          );

  Areg01: reg port map(             --¼Ä´æÆ÷R1
          reset    =>reset,
          d  =>d_input,
          clk      =>clk,
          en    =>write,
          sel      =>sel01,
          q =>reg01
          );

  Areg02: reg port map(             --¼Ä´æÆ÷R2
          reset    =>reset,
          d  =>d_input,
          clk      =>clk,
		   en    =>write,
          sel      =>sel02,
          q =>reg02
          );

  Areg03: reg port map(             --¼Ä´æÆ÷R3
          reset    =>reset,
          d  =>d_input,
          clk      =>clk,
          en    =>write,
          sel      =>sel03,
          q =>reg03
          );

  des_decoder: decoder_2_to_4 port map(             --2-4ÒëÂëÆ÷
          sel      =>DR,
          sel00    =>sel00,
          sel01    =>sel01,
          sel02    =>sel02,
          sel03    =>sel03
          );

  muxA: mux_4_to_1 port map(             --Ä¿µÄ¼Ä´æÆ÷¶Á³öÊ¹ÓÃµÄ4Ñ¡1Ñ¡ÔñÆ÷DR
          input0    =>reg00,
          input1    =>reg01,
          input2    =>reg02,
          input3    =>reg03,
          sel       =>DR,
          out_put   =>output_DR
          );

  muxB: mux_4_to_1 port map(             --Ä¿µÄ¼Ä´æÆ÷¶Á³öÊ¹ÓÃµÄ4Ñ¡1Ñ¡ÔñÆ÷SR
          input0    =>reg00,
          input1    =>reg01,
          input2    =>reg02,
          input3    =>reg03,
          sel       =>SR,
          out_put   =>output_SR
          );
          
  muxC: mux_4_to_1 port map(             --Ä¿µÄ¼Ä´æÆ÷¶Á³öÊ¹ÓÃµÄ4Ñ¡1Ñ¡ÔñÆ÷output
          input0    =>reg00,
          input1    =>reg01,
          input2    =>reg02,
          input3    =>reg03,
          sel       =>reg_sel,
          out_put   =>output
          );

end struct;
