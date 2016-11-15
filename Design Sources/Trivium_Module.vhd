library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Trivium_Module is
    Generic ( DATA_LENGTH : integer := 80 );
    Port ( cipher_text : out STD_LOGIC;
    
           clock : in STD_LOGIC;
           init  : in STD_LOGIC;
           reset : in STD_LOGIC;
           
           K_for_keys  : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
           IV_for_keys : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
           
           open_text : in STD_LOGIC
           );
end Trivium_Module;

architecture RTL of Trivium_Module is

    -----------------------------
    ---------- SIGNALS ----------
    -----------------------------

    signal initialize_ready : std_logic;
    signal current_key      : std_logic;
    signal internal_reset   : std_logic;
    
    -- Regs
    signal K_reg  : STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
    signal IV_reg : STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);

    -----------------------------
    --------- COMPONENTS --------
    -----------------------------
    
    component Key_Sequence_Module is
        Generic ( DATA_LENGTH : integer := 80 );
        Port( z      : out std_logic;
              finish : out std_logic;
              
              clock : in std_logic;
              init  : in std_logic;
              reset : in std_logic;
              
              K  : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
              IV : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0)
              );
    end component;    

begin
    
    -- Init process
    init_process : process(init)
    begin
        if(rising_edge(init)) then
            K_reg <= K_for_keys;
            IV_reg <= IV_for_keys;
        end if;
    end process init_process;
    
    -- Getting new key from key sequence
    Key_Sequence_Module_1 : Key_Sequence_Module
    port map ( z => current_key,
               finish => initialize_ready,
               clock => clock,
               init => init,
               reset => reset,
               K => K_reg,
               IV => IV_reg 
               );
               
    -- Main process
    main_process : process(clock, initialize_ready)
    begin
        if(rising_edge(clock) and initialize_ready <= '1') then
            cipher_text <= open_text xor current_key;
        end if;
    end process main_process;


end RTL;
