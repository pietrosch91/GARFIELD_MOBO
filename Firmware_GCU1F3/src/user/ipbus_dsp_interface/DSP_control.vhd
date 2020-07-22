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

-- use work.ipbus.all;

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
           xfer_length : in STD_LOGIC_VECTOR (7 downto 0);
           IAD_to_DSP : out STD_LOGIC_VECTOR (15 downto 0);
           IAD_from_DSP : in STD_LOGIC_VECTOR (15 downto 0);
--           DSP_busctr : in STD_LOGIC;
           nIACK : in STD_LOGIC;
           CLR : out STD_LOGIC;
           nIS : out STD_LOGIC;
           nIRD : out STD_LOGIC;
           niWR : out STD_LOGIC;
           nIAL : out STD_LOGIC;
           nSPE : out STD_LOGIC;
           nBOOT : out STD_LOGIC;
           nEND : out STD_LOGIC;
           EVNT : in STD_LOGIC;
           REQ : in STD_LOGIC;
           DATA_READY : out std_logic;
           EVNT_READY : in std_logic;   
           busy : out STD_LOGIC;
           fifo_rd  : in STD_LOGIC;
           rd_fifo_clk  : in STD_LOGIC;
           wr_fifo_clk  : in STD_LOGIC;
           DSP_fifo_out : out STD_LOGIC_VECTOR (15 downto 0);
           DSP_data_out : out STD_LOGIC_VECTOR (15 downto 0);
           xfer_length_out : out STD_LOGIC_VECTOR(7 downto 0)
           );           
end DSP_control;

architecture Behavioral of DSP_control is



COMPONENT channel_fifo
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;



constant evt_addr: std_logic_vector(15 downto 0):=x"0055";
constant evt_end_code: std_logic_vector(15 downto 0):=x"FFFF";

type cmd_state_type is(idle,boot_req,iAL_req,write_single,read_single,IDMA_write,IDMA_read,event_start,wait_req,read_length,event_read,DSP_clear,d_ready);
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
signal write_cnt : integer;
signal read_cnt : integer;
signal fifo_wr_en : std_logic;
signal fifo_rd_en : std_logic;
signal hold_flag: std_logic;
signal fifo_read_cnt : integer;
signal fifo_read_flag: std_logic;
signal evt_length: integer;
signal wait_flag : std_logic;
signal fifo_rst : std_logic;

signal DSP_IAD_int: std_logic_vector(15 downto 0);
signal DSP_AD_bit :std_logic;
signal fifo_full : std_logic;
signal fifo_din : std_logic_vector(15 downto 0);
signal fifo_rst_cnt : integer;
signal fifo_din_sel : std_logic;

signal rcnt: std_Logic_vector(7 downto 0);

attribute mark_debug : string;
attribute mark_debug of fifo_wr_en     : signal is "true";
attribute mark_debug of nRD_int     : signal is "true";
attribute mark_debug of nIAL     : signal is "true";
attribute mark_debug of nIACK     : signal is "true";
attribute mark_debug of rcnt     : signal is "true";
attribute mark_debug of DSP_AD_bit     : signal is "true";
attribute mark_debug of DSP_IAD_int     : signal is "true";
attribute mark_debug of D_FROM_DSP     : signal is "true";

begin

nIRD<=nRD_int;
nIS <='0';

--fifo_rst <= not nReset;

rcnt<=std_logic_vector(to_unsigned(read_cnt,8));
channel_fifo_i : channel_fifo
  PORT MAP (
    rd_clk => rd_fifo_clk,
    wr_clk => wr_fifo_clk,
    rst => fifo_rst,
--    din => D_FROM_DSP,
    din => fifo_din,
    wr_en => fifo_wr_en ,
    rd_en => fifo_rd,
    dout => DSP_fifo_out,
    full => fifo_full,
    empty => open
  );
  

 --IAD bus direction
    D_FROM_DSP<=IAD_from_DSP;
    IAD_to_DSP<=DSP_IAD_int;
--     IAD_control: process(nRD_int,DSP_IAD_int)
--     begin
--         if(nRD_int='1') then
--             D_FROM_DSP<=(others=>'0');
--             IAD<=DSP_IAD_int;
--         else
--             D_FROM_DSP<=IAD;
--            -- IAD<=(others=>'Z');
--         end if;
--     end process IAD_control;

    DSP_AD_int_control: process(DSP_AD_bit)
    begin
        if(DSP_AD_bit='0') then
            DSP_IAD_int<=DSP_AD_bus;
        else
            DSP_IAD_int<=evt_addr;
        end if;
    end process DSP_AD_int_control;

fifo_din_sel_prcs: process(fifo_din_sel,D_FROM_DSP)

begin

    if fifo_din_sel = '0' then
        fifo_din <= D_FROM_DSP;
    else
        fifo_din <= evt_end_code;
    end if;    
end process fifo_din_sel_prcs;
    

fifo_rst_prcs: process(clk,nReset)
begin

if nReset = '0' then

    fifo_rst        <= '0';
    fifo_rst_cnt    <= 0;

elsif clk'event and clk = '1' then

    if fifo_rst_cnt = 5 then
        fifo_rst        <= '0';
    else 
        fifo_rst        <= '1';
        fifo_rst_cnt    <= fifo_rst_cnt + 1; 
    end if;
