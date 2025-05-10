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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TRIPWM is
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
end TRIPWM;

architecture Behavioral of TRIPWM is

begin

counter: process(CLK,RST)
variable count :integer:=0;
variable lag :integer:=0;
variable T   :integer:=clkfrq/FRQ/4;
variable updn  :std_logic:='0';
begin
T:=clkfrq/FRQ/4;
lag:= T*2/360*PHASE;
if (RST='1') then
count :=0;
updn:='0';
A<='0';
B<='0';

elsif rising_edge(clk) then
if (count >= (T+lag)) then
updn:='1';
elsif (count<=0+lag) then
updn:='0';
end if;

if(updn = '0') then
count:= count+1;
else
count:= count-1;
end if;

if (en='1') then
if(count< (T+lag) - (T+lag)*DUTY_PPM/1_000_000) then
A<='0';
else
A<='1';
end if;

if(count< (T+lag) - (T+lag)*DUTY_PPM/1_000_000-DT) then
B<='1';else
B<='0';
end if;

else
A<='0';
B<='0';
end if;

end if;
end process;
end Behavioral;
