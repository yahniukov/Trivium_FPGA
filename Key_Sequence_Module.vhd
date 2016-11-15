library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Key_Sequence_Module is
    Generic ( DATA_LENGTH : integer := 80 );
    Port( z      : out std_logic;
          finish : out std_logic;
              
          clock : in std_logic;
          init  : in std_logic;
          reset : in std_logic;
              
          K  : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
          IV : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0)
          );
end Key_Sequence_Module;

architecture Behavioral of Key_Sequence_Module is

begin


end Behavioral;