end if;

end process fifo_rst_prcs;

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
    write_cnt       <= 0;
    read_cnt        <= 0;
    write_cnt       <= 0;
    busy            <= '1';
    fifo_wr_en      <= '0';
    hold_flag       <= '0';
    wait_flag       <= '0';
    DSP_AD_bit      <= '0';
    evt_length      <= 0;
    fifo_din_sel    <= '0';
    DATA_READY      <= '0';          
--    fifo_din        <= (others=>'0');
   
elsif clk'event and clk = '1' then

    -- default
    nEND                <= '1';
    nSPE                <= '1';
    nIAL                <= '1';
--    nRD_int           <= '1';
    CLR                 <= '0';
    -- sync
    nIACK_a             <= nIACK;
    nIACK_sync          <= nIACK_a;
    cmd_val_del         <= cmd_valid;
    fifo_wr_en          <= '0';
    
    case cmd_state is
        when idle =>
            busy <= '0';    
            fifo_din_sel    <= '0';
            if cmd_valid = '1' and  cmd_val_del='0' then
                busy <= '1';
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
                    cmd_state       <= write_single;
                elsif op_code = x"6" then
                    cmd_state       <= read_single;
                elsif op_code = x"7" then
                    cmd_state       <= IDMA_write;
                    write_cnt       <=  to_integer(unsigned(xfer_length))-1;
                elsif op_code = x"8" then
                    cmd_state       <= IDMA_read;
                    read_cnt        <=  to_integer(unsigned(xfer_length))-1;
                    xfer_length_out<=xfer_length;
                elsif op_code = x"9" then
                    cmd_state       <= event_start;
                else
                    busy <= '0';                    -- invalid command 
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

        when write_single =>
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
                
        when read_single =>
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

        when IDMA_write =>
            if nIACK = '0' then
                nIWR        <= '0';
                write_flag  <= '1';
            end if;
            if write_flag = '1' then
                if write_cnt = 0 then
                    nIWR        <= '1';
                    write_flag  <= '0';
                    cmd_state   <= idle;
                else
                    write_cnt <= write_cnt - 1;
                end if;
            end if;

        when IDMA_read =>
            
            if nIACK = '0' and read_flag = '0' then
                nRD_int         <= '0';
                read_flag       <= '1';
            end if;
            if read_flag = '1' then
                if hold_flag = '0' then 
                    fifo_wr_en  <= '1';
                    hold_flag   <= '1';
                else    
--                    fifo_din    <= D_FROM_DSP;
                    nRD_int     <= '1';
                    read_flag   <= '0';
                    hold_flag   <= '0';
            
                    if read_cnt = 0 then
                        cmd_state       <= idle;
--                        DSP_data_out    <= D_FROM_DSP;
                    else
                        read_cnt        <= read_cnt - 1;
                    end if;
                end if;
            end if;    

        when event_start =>
            if EVNT = '1' then
                cmd_state       <= wait_req;
            end if;
            
        when wait_req =>
            DSP_AD_bit <= '1';
            if wait_flag = '1' then 
                cmd_state   <= read_length;
                nIAL <='1';
                --DSP_AD_bit <= '0';
                wait_flag   <= '0';              
            elsif REQ = '1' then
                nIAL        <= '0';
                wait_flag   <= '1';              
            end if;

        when read_length =>
           
            if nRD_int = '0' then
                if wait_flag = '0' then
                    if D_FROM_DSP = x"0000" then
                        DSP_AD_bit <= '0';
                        fifo_din_sel <= '1';
                        cmd_state   <= event_read;
                        nRD_int     <= '1';
                    else
                        wait_flag <= '1';
                        read_cnt  <= to_integer(unsigned(D_FROM_DSP))-1;
                    end if;
                else    
                    DSP_AD_bit <= '0';
                    wait_flag<='0';
                    cmd_state   <= event_read;
                    nRD_int     <= '1';
                end if;
            elsif nIACK = '0' then 
                nRD_int         <= '0';
            end if;
                    
        when event_read =>
            if fifo_din_sel   = '1'then
                if fifo_full = '0' then
                    fifo_wr_en  <= '1';
                    cmd_state       <= DSP_clear;
                end if;
            elsif nIACK = '0' and read_flag = '0' then
                nRD_int         <= '0';
                read_flag       <= '1';
            end if;
            if read_flag = '1' then
                if hold_flag = '0' then 
                    if fifo_full= '0' then
                        fifo_wr_en  <= '1';
                        hold_flag   <= '1';
                    end if;
                else    
                    nRD_int     <= '1';
                    read_flag   <= '0';
                    hold_flag   <= '0';
            
                    if read_cnt = 0 then
                        fifo_din_sel    <= '1';
                    else
                        read_cnt        <= read_cnt - 1;
                    end if;
                end if;
            end if;    
        
        when DSP_clear =>

            CLR             <= '1';
            cmd_state       <= d_ready;
                
        when d_ready =>

            DATA_READY      <= '1';
            if EVNT_READY = '1' then
                DATA_READY      <= '0';
                cmd_state       <= idle;
                nEND            <= '0';
            end if;

                    
    end case;
        
end if;
end process;



end Behavioral;
