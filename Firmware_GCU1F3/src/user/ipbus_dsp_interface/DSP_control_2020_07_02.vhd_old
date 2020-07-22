----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2020 02:13:58 PM
-- Design Name: 
-- Module Name: DSP_control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DSP_control is
    Port ( clk : in STD_LOGIC;
           nReset : in STD_LOGIC;
           op_code : in STD_LOGIC_VECTOR (3 downto 0);
           cmd_valid : in std_logic;        
           DSP_AD_bus : in STD_LOGIC_VECTOR (15 downto 0);
           xfer_length : in STD_LOGIC_VECTOR (9 downto 0);
           IAD : inout STD_LOGIC_VECTOR (15 downto 0);
           DSP_busctr : in STD_LOGIC;
           nIACK : in STD_LOGIC;
           CLR : out STD_LOGIC;
           nIS : out STD_LOGIC;
           nIRD : out STD_LOGIC;
           niWR : out STD_LOGIC;
           nIAL : out STD_LOGIC;
           nSPE : out STD_LOGIC;
           nBOOT : out STD_LOGIC;
           nEND : out STD_LOGIC;
           busy : out STD_LOGIC;
           DSP_data_out : out STD_LOGIC_VECTOR (15 downto 0));
end DSP_control;

architecture Behavioral of DSP_control is

type cmd_state_type is(idle,boot_req,iAL_req,IDMA_write,IDMA_read);
signal cmd_state : cmd_state_type;
signal boot_req_cnt: integer;
signal write_flag: std_logic;
signal read_flag: std_logic;
signal nIACK_a : std_logic;  
signal nIACK_sync : std_logic;  
signal nRD_int:std_logic;

--signal D_TO_DSP: std_logic_Vector(15 downto 0);
signal D_FROM_DSP: std_logic_Vector(15 downto 0);
signal cmd_val_del:std_logic;

begin
nIRD<=nRD_int;
nIS <='0';

 --IAD bus direction
    IAD_control: process
    begin
        if(nRD_int='1') then
            D_FROM_DSP<=(others=>'0');
            IAD<=DSP_AD_bus;
        else
            D_FROM_DSP<=IAD;
            IAD<=(others=>'Z');
        end if;
    end process IAD_control;




process(clk,nReset)
begin

if nReset = '0' then
    DSP_data_out    <= (others => '0');
    nEND            <= '1';
    nSPE            <= '1';
    nBOOT           <= '1';
    cmd_state       <= idle;
    boot_req_cnt    <= 0;
    nIAL            <= '1';
    CLR             <= '0';
    write_flag      <= '0';
    nIWR            <= '1';
    read_flag       <= '0';
    nRD_int         <= '1';
    nIACK_a         <= '0';
    nIACK_sync      <= '0';
    cmd_val_del     <= '0';
    
elsif clk'event and clk = '1' then

    -- default
    nEND            <= '1';
    nSPE            <= '1';
    nIAL            <= '1';
    nRD_int         <= '1';
    CLR             <= '0';
    -- sync
    nIACK_a         <= nIACK;
    nIACK_sync      <= nIACK_a;
    cmd_val_del     <= cmd_valid;
    
    case cmd_state is
        when idle =>
            if cmd_valid = '1' and  cmd_val_del='0' then
                if op_code = x"0" then
                    nEND            <= '0';
                elsif op_code = x"1" then
                    nSPE            <= '0';
                elsif op_code = x"2" then
                    nBOOT           <= '0';
                    cmd_state       <= boot_req;
                    boot_req_cnt    <= 0;
                elsif op_code = x"3" then
                    cmd_state       <= iAL_req;
                elsif op_code = x"4" then
                    CLR             <= '1';
                elsif op_code = x"5" then
                    cmd_state       <= IDMA_write;
                elsif op_code = x"6" then
                    cmd_state       <= IDMA_read;
                                                    
                end if;
            end if;       
    
        when boot_req =>
            if boot_req_cnt = 7 then
                nBOOT           <= '1';
                cmd_state       <= idle;
            else
                boot_req_cnt <= boot_req_cnt + 1;
            end if;

        when iAL_req =>
            --IAD         <= DSP_AD_bus;
            if nIACK = '0' then
                nIAL        <= '0';
                cmd_state   <= idle;
            end if;    

        when IDMA_write =>
            --IAD         <= DSP_AD_bus;
            if nIACK = '0' then
                nIWR        <= '0';
                write_flag  <= '1';
            end if;
            if write_flag = '1' then
                nIWR        <= '1';
                write_flag  <= '0';
                cmd_state   <= idle;
            end if;
                
        when IDMA_read =>
            if nIACK = '0' then
                nRD_int        <= '0';
                read_flag  <= '1';
            end if;
            if read_flag = '1' then
                nRD_int         <= '1';
                read_flag       <= '0';
                cmd_state       <= idle;
                DSP_data_out    <= D_FROM_DSP;
            end if;    

    end case;
        
end if;


end process;


end Behavioral;
