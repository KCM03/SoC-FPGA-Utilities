----------------------------------------------------------------------------------
-- Company: University of Strathclyde
-- Engineer: Kishan Maharaj
-- 
-- Create Date: 09.05.2025 13:22:41
-- Design Name: Triangular Phase-Shifted PWM With Dead-time.
-- Module Name: TRIPWM - Behavioral
-- Project Name: 
-- Target Devices: Artix 7-A35

-- 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TRIPWM_TB is
--  Port ( );
end TRIPWM_TB;


architecture Behavioral of TRIPWM_TB is

component TRIPWM is
    Generic( clkfrq  : integer := 100_000_000;
             duty_max: integer := 100;
             phase_max:integer := 180);
    Port ( CLK : in STD_LOGIC;
           FRQ : in integer;
           DUTY_PPM : in integer;
           PHASE : in integer;
           DT : in integer;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           EN : in STD_LOGIC;
           RST: in STD_LOGIC);
end component;

     SIGNAL CLK :STD_LOGIC;
     SIGNAL      FRQ :  integer;
     SIGNAL      DUTY_PPM :  integer;
     SIGNAL      PHASE :  integer;
     SIGNAL      DT :  integer;
     SIGNAL      A :  STD_LOGIC;
     SIGNAL      B :  STD_LOGIC;
     SIGNAL      A2 :  STD_LOGIC;
     SIGNAL      B2 :  STD_LOGIC;
     SIGNAL      EN :  STD_LOGIC;
      SIGNAL     RST:  STD_LOGIC;
      SIGNAL PHASE2 : integer;

begin
DUT: TRIPWM 
port map(
 CLK=>CLK,
 FRQ=>FRQ,
 DUTY_PPM=>DUTY_PPM,
 PHASE=>PHASE,
  DT=>DT,
  A=>A,
  B=>B,
  EN=>EN,
  RST=>RST);
  
  DUT2: TRIPWM 
port map(
 CLK=>CLK,
 FRQ=>FRQ,
 DUTY_PPM=>DUTY_PPM,
 PHASE=>PHASE2,
  DT=>DT,
  A=>A2,
  B=>B2,
  EN=>EN,
  RST=>RST);
  
  process is 
  begin
  FRQ<= 100_000;
  RST<= '0';
  EN<= '1';
  PHASE<= 0;
  PHASE2<= 90;
  DUTY_PPM<= 250_000;
  DT<= 1;
  wait;
  end process;
  
clk_generator : process is          
   begin    
       while (now<=1ms)loop		-- define number of clock cycles to simulate
        
 		clk <= '1';					-- create one full clock period every loop iteration
           wait for 10ns;
			clk <= '0';
           wait for 10ns;
			
        end loop;	   
        
		wait;		
    end process	clk_generator;
    
end Behavioral;
