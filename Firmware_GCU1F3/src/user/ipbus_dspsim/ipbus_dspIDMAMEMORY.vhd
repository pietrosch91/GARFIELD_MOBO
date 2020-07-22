


--SIMULATION OF ADSP-2181 IDMA MEMORY ACCESS 







library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity IDMA_mem is
    generic(
        IDMA_ADDR_WIDTH : positive;
        IDMA_DATA_WIDTH : positive :=16
    );
    port(        
        clk: in std_logic;
        reset: in std_logic;
        D_IN: in std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
        D_OUT: out std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
        nIACK: out std_logic;
        nWR: in std_logic;
        nRD: in std_logic;
        nIAL: in std_logic;
        nIS: in std_logic;
        ADDR_OUT: out std_logic_vector(IDMA_ADDR_WIDTH-1 downto 0);
        bus_ctr: out std_logic
    );
end IDMA_mem;



architecture rtl of IDMA_mem is
    signal address: unsigned(IDMA_ADDR_WIDTH-1 downto 0);
    
    
    type idma_array is array(2 ** IDMA_ADDR_WIDTH - 1 downto 0) of std_logic_vector(IDMA_DATA_WIDTH - 1 downto 0);
    
    signal idma_mem: idma_array;
    
    signal addrint: integer range 0 to 2 ** IDMA_ADDR_WIDTH - 1 := 0;
    
    type m_state is (idle_s,wait_wr,end_wr,wait_rd,end_rd,wait_ial);
    
    signal c_state : m_state;
    
    signal start: std_logic;
    
    signal wait_counter : unsigned (1 downto 0);
    
    signal nWR_de: std_logic;
    
    signal nWR_del: std_logic;
    
    signal nRD_de: std_logic;
    
    signal nRD_del: std_logic;
    
    signal nIAL_de: std_logic;
    
    signal nIAL_del: std_logic;
    
    attribute mark_debug : string;
    attribute mark_debug of address     : signal is "true";
    
begin
    
    addr_out<=std_logic_vector(address);
    addrint<=to_integer(address);
    D_OUT<=idma_mem(addrint);
    
    --pulse forming
    process(nWR,nRD,nIAL,reset,clk) 
    begin
        if(reset='1') then
            nWR_del<='0';
            nRD_del<='0';
            nIAL_del<='0';
        elsif(rising_edge(CLK)) then
            nWR_del<=nWR;
            nRD_del<=nRD;
            nIAL_del<=nIAL;
        end if;
    end process;
    
    nWR_de<=nWR_del and (not nWR);
    nRD_de<=nRD_del and (not nRD);
    nIAL_de<=nIAL_del and (not nIAL);
    
   
    mem_sm : process(clk,reset,D_IN,nWR,nIS,nRD,nIAL) is
    begin
        if(reset='1') then
            address<=(others=>'0');
            nIACK<='0';
            --D_OUT<=(others=>'0');
            wait_counter<=to_unsigned(2,2);
            for I in 0 to 2 ** IDMA_ADDR_WIDTH - 1 loop
                idma_mem(i)<=(others=>'0');
            end loop;
            c_state<=idle_s;
            bus_ctr<='0';
        --newway
        elsif rising_edge(clk) then
            nIACK<='0';
            bus_ctr<='0';
            case c_state is   
                 when idle_s =>
                    c_state<=idle_s;
                    if(nIS='0') then
                        if(nWR_de='1') then --init write cicle
                            nIACK<='1';
                            wait_counter<=to_unsigned(2,2);
                            c_state<=wait_wr;
                        elsif (nRD_de='1') then --init read cicle
                            nIACK<='1';
                            bus_ctr<='1';
                            c_state<=wait_rd;
                        elsif (nIAL_de='1') then --init address_latch
                            c_state<=wait_ial;
                        end if;
                    end if;    
                when wait_wr =>
                    nIACK<='1';
                    wait_counter<=wait_counter-to_unsigned(1,2);
                    if(nIS='1' or nWR='1' or wait_counter=to_unsigned(0,2)) then --end of write cicle both from WR, IS or timeout
                        --latch data
                        idma_mem(addrint)<=D_IN;
                        --if cntr expired, reset IACK
                        if(wait_counter=to_unsigned(0,2)) then
                            nIACK<='0';
                        end if;
                        --prepare for new operation
                        c_state<=end_wr;
                    end if;               
                when end_wr=>
                    nIACK<='1';
                    address<=address+to_unsigned(1,IDMA_ADDR_WIDTH);
                    c_state<=idle_s;                
                when wait_rd =>
                    nIACK<='1';
                    bus_ctr<='1';
                    if(nIS='1' or nRD='1') then --end of read cicle 
                        --request incrementing of address
                      --  inc_address<='1';
                        --prepare for new operation
                        c_state<=end_rd;
                    end if;                
                when end_rd=>
                    nIACK<='1';
                    address<=address+to_unsigned(1,IDMA_ADDR_WIDTH);
                    c_state<=idle_s;                
                when wait_ial =>
                    if(nIS='1' or nIAL='1') then --end of IAL cicle 
                        --latch address
                        address<=unsigned(D_IN(IDMA_ADDR_WIDTH-1 downto 0));
                        --prepare for new operation
                        c_state<=idle_s;
                    end if;                 
                when others=>
                     c_state<=idle_s;
            end case;
        end if;
    end process mem_sm;
end architecture rtl;

    
    
    
