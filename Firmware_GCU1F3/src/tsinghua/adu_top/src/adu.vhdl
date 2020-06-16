
--
-- Verific VHDL Description of module \IBUFDS(DIFF_TERM="TRUE",IBUF_LOW_PWR="TRUE",IOSTANDARD="LVDS_25")\
--

-- \IBUFDS(DIFF_TERM="TRUE",IBUF_LOW_PWR="TRUE",IOSTANDARD="LVDS_25")\ is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of module Signal_CrossDomain
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Signal_CrossDomain is
    port (SignalIn_clkA: in std_logic;   -- element/Signal_CrossDomain.v(28)
        clkB: in std_logic;   -- element/Signal_CrossDomain.v(29)
        SignalOut_clkB: out std_logic   -- element/Signal_CrossDomain.v(30)
    );
    
end entity Signal_CrossDomain;   -- ADC/adc_config.v(64)

architecture \.\ of Signal_CrossDomain is 
    procedure VERIFIC_DFFRS (d: in std_logic;
        signal clk: in std_logic;
        s: in std_logic;
        r: in std_logic;
        signal q: inout std_logic
    ) is begin
        if (s='1') then
            q <= '1' ;
        elsif (r='1') then
            q <= '0' ;
        elsif (clk'event and clk='1') then
            q <= d ;
        end if ;
    end procedure VERIFIC_DFFRS;
    signal SignalOut_clkB_c : std_logic;   -- element/Signal_CrossDomain.v(30)
    signal SyncA_clkB : std_logic_vector(1 downto 0);   -- element/Signal_CrossDomain.v(34)
    signal n1 : std_logic; 
begin
    SignalOut_clkB <= SignalOut_clkB_c;   -- element/Signal_CrossDomain.v(30)
    n1 <= '0' ;
    i7: VERIFIC_DFFRS (d=>SyncA_clkB(0),clk=>clkB,s=>n1,r=>n1,q=>SignalOut_clkB_c);   -- element/Signal_CrossDomain.v(36)
    i5: VERIFIC_DFFRS (d=>SignalIn_clkA,clk=>clkB,s=>n1,r=>n1,q=>SyncA_clkB(0));   -- element/Signal_CrossDomain.v(35)
    
end architecture \.\;   -- element/Signal_CrossDomain.v(27)


--
-- Verific VHDL Description of module \ddr_8to1_16chan_rx_gcu(USE_BUFIO=0,IDELAY_INITIAL_VALUE=0,N=0)\
--

-- \ddr_8to1_16chan_rx_gcu(USE_BUFIO=0,IDELAY_INITIAL_VALUE=0,N=0)\ is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of OPERATOR add_8u_8u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity add_8u_8u is
    port (cin: in std_logic;
        a: in std_logic_vector(7 downto 0);
        b: in std_logic_vector(7 downto 0);
        o: out std_logic_vector(7 downto 0);
        cout: out std_logic
    );
    
end entity add_8u_8u;

architecture INTERFACE of add_8u_8u is 
    signal n2,n4,n6,n8,n10,n12,n14 : std_logic; 
begin
    n2 <= a(0) or b(0) when cin='1' else a(0) and b(0);
    o(0) <= a(0) xor b(0) xor cin;
    n4 <= a(1) or b(1) when n2='1' else a(1) and b(1);
    o(1) <= a(1) xor b(1) xor n2;
    n6 <= a(2) or b(2) when n4='1' else a(2) and b(2);
    o(2) <= a(2) xor b(2) xor n4;
    n8 <= a(3) or b(3) when n6='1' else a(3) and b(3);
    o(3) <= a(3) xor b(3) xor n6;
    n10 <= a(4) or b(4) when n8='1' else a(4) and b(4);
    o(4) <= a(4) xor b(4) xor n8;
    n12 <= a(5) or b(5) when n10='1' else a(5) and b(5);
    o(5) <= a(5) xor b(5) xor n10;
    n14 <= a(6) or b(6) when n12='1' else a(6) and b(6);
    o(6) <= a(6) xor b(6) xor n12;
    cout <= a(7) or b(7) when n14='1' else a(7) and b(7);
    o(7) <= a(7) xor b(7) xor n14;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_8
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_8 is
    port (a: in std_logic_vector(7 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_8;

architecture INTERFACE of reduce_nor_8 is 
    signal n1,n2,n3,n4,n5,n6,n7 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(2) or a(3);
    n3 <= n1 or n2;
    n4 <= a(4) or a(5);
    n5 <= a(6) or a(7);
    n6 <= n4 or n5;
    n7 <= n3 or n6;
    o <= not n7;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_and_2
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_and_2 is
    port (a: in std_logic_vector(1 downto 0);
        o: out std_logic
    );
    
end entity reduce_and_2;

architecture INTERFACE of reduce_and_2 is 
    
begin
    o <= a(0) and a(1);
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_5
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_5 is
    port (a: in std_logic_vector(4 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_5;

architecture INTERFACE of reduce_nor_5 is 
    signal n1,n2,n3,n4 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(3) or a(4);
    n3 <= a(2) or n2;
    n4 <= n1 or n3;
    o <= not n4;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_10
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_10 is
    port (a: in std_logic_vector(9 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_10;

architecture INTERFACE of reduce_nor_10 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8,n9 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(3) or a(4);
    n3 <= a(2) or n2;
    n4 <= n1 or n3;
    n5 <= a(5) or a(6);
    n6 <= a(8) or a(9);
    n7 <= a(7) or n6;
    n8 <= n5 or n7;
    n9 <= n4 or n8;
    o <= not n9;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_or_6
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_6 is
    port (a: in std_logic_vector(5 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_6;

architecture INTERFACE of reduce_or_6 is 
    signal n1,n2,n3,n4 : std_logic; 
begin
    n1 <= a(1) or a(2);
    n2 <= a(0) or n1;
    n3 <= a(4) or a(5);
    n4 <= a(3) or n3;
    o <= n2 or n4;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_or_4
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_4 is
    port (a: in std_logic_vector(3 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_4;

architecture INTERFACE of reduce_or_4 is 
    signal n1,n2 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(2) or a(3);
    o <= n1 or n2;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR Select_3
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Select_3 is
    port (sel: in std_logic_vector(2 downto 0);
        data: in std_logic_vector(2 downto 0);
        o: out std_logic
    );
    
end entity Select_3;

architecture INTERFACE of Select_3 is 
    signal n1,n2,n3,n4 : std_logic; 
begin
    n1 <= data(0) and sel(0);
    n2 <= data(1) and sel(1);
    n3 <= data(2) and sel(2);
    n4 <= n2 or n3;
    o <= n1 or n4;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_or_7
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_7 is
    port (a: in std_logic_vector(6 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_7;

architecture INTERFACE of reduce_or_7 is 
    signal n1,n2,n3,n4,n5 : std_logic; 
begin
    n1 <= a(1) or a(2);
    n2 <= a(0) or n1;
    n3 <= a(3) or a(4);
    n4 <= a(5) or a(6);
    n5 <= n3 or n4;
    o <= n2 or n5;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR Select_4
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Select_4 is
    port (sel: in std_logic_vector(3 downto 0);
        data: in std_logic_vector(3 downto 0);
        o: out std_logic
    );
    
end entity Select_4;

architecture INTERFACE of Select_4 is 
    signal n1,n2,n3,n4,n5,n6 : std_logic; 
begin
    n1 <= data(0) and sel(0);
    n2 <= data(1) and sel(1);
    n3 <= data(2) and sel(2);
    n4 <= data(3) and sel(3);
    n5 <= n1 or n2;
    n6 <= n3 or n4;
    o <= n5 or n6;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_or_3
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_3 is
    port (a: in std_logic_vector(2 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_3;

architecture INTERFACE of reduce_or_3 is 
    signal n1 : std_logic; 
begin
    n1 <= a(1) or a(2);
    o <= a(0) or n1;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR Select_5
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Select_5 is
    port (sel: in std_logic_vector(4 downto 0);
        data: in std_logic_vector(4 downto 0);
        o: out std_logic
    );
    
end entity Select_5;

architecture INTERFACE of Select_5 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8 : std_logic; 
begin
    n1 <= data(0) and sel(0);
    n2 <= data(1) and sel(1);
    n3 <= data(2) and sel(2);
    n4 <= data(3) and sel(3);
    n5 <= data(4) and sel(4);
    n6 <= n1 or n2;
    n7 <= n4 or n5;
    n8 <= n3 or n7;
    o <= n6 or n8;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of module Flag_CrossDomain
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Flag_CrossDomain is
    port (clkA: in std_logic;   -- element/Flag_CrossDomain.v(25)
        FlagIn_clkA: in std_logic;   -- element/Flag_CrossDomain.v(26)
        clkB: in std_logic;   -- element/Flag_CrossDomain.v(27)
        FlagOut_clkB: out std_logic   -- element/Flag_CrossDomain.v(28)
    );
    
end entity Flag_CrossDomain;   -- ADC/adc_config.v(190)

architecture \.\ of Flag_CrossDomain is 
    procedure VERIFIC_DFFRS (d: in std_logic;
        signal clk: in std_logic;
        s: in std_logic;
        r: in std_logic;
        signal q: inout std_logic
    ) is begin
        if (s='1') then
            q <= '1' ;
        elsif (r='1') then
            q <= '0' ;
        elsif (clk'event and clk='1') then
            q <= d ;
        end if ;
    end procedure VERIFIC_DFFRS;
    signal FlagToggle_clkA : std_logic;   -- element/Flag_CrossDomain.v(32)
    signal SyncA_clkB : std_logic_vector(2 downto 0);   -- element/Flag_CrossDomain.v(36)
    signal n1,n5 : std_logic; 
begin
    n1 <= '0' ;
    n5 <= FlagToggle_clkA xor FlagIn_clkA;   -- element/Flag_CrossDomain.v(33)
    i8: VERIFIC_DFFRS (d=>SyncA_clkB(1),clk=>clkB,s=>n1,r=>n1,q=>SyncA_clkB(2));   -- element/Flag_CrossDomain.v(37)
    i9: VERIFIC_DFFRS (d=>SyncA_clkB(0),clk=>clkB,s=>n1,r=>n1,q=>SyncA_clkB(1));   -- element/Flag_CrossDomain.v(37)
    i10: VERIFIC_DFFRS (d=>FlagToggle_clkA,clk=>clkB,s=>n1,r=>n1,q=>SyncA_clkB(0));   -- element/Flag_CrossDomain.v(37)
    FlagOut_clkB <= SyncA_clkB(2) xor SyncA_clkB(1);   -- element/Flag_CrossDomain.v(40)
    i6: VERIFIC_DFFRS (d=>n5,clk=>clkA,s=>n1,r=>n1,q=>FlagToggle_clkA);   -- element/Flag_CrossDomain.v(33)
    
end architecture \.\;   -- element/Flag_CrossDomain.v(24)


--
-- Verific VHDL Description of OPERATOR reduce_nor_2
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_2 is
    port (a: in std_logic_vector(1 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_2;

architecture INTERFACE of reduce_nor_2 is 
    signal n1 : std_logic; 
begin
    n1 <= a(0) or a(1);
    o <= not n1;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_4
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_4 is
    port (a: in std_logic_vector(3 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_4;

architecture INTERFACE of reduce_nor_4 is 
    signal n1,n2,n3 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(2) or a(3);
    n3 <= n1 or n2;
    o <= not n3;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_7
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_7 is
    port (a: in std_logic_vector(6 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_7;

architecture INTERFACE of reduce_nor_7 is 
    signal n1,n2,n3,n4,n5,n6 : std_logic; 
begin
    n1 <= a(1) or a(2);
    n2 <= a(0) or n1;
    n3 <= a(3) or a(4);
    n4 <= a(5) or a(6);
    n5 <= n3 or n4;
    n6 <= n2 or n5;
    o <= not n6;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR add_7u_7u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity add_7u_7u is
    port (cin: in std_logic;
        a: in std_logic_vector(6 downto 0);
        b: in std_logic_vector(6 downto 0);
        o: out std_logic_vector(6 downto 0);
        cout: out std_logic
    );
    
end entity add_7u_7u;

architecture INTERFACE of add_7u_7u is 
    signal n2,n4,n6,n8,n10,n12 : std_logic; 
begin
    n2 <= a(0) or b(0) when cin='1' else a(0) and b(0);
    o(0) <= a(0) xor b(0) xor cin;
    n4 <= a(1) or b(1) when n2='1' else a(1) and b(1);
    o(1) <= a(1) xor b(1) xor n2;
    n6 <= a(2) or b(2) when n4='1' else a(2) and b(2);
    o(2) <= a(2) xor b(2) xor n4;
    n8 <= a(3) or b(3) when n6='1' else a(3) and b(3);
    o(3) <= a(3) xor b(3) xor n6;
    n10 <= a(4) or b(4) when n8='1' else a(4) and b(4);
    o(4) <= a(4) xor b(4) xor n8;
    n12 <= a(5) or b(5) when n10='1' else a(5) and b(5);
    o(5) <= a(5) xor b(5) xor n10;
    cout <= a(6) or b(6) when n12='1' else a(6) and b(6);
    o(6) <= a(6) xor b(6) xor n12;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR Mux_2u_4u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Mux_2u_4u is
    port (sel: in std_logic_vector(1 downto 0);
        data: in std_logic_vector(3 downto 0);
        o: out std_logic
    );
    
end entity Mux_2u_4u;

architecture INTERFACE of Mux_2u_4u is 
    signal n1,n2 : std_logic; 
begin
    n1 <= data(1) when sel(0)='1' else data(0);
    n2 <= data(3) when sel(0)='1' else data(2);
    o <= n2 when sel(1)='1' else n1;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of module \SimpleSPIMaster(DLY_BEF_SCK=0,DLY_BET_CON_TRA=0,SPI_2X_CLK_DIV=10)\
--

library ieee ;
use ieee.std_logic_1164.all ;

entity \SimpleSPIMaster(DLY_BEF_SCK=0,DLY_BET_CON_TRA=0,SPI_2X_CLK_DIV=10)\ is
    port (clk: in std_logic;   -- element/SimpleSPIMaster.v(95)
        rst: in std_logic;   -- element/SimpleSPIMaster.v(96)
        din: in std_logic_vector(15 downto 0);   -- element/SimpleSPIMaster.v(97)
        wr: in std_logic;   -- element/SimpleSPIMaster.v(98)
        ready: out std_logic;   -- element/SimpleSPIMaster.v(99)
        dout_valid: out std_logic;   -- element/SimpleSPIMaster.v(100)
        dout: out std_logic_vector(15 downto 0);   -- element/SimpleSPIMaster.v(101)
        spi_cs: out std_logic;   -- element/SimpleSPIMaster.v(103)
        spi_sck: out std_logic;   -- element/SimpleSPIMaster.v(104)
        spi_mosi: out std_logic;   -- element/SimpleSPIMaster.v(105)
        spi_miso: in std_logic   -- element/SimpleSPIMaster.v(106)
    );
    
end entity \SimpleSPIMaster(DLY_BEF_SCK=0,DLY_BET_CON_TRA=0,SPI_2X_CLK_DIV=10)\;   -- element/SimpleSPIMaster.v(86)

architecture \.\ of \SimpleSPIMaster(DLY_BEF_SCK=0,DLY_BET_CON_TRA=0,SPI_2X_CLK_DIV=10)\ is 
    procedure VERIFIC_DFFRS (d: in std_logic;
        signal clk: in std_logic;
        s: in std_logic;
        r: in std_logic;
        signal q: inout std_logic
    ) is begin
        if (s='1') then
            q <= '1' ;
        elsif (r='1') then
            q <= '0' ;
        elsif (clk'event and clk='1') then
            q <= d ;
        end if ;
    end procedure VERIFIC_DFFRS;
    signal dout_valid_c : std_logic;   -- element/SimpleSPIMaster.v(100)
    signal clk_cnt : std_logic_vector(6 downto 0);   -- element/SimpleSPIMaster.v(109)
    signal spi_2x_ce : std_logic;   -- element/SimpleSPIMaster.v(116)
    signal core_clk : std_logic;   -- element/SimpleSPIMaster.v(118)
    signal core_n_clk : std_logic;   -- element/SimpleSPIMaster.v(118)
    signal samp_ce : std_logic;   -- element/SimpleSPIMaster.v(137)
    signal fsm_ce : std_logic;   -- element/SimpleSPIMaster.v(143)
    signal bit_count : std_logic_vector(7 downto 0);   -- element/SimpleSPIMaster.v(145)
    signal bit_count_clr : std_logic;   -- element/SimpleSPIMaster.v(146)
    signal tx_buffer : std_logic_vector(15 downto 0);   -- element/SimpleSPIMaster.v(155)
    signal tx_msb : std_logic;   -- element/SimpleSPIMaster.v(156)
    signal tx_buffer_empty : std_logic;   -- element/SimpleSPIMaster.v(157)
    signal tx_buffer_shift : std_logic;   -- element/SimpleSPIMaster.v(158)
    signal rd : std_logic;   -- element/SimpleSPIMaster.v(159)
    signal state_reg : std_logic_vector(1 downto 0);   -- element/SimpleSPIMaster.v(180)
    signal state_next : std_logic_vector(1 downto 0);   -- element/SimpleSPIMaster.v(180)
    signal spi_miso_r : std_logic_vector(1 downto 0);   -- element/SimpleSPIMaster.v(341)
    signal samp_ce_r : std_logic_vector(1 downto 0);   -- element/SimpleSPIMaster.v(344)
    signal bit_count_r0 : std_logic_vector(7 downto 0);   -- element/SimpleSPIMaster.v(347)
    signal bit_count_r1 : std_logic_vector(7 downto 0);   -- element/SimpleSPIMaster.v(347)
    signal rx_buffer : std_logic_vector(15 downto 0);   -- element/SimpleSPIMaster.v(353)
    signal n1,n2,n5,n6,n9,n10,n11,n12,n13,n14,n15,n16,n17,n18,
        n19,n20,n21,n22,n23,n24,n25,n26,n27,n28,n29,n41,n42,n43,
        n44,n45,n52,n53,n54,n55,n56,n57,n58,n59,n60,n61,n62,n63,
        n64,n65,n66,n67,n68,n69,n70,n71,n72,n73,n74,n75,n76,n77,
        n78,n79,n80,n81,n82,n83,n93,n94,n95,n96,n97,n98,n99,n100,
        n101,n102,n103,n104,n105,n106,n107,n108,n109,n110,n111,n112,
        n113,n114,n115,n116,n117,n118,n119,n120,n121,n122,n123,n124,
        n125,n126,n127,n128,n129,n130,n131,n132,n133,n134,n135,n136,
        n137,n138,n139,n140,n141,n142,n143,n144,n145,n146,n147,n148,
        n149,n150,n151,n152,n153,n154,n155,n156,n157,n158,n159,n160,
        n161,n162,n181,n184,n186,n187,n190,n199,n200,n201,n202,n203,
        n205,n206,n207,n247,n248,n249,n250,n251,n252,n253,n254,n255,
        n256,n257,n258,n259,n260,n261,n262,n263,n264,n265,n266,n267,
        n268,n269,n270,n271,n272,n273,n274,n275,n276,n277,n278,n279,
        n280,n281,n282,n283,n284,n285 : std_logic; 
begin
    ready <= tx_buffer_empty;   -- element/SimpleSPIMaster.v(99)
    dout_valid <= dout_valid_c;   -- element/SimpleSPIMaster.v(100)
    dout(15) <= rx_buffer(15);   -- element/SimpleSPIMaster.v(101)
    dout(14) <= rx_buffer(14);   -- element/SimpleSPIMaster.v(101)
    dout(13) <= rx_buffer(13);   -- element/SimpleSPIMaster.v(101)
    dout(12) <= rx_buffer(12);   -- element/SimpleSPIMaster.v(101)
    dout(11) <= rx_buffer(11);   -- element/SimpleSPIMaster.v(101)
    dout(10) <= rx_buffer(10);   -- element/SimpleSPIMaster.v(101)
    dout(9) <= rx_buffer(9);   -- element/SimpleSPIMaster.v(101)
    dout(8) <= rx_buffer(8);   -- element/SimpleSPIMaster.v(101)
    dout(7) <= rx_buffer(7);   -- element/SimpleSPIMaster.v(101)
    dout(6) <= rx_buffer(6);   -- element/SimpleSPIMaster.v(101)
    dout(5) <= rx_buffer(5);   -- element/SimpleSPIMaster.v(101)
    dout(4) <= rx_buffer(4);   -- element/SimpleSPIMaster.v(101)
    dout(3) <= rx_buffer(3);   -- element/SimpleSPIMaster.v(101)
    dout(2) <= rx_buffer(2);   -- element/SimpleSPIMaster.v(101)
    dout(1) <= rx_buffer(1);   -- element/SimpleSPIMaster.v(101)
    dout(0) <= rx_buffer(0);   -- element/SimpleSPIMaster.v(101)
    n1 <= '0' ;
    n2 <= '1' ;
    n5 <= not clk_cnt(0);   -- element/SimpleSPIMaster.v(113)
    n6 <= not clk_cnt(3);   -- element/SimpleSPIMaster.v(113)
    reduce_nor_6: entity work.reduce_nor_7(INTERFACE)  port map (a(6)=>clk_cnt(6),
            a(5)=>clk_cnt(5),a(4)=>clk_cnt(4),a(3)=>n6,a(2)=>clk_cnt(2),
            a(1)=>clk_cnt(1),a(0)=>n5,o=>spi_2x_ce);   -- element/SimpleSPIMaster.v(113)
    add_7: entity work.add_7u_7u(INTERFACE)  port map (cin=>n1,a(6)=>clk_cnt(6),
            a(5)=>clk_cnt(5),a(4)=>clk_cnt(4),a(3)=>clk_cnt(3),a(2)=>clk_cnt(2),
            a(1)=>clk_cnt(1),a(0)=>clk_cnt(0),b(6)=>n1,b(5)=>n1,b(4)=>n1,
            b(3)=>n1,b(2)=>n1,b(1)=>n1,b(0)=>n2,o(6)=>n9,o(5)=>n10,o(4)=>n11,
            o(3)=>n12,o(2)=>n13,o(1)=>n14,o(0)=>n15);   -- element/SimpleSPIMaster.v(114)
    n16 <= n1 when spi_2x_ce='1' else n9;   -- element/SimpleSPIMaster.v(113)
    n17 <= n1 when spi_2x_ce='1' else n10;   -- element/SimpleSPIMaster.v(113)
    n18 <= n1 when spi_2x_ce='1' else n11;   -- element/SimpleSPIMaster.v(113)
    n19 <= n1 when spi_2x_ce='1' else n12;   -- element/SimpleSPIMaster.v(113)
    n20 <= n1 when spi_2x_ce='1' else n13;   -- element/SimpleSPIMaster.v(113)
    n21 <= n1 when spi_2x_ce='1' else n14;   -- element/SimpleSPIMaster.v(113)
    n22 <= n1 when spi_2x_ce='1' else n15;   -- element/SimpleSPIMaster.v(113)
    n23 <= n1 when rst='1' else n16;   -- element/SimpleSPIMaster.v(111)
    n24 <= n1 when rst='1' else n17;   -- element/SimpleSPIMaster.v(111)
    n25 <= n1 when rst='1' else n18;   -- element/SimpleSPIMaster.v(111)
    n26 <= n1 when rst='1' else n19;   -- element/SimpleSPIMaster.v(111)
    n27 <= n1 when rst='1' else n20;   -- element/SimpleSPIMaster.v(111)
    n28 <= n1 when rst='1' else n21;   -- element/SimpleSPIMaster.v(111)
    n29 <= n1 when rst='1' else n22;   -- element/SimpleSPIMaster.v(111)
    i24: VERIFIC_DFFRS (d=>n24,clk=>clk,s=>n1,r=>n1,q=>clk_cnt(5));   -- element/SimpleSPIMaster.v(110)
    i25: VERIFIC_DFFRS (d=>n25,clk=>clk,s=>n1,r=>n1,q=>clk_cnt(4));   -- element/SimpleSPIMaster.v(110)
    i26: VERIFIC_DFFRS (d=>n26,clk=>clk,s=>n1,r=>n1,q=>clk_cnt(3));   -- element/SimpleSPIMaster.v(110)
    i27: VERIFIC_DFFRS (d=>n27,clk=>clk,s=>n1,r=>n1,q=>clk_cnt(2));   -- element/SimpleSPIMaster.v(110)
    i28: VERIFIC_DFFRS (d=>n28,clk=>clk,s=>n1,r=>n1,q=>clk_cnt(1));   -- element/SimpleSPIMaster.v(110)
    i29: VERIFIC_DFFRS (d=>n29,clk=>clk,s=>n1,r=>n1,q=>clk_cnt(0));   -- element/SimpleSPIMaster.v(110)
    i39: VERIFIC_DFFRS (d=>n44,clk=>clk,s=>n1,r=>n1,q=>core_clk);   -- element/SimpleSPIMaster.v(119)
    n41 <= not core_clk;   -- element/SimpleSPIMaster.v(126)
    n42 <= n41 when spi_2x_ce='1' else core_clk;   -- element/SimpleSPIMaster.v(125)
    n43 <= core_clk when spi_2x_ce='1' else core_n_clk;   -- element/SimpleSPIMaster.v(125)
    n44 <= n1 when rst='1' else n42;   -- element/SimpleSPIMaster.v(120)
    n45 <= n1 when rst='1' else n43;   -- element/SimpleSPIMaster.v(120)
    i40: VERIFIC_DFFRS (d=>n45,clk=>clk,s=>n1,r=>n1,q=>core_n_clk);   -- element/SimpleSPIMaster.v(119)
    i69: VERIFIC_DFFRS (d=>n76,clk=>clk,s=>n1,r=>n1,q=>bit_count(7));   -- element/SimpleSPIMaster.v(147)
    fsm_ce <= spi_2x_ce and core_n_clk;   -- element/SimpleSPIMaster.v(131)
    samp_ce <= spi_2x_ce and core_clk;   -- element/SimpleSPIMaster.v(132)
    add_43: entity work.add_8u_8u(INTERFACE)  port map (cin=>n1,a(7)=>bit_count(7),
            a(6)=>bit_count(6),a(5)=>bit_count(5),a(4)=>bit_count(4),a(3)=>bit_count(3),
            a(2)=>bit_count(2),a(1)=>bit_count(1),a(0)=>bit_count(0),b(7)=>n1,
            b(6)=>n1,b(5)=>n1,b(4)=>n1,b(3)=>n1,b(2)=>n1,b(1)=>n1,b(0)=>n2,
            o(7)=>n52,o(6)=>n53,o(5)=>n54,o(4)=>n55,o(3)=>n56,o(2)=>n57,
            o(1)=>n58,o(0)=>n59);   -- element/SimpleSPIMaster.v(152)
    n60 <= n1 when bit_count_clr='1' else n52;   -- element/SimpleSPIMaster.v(151)
    n61 <= n1 when bit_count_clr='1' else n53;   -- element/SimpleSPIMaster.v(151)
    n62 <= n1 when bit_count_clr='1' else n54;   -- element/SimpleSPIMaster.v(151)
    n63 <= n1 when bit_count_clr='1' else n55;   -- element/SimpleSPIMaster.v(151)
    n64 <= n1 when bit_count_clr='1' else n56;   -- element/SimpleSPIMaster.v(151)
    n65 <= n1 when bit_count_clr='1' else n57;   -- element/SimpleSPIMaster.v(151)
    n66 <= n1 when bit_count_clr='1' else n58;   -- element/SimpleSPIMaster.v(151)
    n67 <= n1 when bit_count_clr='1' else n59;   -- element/SimpleSPIMaster.v(151)
    n68 <= n60 when fsm_ce='1' else bit_count(7);   -- element/SimpleSPIMaster.v(150)
    n69 <= n61 when fsm_ce='1' else bit_count(6);   -- element/SimpleSPIMaster.v(150)
    n70 <= n62 when fsm_ce='1' else bit_count(5);   -- element/SimpleSPIMaster.v(150)
    n71 <= n63 when fsm_ce='1' else bit_count(4);   -- element/SimpleSPIMaster.v(150)
    n72 <= n64 when fsm_ce='1' else bit_count(3);   -- element/SimpleSPIMaster.v(150)
    n73 <= n65 when fsm_ce='1' else bit_count(2);   -- element/SimpleSPIMaster.v(150)
    n74 <= n66 when fsm_ce='1' else bit_count(1);   -- element/SimpleSPIMaster.v(150)
    n75 <= n67 when fsm_ce='1' else bit_count(0);   -- element/SimpleSPIMaster.v(150)
    n76 <= n1 when rst='1' else n68;   -- element/SimpleSPIMaster.v(148)
    n77 <= n1 when rst='1' else n69;   -- element/SimpleSPIMaster.v(148)
    n78 <= n1 when rst='1' else n70;   -- element/SimpleSPIMaster.v(148)
    n79 <= n1 when rst='1' else n71;   -- element/SimpleSPIMaster.v(148)
    n80 <= n1 when rst='1' else n72;   -- element/SimpleSPIMaster.v(148)
    n81 <= n1 when rst='1' else n73;   -- element/SimpleSPIMaster.v(148)
    n82 <= n1 when rst='1' else n74;   -- element/SimpleSPIMaster.v(148)
    n83 <= n1 when rst='1' else n75;   -- element/SimpleSPIMaster.v(148)
    i70: VERIFIC_DFFRS (d=>n77,clk=>clk,s=>n1,r=>n1,q=>bit_count(6));   -- element/SimpleSPIMaster.v(147)
    i71: VERIFIC_DFFRS (d=>n78,clk=>clk,s=>n1,r=>n1,q=>bit_count(5));   -- element/SimpleSPIMaster.v(147)
    i72: VERIFIC_DFFRS (d=>n79,clk=>clk,s=>n1,r=>n1,q=>bit_count(4));   -- element/SimpleSPIMaster.v(147)
    i73: VERIFIC_DFFRS (d=>n80,clk=>clk,s=>n1,r=>n1,q=>bit_count(3));   -- element/SimpleSPIMaster.v(147)
    i74: VERIFIC_DFFRS (d=>n81,clk=>clk,s=>n1,r=>n1,q=>bit_count(2));   -- element/SimpleSPIMaster.v(147)
    i75: VERIFIC_DFFRS (d=>n82,clk=>clk,s=>n1,r=>n1,q=>bit_count(1));   -- element/SimpleSPIMaster.v(147)
    i76: VERIFIC_DFFRS (d=>n83,clk=>clk,s=>n1,r=>n1,q=>bit_count(0));   -- element/SimpleSPIMaster.v(147)
    i148: VERIFIC_DFFRS (d=>n146,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(15));   -- element/SimpleSPIMaster.v(160)
    n93 <= din(15) when wr='1' else tx_buffer(15);   -- element/SimpleSPIMaster.v(167)
    n94 <= din(14) when wr='1' else tx_buffer(14);   -- element/SimpleSPIMaster.v(167)
    n95 <= din(13) when wr='1' else tx_buffer(13);   -- element/SimpleSPIMaster.v(167)
    n96 <= din(12) when wr='1' else tx_buffer(12);   -- element/SimpleSPIMaster.v(167)
    n97 <= din(11) when wr='1' else tx_buffer(11);   -- element/SimpleSPIMaster.v(167)
    n98 <= din(10) when wr='1' else tx_buffer(10);   -- element/SimpleSPIMaster.v(167)
    n99 <= din(9) when wr='1' else tx_buffer(9);   -- element/SimpleSPIMaster.v(167)
    n100 <= din(8) when wr='1' else tx_buffer(8);   -- element/SimpleSPIMaster.v(167)
    n101 <= din(7) when wr='1' else tx_buffer(7);   -- element/SimpleSPIMaster.v(167)
    n102 <= din(6) when wr='1' else tx_buffer(6);   -- element/SimpleSPIMaster.v(167)
    n103 <= din(5) when wr='1' else tx_buffer(5);   -- element/SimpleSPIMaster.v(167)
    n104 <= din(4) when wr='1' else tx_buffer(4);   -- element/SimpleSPIMaster.v(167)
    n105 <= din(3) when wr='1' else tx_buffer(3);   -- element/SimpleSPIMaster.v(167)
    n106 <= din(2) when wr='1' else tx_buffer(2);   -- element/SimpleSPIMaster.v(167)
    n107 <= din(1) when wr='1' else tx_buffer(1);   -- element/SimpleSPIMaster.v(167)
    n108 <= din(0) when wr='1' else tx_buffer(0);   -- element/SimpleSPIMaster.v(167)
    n109 <= n1 when wr='1' else tx_buffer_empty;   -- element/SimpleSPIMaster.v(167)
    n110 <= rd and samp_ce;   -- element/SimpleSPIMaster.v(173)
    n111 <= n2 when n110='1' else tx_buffer_empty;   -- element/SimpleSPIMaster.v(173)
    n112 <= tx_buffer_shift and fsm_ce;   -- element/SimpleSPIMaster.v(174)
    n113 <= tx_buffer(14) when n112='1' else tx_buffer(15);   -- element/SimpleSPIMaster.v(174)
    n114 <= tx_buffer(13) when n112='1' else tx_buffer(14);   -- element/SimpleSPIMaster.v(174)
    n115 <= tx_buffer(12) when n112='1' else tx_buffer(13);   -- element/SimpleSPIMaster.v(174)
    n116 <= tx_buffer(11) when n112='1' else tx_buffer(12);   -- element/SimpleSPIMaster.v(174)
    n117 <= tx_buffer(10) when n112='1' else tx_buffer(11);   -- element/SimpleSPIMaster.v(174)
    n118 <= tx_buffer(9) when n112='1' else tx_buffer(10);   -- element/SimpleSPIMaster.v(174)
    n119 <= tx_buffer(8) when n112='1' else tx_buffer(9);   -- element/SimpleSPIMaster.v(174)
    n120 <= tx_buffer(7) when n112='1' else tx_buffer(8);   -- element/SimpleSPIMaster.v(174)
    n121 <= tx_buffer(6) when n112='1' else tx_buffer(7);   -- element/SimpleSPIMaster.v(174)
    n122 <= tx_buffer(5) when n112='1' else tx_buffer(6);   -- element/SimpleSPIMaster.v(174)
    n123 <= tx_buffer(4) when n112='1' else tx_buffer(5);   -- element/SimpleSPIMaster.v(174)
    n124 <= tx_buffer(3) when n112='1' else tx_buffer(4);   -- element/SimpleSPIMaster.v(174)
    n125 <= tx_buffer(2) when n112='1' else tx_buffer(3);   -- element/SimpleSPIMaster.v(174)
    n126 <= tx_buffer(1) when n112='1' else tx_buffer(2);   -- element/SimpleSPIMaster.v(174)
    n127 <= tx_buffer(0) when n112='1' else tx_buffer(1);   -- element/SimpleSPIMaster.v(174)
    n128 <= n1 when n112='1' else tx_buffer(0);   -- element/SimpleSPIMaster.v(174)
    n129 <= n93 when tx_buffer_empty='1' else n113;   -- element/SimpleSPIMaster.v(166)
    n130 <= n94 when tx_buffer_empty='1' else n114;   -- element/SimpleSPIMaster.v(166)
    n131 <= n95 when tx_buffer_empty='1' else n115;   -- element/SimpleSPIMaster.v(166)
    n132 <= n96 when tx_buffer_empty='1' else n116;   -- element/SimpleSPIMaster.v(166)
    n133 <= n97 when tx_buffer_empty='1' else n117;   -- element/SimpleSPIMaster.v(166)
    n134 <= n98 when tx_buffer_empty='1' else n118;   -- element/SimpleSPIMaster.v(166)
    n135 <= n99 when tx_buffer_empty='1' else n119;   -- element/SimpleSPIMaster.v(166)
    n136 <= n100 when tx_buffer_empty='1' else n120;   -- element/SimpleSPIMaster.v(166)
    n137 <= n101 when tx_buffer_empty='1' else n121;   -- element/SimpleSPIMaster.v(166)
    n138 <= n102 when tx_buffer_empty='1' else n122;   -- element/SimpleSPIMaster.v(166)
    n139 <= n103 when tx_buffer_empty='1' else n123;   -- element/SimpleSPIMaster.v(166)
    n140 <= n104 when tx_buffer_empty='1' else n124;   -- element/SimpleSPIMaster.v(166)
    n141 <= n105 when tx_buffer_empty='1' else n125;   -- element/SimpleSPIMaster.v(166)
    n142 <= n106 when tx_buffer_empty='1' else n126;   -- element/SimpleSPIMaster.v(166)
    n143 <= n107 when tx_buffer_empty='1' else n127;   -- element/SimpleSPIMaster.v(166)
    n144 <= n108 when tx_buffer_empty='1' else n128;   -- element/SimpleSPIMaster.v(166)
    n145 <= n109 when tx_buffer_empty='1' else n111;   -- element/SimpleSPIMaster.v(166)
    n146 <= n1 when rst='1' else n129;   -- element/SimpleSPIMaster.v(161)
    n147 <= n1 when rst='1' else n130;   -- element/SimpleSPIMaster.v(161)
    n148 <= n1 when rst='1' else n131;   -- element/SimpleSPIMaster.v(161)
    n149 <= n1 when rst='1' else n132;   -- element/SimpleSPIMaster.v(161)
    n150 <= n1 when rst='1' else n133;   -- element/SimpleSPIMaster.v(161)
    n151 <= n1 when rst='1' else n134;   -- element/SimpleSPIMaster.v(161)
    n152 <= n1 when rst='1' else n135;   -- element/SimpleSPIMaster.v(161)
    n153 <= n1 when rst='1' else n136;   -- element/SimpleSPIMaster.v(161)
    n154 <= n1 when rst='1' else n137;   -- element/SimpleSPIMaster.v(161)
    n155 <= n1 when rst='1' else n138;   -- element/SimpleSPIMaster.v(161)
    n156 <= n1 when rst='1' else n139;   -- element/SimpleSPIMaster.v(161)
    n157 <= n1 when rst='1' else n140;   -- element/SimpleSPIMaster.v(161)
    n158 <= n1 when rst='1' else n141;   -- element/SimpleSPIMaster.v(161)
    n159 <= n1 when rst='1' else n142;   -- element/SimpleSPIMaster.v(161)
    n160 <= n1 when rst='1' else n143;   -- element/SimpleSPIMaster.v(161)
    n161 <= n1 when rst='1' else n144;   -- element/SimpleSPIMaster.v(161)
    n162 <= n2 when rst='1' else n145;   -- element/SimpleSPIMaster.v(161)
    i149: VERIFIC_DFFRS (d=>n147,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(14));   -- element/SimpleSPIMaster.v(160)
    i150: VERIFIC_DFFRS (d=>n148,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(13));   -- element/SimpleSPIMaster.v(160)
    i151: VERIFIC_DFFRS (d=>n149,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(12));   -- element/SimpleSPIMaster.v(160)
    i152: VERIFIC_DFFRS (d=>n150,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(11));   -- element/SimpleSPIMaster.v(160)
    i153: VERIFIC_DFFRS (d=>n151,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(10));   -- element/SimpleSPIMaster.v(160)
    i154: VERIFIC_DFFRS (d=>n152,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(9));   -- element/SimpleSPIMaster.v(160)
    i155: VERIFIC_DFFRS (d=>n153,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(8));   -- element/SimpleSPIMaster.v(160)
    i156: VERIFIC_DFFRS (d=>n154,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(7));   -- element/SimpleSPIMaster.v(160)
    i157: VERIFIC_DFFRS (d=>n155,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(6));   -- element/SimpleSPIMaster.v(160)
    i158: VERIFIC_DFFRS (d=>n156,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(5));   -- element/SimpleSPIMaster.v(160)
    i159: VERIFIC_DFFRS (d=>n157,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(4));   -- element/SimpleSPIMaster.v(160)
    i160: VERIFIC_DFFRS (d=>n158,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(3));   -- element/SimpleSPIMaster.v(160)
    i161: VERIFIC_DFFRS (d=>n159,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(2));   -- element/SimpleSPIMaster.v(160)
    i162: VERIFIC_DFFRS (d=>n160,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(1));   -- element/SimpleSPIMaster.v(160)
    i163: VERIFIC_DFFRS (d=>n161,clk=>clk,s=>n1,r=>n1,q=>tx_buffer(0));   -- element/SimpleSPIMaster.v(160)
    i164: VERIFIC_DFFRS (d=>n162,clk=>clk,s=>n1,r=>n1,q=>tx_buffer_empty);   -- element/SimpleSPIMaster.v(160)
    i167: VERIFIC_DFFRS (d=>n181,clk=>clk,s=>n1,r=>n1,q=>tx_msb);   -- element/SimpleSPIMaster.v(178)
    n181 <= tx_buffer(14) when fsm_ce='1' else tx_msb;   -- element/SimpleSPIMaster.v(178)
    i173: VERIFIC_DFFRS (d=>n186,clk=>clk,s=>n1,r=>n1,q=>state_reg(1));   -- element/SimpleSPIMaster.v(188)
    n184 <= state_next(1) when fsm_ce='1' else state_reg(1);   -- element/SimpleSPIMaster.v(190)
    n186 <= n1 when rst='1' else n184;   -- element/SimpleSPIMaster.v(189)
    n187 <= n1 when rst='1' else state_reg(0);   -- element/SimpleSPIMaster.v(189)
    i174: VERIFIC_DFFRS (d=>n187,clk=>clk,s=>n1,r=>n1,q=>state_reg(0));   -- element/SimpleSPIMaster.v(188)
    i209: VERIFIC_DFFRS (d=>spi_miso_r(0),clk=>clk,s=>n1,r=>n1,q=>spi_miso_r(1));   -- element/SimpleSPIMaster.v(342)
    n190 <= not tx_buffer_empty;   -- element/SimpleSPIMaster.v(208)
    n199 <= not bit_count(0);   -- element/SimpleSPIMaster.v(223)
    n200 <= not bit_count(1);   -- element/SimpleSPIMaster.v(223)
    n201 <= not bit_count(2);   -- element/SimpleSPIMaster.v(223)
    n202 <= not bit_count(3);   -- element/SimpleSPIMaster.v(223)
    reduce_nor_187: entity work.reduce_nor_8(INTERFACE)  port map (a(7)=>bit_count(7),
            a(6)=>bit_count(6),a(5)=>bit_count(5),a(4)=>bit_count(4),a(3)=>n202,
            a(2)=>n201,a(1)=>n200,a(0)=>n199,o=>n203);   -- element/SimpleSPIMaster.v(223)
    n205 <= n190 when n203='1' else n2;   -- element/SimpleSPIMaster.v(223)
    n206 <= tx_msb when n203='1' else tx_buffer(15);   -- element/SimpleSPIMaster.v(223)
    n207 <= not n203;   -- element/SimpleSPIMaster.v(223)
    Mux_200: entity work.Mux_2u_4u(INTERFACE)  port map (sel(1)=>state_reg(1),
            sel(0)=>state_reg(0),data(3)=>n2,data(2)=>n205,data(1)=>n1,data(0)=>n190,
            o=>state_next(1));   -- element/SimpleSPIMaster.v(206)
    Mux_201: entity work.Mux_2u_4u(INTERFACE)  port map (sel(1)=>state_reg(1),
            sel(0)=>state_reg(0),data(3)=>n1,data(2)=>n1,data(1)=>n1,data(0)=>n2,
            o=>spi_cs);   -- element/SimpleSPIMaster.v(206)
    Mux_202: entity work.Mux_2u_4u(INTERFACE)  port map (sel(1)=>state_reg(1),
            sel(0)=>state_reg(0),data(3)=>n1,data(2)=>n203,data(1)=>n1,data(0)=>n1,
            o=>rd);   -- element/SimpleSPIMaster.v(206)
    Mux_203: entity work.Mux_2u_4u(INTERFACE)  port map (sel(1)=>state_reg(1),
            sel(0)=>state_reg(0),data(3)=>n1,data(2)=>n203,data(1)=>n1,data(0)=>n2,
            o=>bit_count_clr);   -- element/SimpleSPIMaster.v(206)
    Mux_204: entity work.Mux_2u_4u(INTERFACE)  port map (sel(1)=>state_reg(1),
            sel(0)=>state_reg(0),data(3)=>tx_buffer(15),data(2)=>n206,data(1)=>tx_buffer(15),
            data(0)=>tx_buffer(15),o=>spi_mosi);   -- element/SimpleSPIMaster.v(206)
    Mux_205: entity work.Mux_2u_4u(INTERFACE)  port map (sel(1)=>state_reg(1),
            sel(0)=>state_reg(0),data(3)=>n1,data(2)=>n207,data(1)=>n1,data(0)=>n1,
            o=>tx_buffer_shift);   -- element/SimpleSPIMaster.v(206)
    Mux_206: entity work.Mux_2u_4u(INTERFACE)  port map (sel(1)=>state_reg(1),
            sel(0)=>state_reg(0),data(3)=>n1,data(2)=>core_n_clk,data(1)=>n1,
            data(0)=>n1,o=>spi_sck);   -- element/SimpleSPIMaster.v(206)
    i210: VERIFIC_DFFRS (d=>spi_miso,clk=>clk,s=>n1,r=>n1,q=>spi_miso_r(0));   -- element/SimpleSPIMaster.v(342)
    i212: VERIFIC_DFFRS (d=>samp_ce_r(0),clk=>clk,s=>n1,r=>n1,q=>samp_ce_r(1));   -- element/SimpleSPIMaster.v(345)
    i213: VERIFIC_DFFRS (d=>samp_ce,clk=>clk,s=>n1,r=>n1,q=>samp_ce_r(0));   -- element/SimpleSPIMaster.v(345)
    i215: VERIFIC_DFFRS (d=>bit_count(7),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(7));   -- element/SimpleSPIMaster.v(348)
    i216: VERIFIC_DFFRS (d=>bit_count(6),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(6));   -- element/SimpleSPIMaster.v(348)
    i217: VERIFIC_DFFRS (d=>bit_count(5),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(5));   -- element/SimpleSPIMaster.v(348)
    i218: VERIFIC_DFFRS (d=>bit_count(4),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(4));   -- element/SimpleSPIMaster.v(348)
    i219: VERIFIC_DFFRS (d=>bit_count(3),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(3));   -- element/SimpleSPIMaster.v(348)
    i220: VERIFIC_DFFRS (d=>bit_count(2),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(2));   -- element/SimpleSPIMaster.v(348)
    i221: VERIFIC_DFFRS (d=>bit_count(1),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(1));   -- element/SimpleSPIMaster.v(348)
    i222: VERIFIC_DFFRS (d=>bit_count(0),clk=>clk,s=>n1,r=>n1,q=>bit_count_r0(0));   -- element/SimpleSPIMaster.v(348)
    i223: VERIFIC_DFFRS (d=>bit_count_r0(7),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(7));   -- element/SimpleSPIMaster.v(348)
    i224: VERIFIC_DFFRS (d=>bit_count_r0(6),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(6));   -- element/SimpleSPIMaster.v(348)
    i225: VERIFIC_DFFRS (d=>bit_count_r0(5),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(5));   -- element/SimpleSPIMaster.v(348)
    i226: VERIFIC_DFFRS (d=>bit_count_r0(4),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(4));   -- element/SimpleSPIMaster.v(348)
    i227: VERIFIC_DFFRS (d=>bit_count_r0(3),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(3));   -- element/SimpleSPIMaster.v(348)
    i228: VERIFIC_DFFRS (d=>bit_count_r0(2),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(2));   -- element/SimpleSPIMaster.v(348)
    i229: VERIFIC_DFFRS (d=>bit_count_r0(1),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(1));   -- element/SimpleSPIMaster.v(348)
    i230: VERIFIC_DFFRS (d=>bit_count_r0(0),clk=>clk,s=>n1,r=>n1,q=>bit_count_r1(0));   -- element/SimpleSPIMaster.v(348)
    i271: VERIFIC_DFFRS (d=>n269,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(15));   -- element/SimpleSPIMaster.v(355)
    n247 <= rx_buffer(14) when samp_ce_r(1)='1' else rx_buffer(15);   -- element/SimpleSPIMaster.v(361)
    n248 <= rx_buffer(13) when samp_ce_r(1)='1' else rx_buffer(14);   -- element/SimpleSPIMaster.v(361)
    n249 <= rx_buffer(12) when samp_ce_r(1)='1' else rx_buffer(13);   -- element/SimpleSPIMaster.v(361)
    n250 <= rx_buffer(11) when samp_ce_r(1)='1' else rx_buffer(12);   -- element/SimpleSPIMaster.v(361)
    n251 <= rx_buffer(10) when samp_ce_r(1)='1' else rx_buffer(11);   -- element/SimpleSPIMaster.v(361)
    n252 <= rx_buffer(9) when samp_ce_r(1)='1' else rx_buffer(10);   -- element/SimpleSPIMaster.v(361)
    n253 <= rx_buffer(8) when samp_ce_r(1)='1' else rx_buffer(9);   -- element/SimpleSPIMaster.v(361)
    n254 <= rx_buffer(7) when samp_ce_r(1)='1' else rx_buffer(8);   -- element/SimpleSPIMaster.v(361)
    n255 <= rx_buffer(6) when samp_ce_r(1)='1' else rx_buffer(7);   -- element/SimpleSPIMaster.v(361)
    n256 <= rx_buffer(5) when samp_ce_r(1)='1' else rx_buffer(6);   -- element/SimpleSPIMaster.v(361)
    n257 <= rx_buffer(4) when samp_ce_r(1)='1' else rx_buffer(5);   -- element/SimpleSPIMaster.v(361)
    n258 <= rx_buffer(3) when samp_ce_r(1)='1' else rx_buffer(4);   -- element/SimpleSPIMaster.v(361)
    n259 <= rx_buffer(2) when samp_ce_r(1)='1' else rx_buffer(3);   -- element/SimpleSPIMaster.v(361)
    n260 <= rx_buffer(1) when samp_ce_r(1)='1' else rx_buffer(2);   -- element/SimpleSPIMaster.v(361)
    n261 <= rx_buffer(0) when samp_ce_r(1)='1' else rx_buffer(1);   -- element/SimpleSPIMaster.v(361)
    n262 <= spi_miso_r(1) when samp_ce_r(1)='1' else rx_buffer(0);   -- element/SimpleSPIMaster.v(361)
    n263 <= not bit_count_r1(0);   -- element/SimpleSPIMaster.v(362)
    n264 <= not bit_count_r1(1);   -- element/SimpleSPIMaster.v(362)
    n265 <= not bit_count_r1(2);   -- element/SimpleSPIMaster.v(362)
    n266 <= not bit_count_r1(3);   -- element/SimpleSPIMaster.v(362)
    reduce_nor_251: entity work.reduce_nor_8(INTERFACE)  port map (a(7)=>bit_count_r1(7),
            a(6)=>bit_count_r1(6),a(5)=>bit_count_r1(5),a(4)=>bit_count_r1(4),
            a(3)=>n266,a(2)=>n265,a(1)=>n264,a(0)=>n263,o=>n267);   -- element/SimpleSPIMaster.v(362)
    n268 <= samp_ce_r(1) and n267;   -- element/SimpleSPIMaster.v(362)
    n269 <= n1 when rst='1' else n247;   -- element/SimpleSPIMaster.v(356)
    n270 <= n1 when rst='1' else n248;   -- element/SimpleSPIMaster.v(356)
    n271 <= n1 when rst='1' else n249;   -- element/SimpleSPIMaster.v(356)
    n272 <= n1 when rst='1' else n250;   -- element/SimpleSPIMaster.v(356)
    n273 <= n1 when rst='1' else n251;   -- element/SimpleSPIMaster.v(356)
    n274 <= n1 when rst='1' else n252;   -- element/SimpleSPIMaster.v(356)
    n275 <= n1 when rst='1' else n253;   -- element/SimpleSPIMaster.v(356)
    n276 <= n1 when rst='1' else n254;   -- element/SimpleSPIMaster.v(356)
    n277 <= n1 when rst='1' else n255;   -- element/SimpleSPIMaster.v(356)
    n278 <= n1 when rst='1' else n256;   -- element/SimpleSPIMaster.v(356)
    n279 <= n1 when rst='1' else n257;   -- element/SimpleSPIMaster.v(356)
    n280 <= n1 when rst='1' else n258;   -- element/SimpleSPIMaster.v(356)
    n281 <= n1 when rst='1' else n259;   -- element/SimpleSPIMaster.v(356)
    n282 <= n1 when rst='1' else n260;   -- element/SimpleSPIMaster.v(356)
    n283 <= n1 when rst='1' else n261;   -- element/SimpleSPIMaster.v(356)
    n284 <= n1 when rst='1' else n262;   -- element/SimpleSPIMaster.v(356)
    n285 <= n1 when rst='1' else n268;   -- element/SimpleSPIMaster.v(356)
    i272: VERIFIC_DFFRS (d=>n270,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(14));   -- element/SimpleSPIMaster.v(355)
    i273: VERIFIC_DFFRS (d=>n271,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(13));   -- element/SimpleSPIMaster.v(355)
    i274: VERIFIC_DFFRS (d=>n272,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(12));   -- element/SimpleSPIMaster.v(355)
    i275: VERIFIC_DFFRS (d=>n273,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(11));   -- element/SimpleSPIMaster.v(355)
    i276: VERIFIC_DFFRS (d=>n274,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(10));   -- element/SimpleSPIMaster.v(355)
    i277: VERIFIC_DFFRS (d=>n275,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(9));   -- element/SimpleSPIMaster.v(355)
    i278: VERIFIC_DFFRS (d=>n276,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(8));   -- element/SimpleSPIMaster.v(355)
    i279: VERIFIC_DFFRS (d=>n277,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(7));   -- element/SimpleSPIMaster.v(355)
    i280: VERIFIC_DFFRS (d=>n278,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(6));   -- element/SimpleSPIMaster.v(355)
    i281: VERIFIC_DFFRS (d=>n279,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(5));   -- element/SimpleSPIMaster.v(355)
    i282: VERIFIC_DFFRS (d=>n280,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(4));   -- element/SimpleSPIMaster.v(355)
    i283: VERIFIC_DFFRS (d=>n281,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(3));   -- element/SimpleSPIMaster.v(355)
    i284: VERIFIC_DFFRS (d=>n282,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(2));   -- element/SimpleSPIMaster.v(355)
    i285: VERIFIC_DFFRS (d=>n283,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(1));   -- element/SimpleSPIMaster.v(355)
    i286: VERIFIC_DFFRS (d=>n284,clk=>clk,s=>n1,r=>n1,q=>rx_buffer(0));   -- element/SimpleSPIMaster.v(355)
    i287: VERIFIC_DFFRS (d=>n285,clk=>clk,s=>n1,r=>n1,q=>dout_valid_c);   -- element/SimpleSPIMaster.v(355)
    i23: VERIFIC_DFFRS (d=>n23,clk=>clk,s=>n1,r=>n1,q=>clk_cnt(6));   -- element/SimpleSPIMaster.v(110)
    
end architecture \.\;   -- element/SimpleSPIMaster.v(86)


--
-- Verific VHDL Description of module adc_config
--

library ieee ;
use ieee.std_logic_1164.all ;

entity adc_config is
    port (clk: in std_logic;   -- ADC/adc_config.v(30)
        rst: in std_logic;   -- ADC/adc_config.v(31)
        config_done: out std_logic;   -- ADC/adc_config.v(32)
        config_din_valid: in std_logic;   -- ADC/adc_config.v(34)
        config_din_addr: in std_logic_vector(31 downto 0);   -- ADC/adc_config.v(35)
        config_din_data: in std_logic_vector(31 downto 0);   -- ADC/adc_config.v(36)
        config_dout_valid: out std_logic;   -- ADC/adc_config.v(38)
        config_dout_addr: out std_logic_vector(31 downto 0);   -- ADC/adc_config.v(39)
        config_dout_data: out std_logic_vector(31 downto 0);   -- ADC/adc_config.v(40)
        adc_clkdiv: in std_logic_vector(1 downto 0);   -- ADC/adc_config.v(42)
        training_start: out std_logic_vector(1 downto 0);   -- ADC/adc_config.v(43)
        training_done: in std_logic_vector(1 downto 0);   -- ADC/adc_config.v(44)
        tap: in std_logic_vector(159 downto 0);   -- ADC/adc_config.v(45)
        idly_enable: out std_logic_vector(1 downto 0);   -- ADC/adc_config.v(46)
        idly_chan_sel: out std_logic_vector(7 downto 0);   -- ADC/adc_config.v(47)
        idly_inc: out std_logic_vector(1 downto 0);   -- ADC/adc_config.v(48)
        idly_dec: out std_logic_vector(1 downto 0);   -- ADC/adc_config.v(49)
        idly_bitslip: out std_logic_vector(1 downto 0);   -- ADC/adc_config.v(50)
        idly_rst: out std_logic_vector(1 downto 0);   -- ADC/adc_config.v(51)
        adc_sync: out std_logic_vector(1 downto 0);   -- ADC/adc_config.v(52)
        adc_spi_ck: out std_logic;   -- ADC/adc_config.v(54)
        adc_spi_mosi: out std_logic;   -- ADC/adc_config.v(55)
        adc_spi_miso: in std_logic;   -- ADC/adc_config.v(56)
        adc_spi_csn: out std_logic   -- ADC/adc_config.v(57)
    );
    
end entity adc_config;   -- ADC/adc_config.v(27)

architecture \.\ of adc_config is 
    procedure VERIFIC_DFFRS (d: in std_logic;
        signal clk: in std_logic;
        s: in std_logic;
        r: in std_logic;
        signal q: inout std_logic
    ) is begin
        if (s='1') then
            q <= '1' ;
        elsif (r='1') then
            q <= '0' ;
        elsif (clk'event and clk='1') then
            q <= d ;
        end if ;
    end procedure VERIFIC_DFFRS;
    signal config_done_c : std_logic;   -- ADC/adc_config.v(32)
    signal training_done_r : std_logic_vector(1 downto 0);   -- ADC/adc_config.v(61)
    signal spi_rx_d_valid : std_logic;   -- ADC/adc_config.v(73)
    signal spi_tx_d : std_logic_vector(23 downto 0);   -- ADC/adc_config.v(74)
    signal init_count : std_logic_vector(7 downto 0);   -- ADC/adc_config.v(85)
    signal init_count_en : std_logic;   -- ADC/adc_config.v(86)
    signal current_state : std_logic_vector(4 downto 0);   -- ADC/adc_config.v(94)
    signal next_state : std_logic_vector(4 downto 0);   -- ADC/adc_config.v(94)
    signal auto_config_sync : std_logic;   -- ADC/adc_config.v(117)
    signal training_start_r : std_logic;   -- ADC/adc_config.v(118)
    signal auto_config_sync_r : std_logic;   -- ADC/adc_config.v(179)
    signal training_start_r_r : std_logic;   -- ADC/adc_config.v(184)
    signal addr : std_logic_vector(7 downto 0);   -- ADC/adc_config.v(200)
    signal idly_enable_r : std_logic_vector(1 downto 0);   -- ADC/adc_config.v(203)
    signal idly_chan_sel_r : std_logic_vector(7 downto 0);   -- ADC/adc_config.v(204)
    signal adc_sync_f : std_logic;   -- ADC/adc_config.v(206)
    signal idly_inc_f : std_logic_vector(1 downto 0);   -- ADC/adc_config.v(207)
    signal idly_dec_f : std_logic_vector(1 downto 0);   -- ADC/adc_config.v(208)
    signal idly_bitslip_f : std_logic_vector(1 downto 0);   -- ADC/adc_config.v(209)
    signal idly_rst_f : std_logic_vector(1 downto 0);   -- ADC/adc_config.v(210)
    signal reg_dout_valid_r : std_logic;   -- ADC/adc_config.v(213)
    signal spi_tx_d_valid_r : std_logic;   -- ADC/adc_config.v(215)
    signal n2,n11,n12,n13,n14,n15,n16,n17,n18,n19,n20,n21,n22,n23,
        n24,n25,n26,n27,n28,n29,n30,n31,n32,n33,n34,n44,n45,n46,
        n47,n48,n54,n55,n56,n57,n58,n59,n60,n61,n62,n72,n73,n76,
        n77,n78,n79,n80,n82,n85,n89,n97,n99,n100,n103,n109,n110,
        n111,n113,n114,n116,n117,n119,n120,n122,n123,n127,n130,n133,
        n134,n135,n137,n138,n139,n140,n141,n144,n145,n146,n149,n152,
        n156,n157,n158,n205,n206,n207,n208,n209,n210,n211,n212,n213,
        n214,n215,n216,n217,n242,n243,n244,n245,n246,n247,n248,n249,
        n250,n251,n253,n258,n259,n260,n261,n262,n263,n264,n265,n266,
        n291,n292,n338 : std_logic; 
begin
    config_done <= config_done_c;   -- ADC/adc_config.v(32)
    config_dout_addr(31) <= config_din_addr(31);   -- ADC/adc_config.v(39)
    config_dout_addr(30) <= config_din_addr(30);   -- ADC/adc_config.v(39)
    config_dout_addr(29) <= config_din_addr(29);   -- ADC/adc_config.v(39)
    config_dout_addr(28) <= config_din_addr(28);   -- ADC/adc_config.v(39)
    config_dout_addr(27) <= config_din_addr(27);   -- ADC/adc_config.v(39)
    config_dout_addr(26) <= config_din_addr(26);   -- ADC/adc_config.v(39)
    config_dout_addr(25) <= config_din_addr(25);   -- ADC/adc_config.v(39)
    config_dout_addr(24) <= config_din_addr(24);   -- ADC/adc_config.v(39)
    config_dout_addr(23) <= config_din_addr(23);   -- ADC/adc_config.v(39)
    config_dout_addr(22) <= config_din_addr(22);   -- ADC/adc_config.v(39)
    config_dout_addr(21) <= config_din_addr(21);   -- ADC/adc_config.v(39)
    config_dout_addr(20) <= config_din_addr(20);   -- ADC/adc_config.v(39)
    config_dout_addr(19) <= config_din_addr(19);   -- ADC/adc_config.v(39)
    config_dout_addr(18) <= config_din_addr(18);   -- ADC/adc_config.v(39)
    config_dout_addr(17) <= config_din_addr(17);   -- ADC/adc_config.v(39)
    config_dout_addr(16) <= config_din_addr(16);   -- ADC/adc_config.v(39)
    config_dout_addr(15) <= config_din_addr(15);   -- ADC/adc_config.v(39)
    config_dout_addr(14) <= config_din_addr(14);   -- ADC/adc_config.v(39)
    config_dout_addr(13) <= config_din_addr(13);   -- ADC/adc_config.v(39)
    config_dout_addr(12) <= config_din_addr(12);   -- ADC/adc_config.v(39)
    config_dout_addr(11) <= config_din_addr(11);   -- ADC/adc_config.v(39)
    config_dout_addr(10) <= config_din_addr(10);   -- ADC/adc_config.v(39)
    config_dout_addr(9) <= config_din_addr(9);   -- ADC/adc_config.v(39)
    config_dout_addr(8) <= config_din_addr(8);   -- ADC/adc_config.v(39)
    config_dout_addr(7) <= config_din_addr(7);   -- ADC/adc_config.v(39)
    config_dout_addr(6) <= config_din_addr(6);   -- ADC/adc_config.v(39)
    config_dout_addr(5) <= config_din_addr(5);   -- ADC/adc_config.v(39)
    config_dout_addr(4) <= config_din_addr(4);   -- ADC/adc_config.v(39)
    config_dout_addr(3) <= config_din_addr(3);   -- ADC/adc_config.v(39)
    config_dout_addr(2) <= config_din_addr(2);   -- ADC/adc_config.v(39)
    config_dout_addr(1) <= config_din_addr(1);   -- ADC/adc_config.v(39)
    config_dout_addr(0) <= config_din_addr(0);   -- ADC/adc_config.v(39)
    addr(5) <= '0' ;
    n2 <= '1' ;
    \flag_training_done_proc[0].flag_training_done\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>training_done(0),
            clkB=>clk,SignalOut_clkB=>training_done_r(0));   -- ADC/adc_config.v(64)
    \flag_training_done_proc[1].flag_training_done\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>training_done(1),
            clkB=>clk,SignalOut_clkB=>training_done_r(1));   -- ADC/adc_config.v(64)
    i27: VERIFIC_DFFRS (d=>n27,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(7));   -- ADC/adc_config.v(87)
    add_9: entity work.add_8u_8u(INTERFACE)  port map (cin=>addr(5),a(7)=>init_count(7),
            a(6)=>init_count(6),a(5)=>init_count(5),a(4)=>init_count(4),a(3)=>init_count(3),
            a(2)=>init_count(2),a(1)=>init_count(1),a(0)=>init_count(0),b(7)=>addr(5),
            b(6)=>addr(5),b(5)=>addr(5),b(4)=>addr(5),b(3)=>addr(5),b(2)=>addr(5),
            b(1)=>addr(5),b(0)=>n2,o(7)=>n11,o(6)=>n12,o(5)=>n13,o(4)=>n14,
            o(3)=>n15,o(2)=>n16,o(1)=>n17,o(0)=>n18);   -- ADC/adc_config.v(90)
    n19 <= n11 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n20 <= n12 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n21 <= n13 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n22 <= n14 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n23 <= n15 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n24 <= n16 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n25 <= n17 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n26 <= n18 when init_count_en='1' else addr(5);   -- ADC/adc_config.v(90)
    n27 <= addr(5) when rst='1' else n19;   -- ADC/adc_config.v(88)
    n28 <= addr(5) when rst='1' else n20;   -- ADC/adc_config.v(88)
    n29 <= addr(5) when rst='1' else n21;   -- ADC/adc_config.v(88)
    n30 <= addr(5) when rst='1' else n22;   -- ADC/adc_config.v(88)
    n31 <= addr(5) when rst='1' else n23;   -- ADC/adc_config.v(88)
    n32 <= addr(5) when rst='1' else n24;   -- ADC/adc_config.v(88)
    n33 <= addr(5) when rst='1' else n25;   -- ADC/adc_config.v(88)
    n34 <= addr(5) when rst='1' else n26;   -- ADC/adc_config.v(88)
    i28: VERIFIC_DFFRS (d=>n28,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(6));   -- ADC/adc_config.v(87)
    i29: VERIFIC_DFFRS (d=>n29,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(5));   -- ADC/adc_config.v(87)
    i30: VERIFIC_DFFRS (d=>n30,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(4));   -- ADC/adc_config.v(87)
    i31: VERIFIC_DFFRS (d=>n31,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(3));   -- ADC/adc_config.v(87)
    i32: VERIFIC_DFFRS (d=>n32,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(2));   -- ADC/adc_config.v(87)
    i33: VERIFIC_DFFRS (d=>n33,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(1));   -- ADC/adc_config.v(87)
    i34: VERIFIC_DFFRS (d=>n34,clk=>clk,s=>addr(5),r=>addr(5),q=>init_count(0));   -- ADC/adc_config.v(87)
    i41: VERIFIC_DFFRS (d=>n44,clk=>clk,s=>addr(5),r=>addr(5),q=>current_state(4));   -- ADC/adc_config.v(111)
    n44 <= addr(5) when rst='1' else next_state(4);   -- ADC/adc_config.v(112)
    n45 <= addr(5) when rst='1' else next_state(3);   -- ADC/adc_config.v(112)
    n46 <= addr(5) when rst='1' else next_state(2);   -- ADC/adc_config.v(112)
    n47 <= addr(5) when rst='1' else next_state(1);   -- ADC/adc_config.v(112)
    n48 <= addr(5) when rst='1' else next_state(0);   -- ADC/adc_config.v(112)
    i42: VERIFIC_DFFRS (d=>n45,clk=>clk,s=>addr(5),r=>addr(5),q=>current_state(3));   -- ADC/adc_config.v(111)
    i43: VERIFIC_DFFRS (d=>n46,clk=>clk,s=>addr(5),r=>addr(5),q=>current_state(2));   -- ADC/adc_config.v(111)
    i44: VERIFIC_DFFRS (d=>n47,clk=>clk,s=>addr(5),r=>addr(5),q=>current_state(1));   -- ADC/adc_config.v(111)
    i45: VERIFIC_DFFRS (d=>n48,clk=>clk,s=>addr(5),r=>addr(5),q=>current_state(0));   -- ADC/adc_config.v(111)
    i120: VERIFIC_DFFRS (d=>n127,clk=>clk,s=>addr(5),r=>addr(5),q=>auto_config_sync_r);   -- ADC/adc_config.v(180)
    n54 <= not init_count(0);   -- ADC/adc_config.v(129)
    n55 <= not init_count(1);   -- ADC/adc_config.v(129)
    n56 <= not init_count(2);   -- ADC/adc_config.v(129)
    n57 <= not init_count(3);   -- ADC/adc_config.v(129)
    n58 <= not init_count(4);   -- ADC/adc_config.v(129)
    n59 <= not init_count(5);   -- ADC/adc_config.v(129)
    n60 <= not init_count(6);   -- ADC/adc_config.v(129)
    n61 <= not init_count(7);   -- ADC/adc_config.v(129)
    reduce_nor_53: entity work.reduce_nor_8(INTERFACE)  port map (a(7)=>n61,
            a(6)=>n60,a(5)=>n59,a(4)=>n58,a(3)=>n57,a(2)=>n56,a(1)=>n55,
            a(0)=>n54,o=>n62);   -- ADC/adc_config.v(129)
    reduce_and_63: entity work.reduce_and_2(INTERFACE)  port map (a(1)=>training_done_r(1),
            a(0)=>training_done_r(0),o=>n72);   -- ADC/adc_config.v(157)
    n73 <= not n72;   -- ADC/adc_config.v(157)
    reduce_nor_67: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>current_state(4),
            a(3)=>current_state(3),a(2)=>current_state(2),a(1)=>current_state(1),
            a(0)=>current_state(0),o=>n76);   -- ADC/adc_config.v(128)
    n77 <= not current_state(0);   -- ADC/adc_config.v(133)
    n78 <= not current_state(2);   -- ADC/adc_config.v(133)
    reduce_nor_70: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>current_state(4),
            a(3)=>current_state(3),a(2)=>n78,a(1)=>current_state(1),a(0)=>n77,
            o=>n79);   -- ADC/adc_config.v(133)
    n80 <= not current_state(1);   -- ADC/adc_config.v(138)
    reduce_nor_73: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>current_state(4),
            a(3)=>current_state(3),a(2)=>n78,a(1)=>n80,a(0)=>current_state(0),
            o=>n82);   -- ADC/adc_config.v(138)
    n85 <= not current_state(3);   -- ADC/adc_config.v(143)
    reduce_nor_77: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>current_state(4),
            a(3)=>n85,a(2)=>current_state(2),a(1)=>n80,a(0)=>n77,o=>auto_config_sync);   -- ADC/adc_config.v(143)
    reduce_nor_80: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>current_state(4),
            a(3)=>n85,a(2)=>n78,a(1)=>current_state(1),a(0)=>current_state(0),
            o=>n89);   -- ADC/adc_config.v(147)
    reduce_nor_84: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>current_state(4),
            a(3)=>n85,a(2)=>n78,a(1)=>current_state(1),a(0)=>n77,o=>training_start_r);   -- ADC/adc_config.v(152)
    reduce_nor_88: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>current_state(4),
            a(3)=>n85,a(2)=>n78,a(1)=>n80,a(0)=>current_state(0),o=>n97);   -- ADC/adc_config.v(156)
    n99 <= not current_state(4);   -- ADC/adc_config.v(161)
    reduce_nor_91: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>n99,
            a(3)=>current_state(3),a(2)=>current_state(2),a(1)=>current_state(1),
            a(0)=>n77,o=>n100);   -- ADC/adc_config.v(161)
    reduce_nor_94: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>n99,
            a(3)=>current_state(3),a(2)=>current_state(2),a(1)=>n80,a(0)=>current_state(0),
            o=>n103);   -- ADC/adc_config.v(166)
    reduce_nor_99: entity work.reduce_nor_5(INTERFACE)  port map (a(4)=>n99,
            a(3)=>current_state(3),a(2)=>n78,a(1)=>n80,a(0)=>n77,o=>config_done_c);   -- ADC/adc_config.v(171)
    reduce_nor_100: entity work.reduce_nor_10(INTERFACE)  port map (a(9)=>n76,
            a(8)=>n79,a(7)=>n82,a(6)=>auto_config_sync,a(5)=>n89,a(4)=>training_start_r,
            a(3)=>n97,a(2)=>n100,a(1)=>n103,a(0)=>config_done_c,o=>n109);   -- ADC/adc_config.v(127)
    reduce_or_101: entity work.reduce_or_6(INTERFACE)  port map (a(5)=>n76,
            a(4)=>n79,a(3)=>n82,a(2)=>auto_config_sync,a(1)=>n89,a(0)=>training_start_r,
            o=>n110);   -- ADC/adc_config.v(127)
    reduce_or_102: entity work.reduce_or_4(INTERFACE)  port map (a(3)=>n100,
            a(2)=>n103,a(1)=>config_done_c,a(0)=>n109,o=>n111);   -- ADC/adc_config.v(127)
    Select_103: entity work.Select_3(INTERFACE)  port map (sel(2)=>n110,sel(1)=>n97,
            sel(0)=>n111,data(2)=>addr(5),data(1)=>n72,data(0)=>n2,o=>next_state(4));   -- ADC/adc_config.v(127)
    reduce_or_104: entity work.reduce_or_6(INTERFACE)  port map (a(5)=>n76,
            a(4)=>n79,a(3)=>n100,a(2)=>n103,a(1)=>config_done_c,a(0)=>n109,
            o=>n113);   -- ADC/adc_config.v(127)
    reduce_or_105: entity work.reduce_or_4(INTERFACE)  port map (a(3)=>n82,
            a(2)=>auto_config_sync,a(1)=>n89,a(0)=>training_start_r,o=>n114);   -- ADC/adc_config.v(127)
    Select_106: entity work.Select_3(INTERFACE)  port map (sel(2)=>n113,sel(1)=>n114,
            sel(0)=>n97,data(2)=>addr(5),data(1)=>n2,data(0)=>n73,o=>next_state(3));   -- ADC/adc_config.v(127)
    reduce_or_107: entity work.reduce_or_7(INTERFACE)  port map (a(6)=>n79,
            a(5)=>auto_config_sync,a(4)=>n89,a(3)=>training_start_r,a(2)=>n103,
            a(1)=>config_done_c,a(0)=>n109,o=>n116);   -- ADC/adc_config.v(127)
    n117 <= n82 or n100;   -- ADC/adc_config.v(127)
    Select_109: entity work.Select_4(INTERFACE)  port map (sel(3)=>n76,sel(2)=>n116,
            sel(1)=>n117,sel(0)=>n97,data(3)=>n62,data(2)=>n2,data(1)=>addr(5),
            data(0)=>n73,o=>next_state(2));   -- ADC/adc_config.v(127)
    reduce_or_110: entity work.reduce_or_3(INTERFACE)  port map (a(2)=>n76,
            a(1)=>auto_config_sync,a(0)=>n89,o=>n119);   -- ADC/adc_config.v(127)
    reduce_or_111: entity work.reduce_or_7(INTERFACE)  port map (a(6)=>n79,
            a(5)=>n82,a(4)=>training_start_r,a(3)=>n100,a(2)=>n103,a(1)=>config_done_c,
            a(0)=>n109,o=>n120);   -- ADC/adc_config.v(127)
    Select_112: entity work.Select_3(INTERFACE)  port map (sel(2)=>n119,sel(1)=>n120,
            sel(0)=>n97,data(2)=>addr(5),data(1)=>n2,data(0)=>n73,o=>next_state(1));   -- ADC/adc_config.v(127)
    reduce_or_113: entity work.reduce_or_4(INTERFACE)  port map (a(3)=>n79,
            a(2)=>auto_config_sync,a(1)=>training_start_r,a(0)=>n100,o=>n122);   -- ADC/adc_config.v(127)
    reduce_or_114: entity work.reduce_or_4(INTERFACE)  port map (a(3)=>n82,
            a(2)=>n103,a(1)=>config_done_c,a(0)=>n109,o=>n123);   -- ADC/adc_config.v(127)
    Select_115: entity work.Select_5(INTERFACE)  port map (sel(4)=>n76,sel(3)=>n122,
            sel(2)=>n123,sel(1)=>n89,sel(0)=>n97,data(4)=>n62,data(3)=>addr(5),
            data(2)=>n2,data(1)=>n62,data(0)=>n72,o=>next_state(0));   -- ADC/adc_config.v(127)
    init_count_en <= n76 or n89;   -- ADC/adc_config.v(127)
    n127 <= addr(5) when rst='1' else auto_config_sync;   -- ADC/adc_config.v(181)
    i123: VERIFIC_DFFRS (d=>n130,clk=>clk,s=>addr(5),r=>addr(5),q=>training_start_r_r);   -- ADC/adc_config.v(185)
    n130 <= addr(5) when rst='1' else training_start_r;   -- ADC/adc_config.v(186)
    \flag_training_start_proc[0].flag_training_start\: entity work.Flag_CrossDomain(\.\)  port map (clkA=>clk,
            FlagIn_clkA=>training_start_r_r,clkB=>adc_clkdiv(0),FlagOut_clkB=>training_start(0));   -- ADC/adc_config.v(190)
    n133 <= not config_din_addr(6);   -- ADC/adc_config.v(238)
    reduce_nor_125: entity work.reduce_nor_2(INTERFACE)  port map (a(1)=>n133,
            a(0)=>config_din_addr(5),o=>n134);   -- ADC/adc_config.v(238)
    n135 <= config_din_valid and n134;   -- ADC/adc_config.v(238)
    reduce_nor_128: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>config_din_addr(1),a(0)=>config_din_addr(0),
            o=>n137);   -- ADC/adc_config.v(242)
    n138 <= not config_din_addr(0);   -- ADC/adc_config.v(245)
    reduce_nor_130: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>config_din_addr(1),a(0)=>n138,
            o=>n139);   -- ADC/adc_config.v(245)
    n140 <= not config_din_addr(1);   -- ADC/adc_config.v(253)
    reduce_nor_132: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>n140,a(0)=>config_din_addr(0),
            o=>n141);   -- ADC/adc_config.v(253)
    reduce_nor_135: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>n140,a(0)=>n138,o=>n144);   -- ADC/adc_config.v(257)
    n145 <= not config_din_addr(2);   -- ADC/adc_config.v(263)
    reduce_nor_137: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>n145,a(1)=>config_din_addr(1),a(0)=>config_din_addr(0),
            o=>n146);   -- ADC/adc_config.v(263)
    reduce_nor_140: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>n145,a(1)=>config_din_addr(1),a(0)=>n138,o=>n149);   -- ADC/adc_config.v(266)
    reduce_nor_143: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>n145,a(1)=>n140,a(0)=>config_din_addr(0),o=>n152);   -- ADC/adc_config.v(269)
    reduce_nor_147: entity work.reduce_nor_4(INTERFACE)  port map (a(3)=>config_din_addr(3),
            a(2)=>n145,a(1)=>n140,a(0)=>n138,o=>n156);   -- ADC/adc_config.v(272)
    reduce_nor_148: entity work.reduce_nor_8(INTERFACE)  port map (a(7)=>n137,
            a(6)=>n139,a(5)=>n141,a(4)=>n144,a(3)=>n146,a(2)=>n149,a(1)=>n152,
            a(0)=>n156,o=>n157);   -- ADC/adc_config.v(240)
    n158 <= config_din_data(0) when n137='1' else addr(5);   -- ADC/adc_config.v(240)
    n205 <= config_din_data(0) when n141='1' else idly_enable_r(0);   -- ADC/adc_config.v(240)
    n206 <= config_din_data(7) when n141='1' else idly_chan_sel_r(3);   -- ADC/adc_config.v(240)
    n207 <= config_din_data(6) when n141='1' else idly_chan_sel_r(2);   -- ADC/adc_config.v(240)
    n208 <= config_din_data(5) when n141='1' else idly_chan_sel_r(1);   -- ADC/adc_config.v(240)
    n209 <= config_din_data(4) when n141='1' else idly_chan_sel_r(0);   -- ADC/adc_config.v(240)
    n210 <= config_din_data(0) when n144='1' else addr(5);   -- ADC/adc_config.v(240)
    n211 <= config_din_data(4) when n144='1' else addr(5);   -- ADC/adc_config.v(240)
    n212 <= config_din_data(8) when n144='1' else addr(5);   -- ADC/adc_config.v(240)
    n213 <= config_din_data(12) when n144='1' else addr(5);   -- ADC/adc_config.v(240)
    n214 <= not n157;   -- ADC/adc_config.v(240)
    n215 <= config_din_addr(4) when n157='1' else addr(5);   -- ADC/adc_config.v(240)
    n216 <= n214 when n135='1' else addr(5);   -- ADC/adc_config.v(238)
    n217 <= n158 when n135='1' else addr(5);   -- ADC/adc_config.v(238)
    n242 <= n205 when n135='1' else idly_enable_r(0);   -- ADC/adc_config.v(238)
    n243 <= n206 when n135='1' else idly_chan_sel_r(3);   -- ADC/adc_config.v(238)
    n244 <= n207 when n135='1' else idly_chan_sel_r(2);   -- ADC/adc_config.v(238)
    n245 <= n208 when n135='1' else idly_chan_sel_r(1);   -- ADC/adc_config.v(238)
    n246 <= n209 when n135='1' else idly_chan_sel_r(0);   -- ADC/adc_config.v(238)
    n247 <= n210 when n135='1' else addr(5);   -- ADC/adc_config.v(238)
    n248 <= n211 when n135='1' else addr(5);   -- ADC/adc_config.v(238)
    n249 <= n212 when n135='1' else addr(5);   -- ADC/adc_config.v(238)
    n250 <= n213 when n135='1' else addr(5);   -- ADC/adc_config.v(238)
    n251 <= n215 when n135='1' else addr(5);   -- ADC/adc_config.v(238)
    n253 <= addr(5) when rst='1' else n242;   -- ADC/adc_config.v(217)
    n258 <= addr(5) when rst='1' else n243;   -- ADC/adc_config.v(217)
    n259 <= addr(5) when rst='1' else n244;   -- ADC/adc_config.v(217)
    n260 <= addr(5) when rst='1' else n245;   -- ADC/adc_config.v(217)
    n261 <= addr(5) when rst='1' else n246;   -- ADC/adc_config.v(217)
    n262 <= addr(5) when rst='1' else n217;   -- ADC/adc_config.v(217)
    n263 <= addr(5) when rst='1' else n247;   -- ADC/adc_config.v(217)
    n264 <= addr(5) when rst='1' else n248;   -- ADC/adc_config.v(217)
    n265 <= addr(5) when rst='1' else n249;   -- ADC/adc_config.v(217)
    n266 <= addr(5) when rst='1' else n250;   -- ADC/adc_config.v(217)
    n291 <= addr(5) when rst='1' else n216;   -- ADC/adc_config.v(217)
    n292 <= addr(5) when rst='1' else n251;   -- ADC/adc_config.v(217)
    i286: VERIFIC_DFFRS (d=>n253,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_enable_r(0));   -- ADC/adc_config.v(216)
    i291: VERIFIC_DFFRS (d=>n258,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_chan_sel_r(3));   -- ADC/adc_config.v(216)
    i292: VERIFIC_DFFRS (d=>n259,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_chan_sel_r(2));   -- ADC/adc_config.v(216)
    i293: VERIFIC_DFFRS (d=>n260,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_chan_sel_r(1));   -- ADC/adc_config.v(216)
    i294: VERIFIC_DFFRS (d=>n261,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_chan_sel_r(0));   -- ADC/adc_config.v(216)
    i295: VERIFIC_DFFRS (d=>n262,clk=>clk,s=>addr(5),r=>addr(5),q=>adc_sync_f);   -- ADC/adc_config.v(216)
    i297: VERIFIC_DFFRS (d=>n263,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_inc_f(0));   -- ADC/adc_config.v(216)
    i299: VERIFIC_DFFRS (d=>n264,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_dec_f(0));   -- ADC/adc_config.v(216)
    i301: VERIFIC_DFFRS (d=>n265,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_bitslip_f(0));   -- ADC/adc_config.v(216)
    i303: VERIFIC_DFFRS (d=>n266,clk=>clk,s=>addr(5),r=>addr(5),q=>idly_rst_f(0));   -- ADC/adc_config.v(216)
    i328: VERIFIC_DFFRS (d=>n291,clk=>clk,s=>addr(5),r=>addr(5),q=>reg_dout_valid_r);   -- ADC/adc_config.v(216)
    i329: VERIFIC_DFFRS (d=>n292,clk=>clk,s=>addr(5),r=>addr(5),q=>spi_tx_d_valid_r);   -- ADC/adc_config.v(216)
    \signal_idly_proc[0].signal_idly_enable\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>idly_enable_r(0),
            clkB=>adc_clkdiv(0),SignalOut_clkB=>idly_enable(0));   -- ADC/adc_config.v(320)
    \signal_idly_proc[0].signal_idly_chan_sel0\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>idly_chan_sel_r(0),
            clkB=>adc_clkdiv(0),SignalOut_clkB=>idly_chan_sel(0));   -- ADC/adc_config.v(325)
    \signal_idly_proc[0].signal_idly_chan_sel1\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>idly_chan_sel_r(1),
            clkB=>adc_clkdiv(0),SignalOut_clkB=>idly_chan_sel(1));   -- ADC/adc_config.v(330)
    \signal_idly_proc[0].signal_idly_chan_sel2\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>idly_chan_sel_r(2),
            clkB=>adc_clkdiv(0),SignalOut_clkB=>idly_chan_sel(2));   -- ADC/adc_config.v(335)
    \signal_idly_proc[0].signal_idly_chan_sel3\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>idly_chan_sel_r(3),
            clkB=>adc_clkdiv(0),SignalOut_clkB=>idly_chan_sel(3));   -- ADC/adc_config.v(340)
    \flag_idly_proc[0].flag_adc_sync\: entity work.Flag_CrossDomain(\.\)  port map (clkA=>clk,
            FlagIn_clkA=>n338,clkB=>adc_clkdiv(0),FlagOut_clkB=>adc_sync(0));   -- ADC/adc_config.v(350)
    n338 <= adc_sync_f or auto_config_sync_r;   -- ADC/adc_config.v(352)
    \flag_idly_proc[0].flag_idly_inc\: entity work.Flag_CrossDomain(\.\)  port map (clkA=>clk,
            FlagIn_clkA=>idly_inc_f(0),clkB=>adc_clkdiv(0),FlagOut_clkB=>idly_inc(0));   -- ADC/adc_config.v(356)
    \flag_idly_proc[0].flag_idly_dec\: entity work.Flag_CrossDomain(\.\)  port map (clkA=>clk,
            FlagIn_clkA=>idly_dec_f(0),clkB=>adc_clkdiv(0),FlagOut_clkB=>idly_dec(0));   -- ADC/adc_config.v(362)
    \flag_idly_proc[0].flag_idly_bitslip\: entity work.Flag_CrossDomain(\.\)  port map (clkA=>clk,
            FlagIn_clkA=>idly_bitslip_f(0),clkB=>adc_clkdiv(0),FlagOut_clkB=>idly_bitslip(0));   -- ADC/adc_config.v(368)
    \flag_idly_proc[0].flag_idly_rst\: entity work.Flag_CrossDomain(\.\)  port map (clkA=>clk,
            FlagIn_clkA=>idly_rst_f(0),clkB=>adc_clkdiv(0),FlagOut_clkB=>idly_rst(0));   -- ADC/adc_config.v(374)
    adc_spi: entity work.\SimpleSPIMaster(DLY_BEF_SCK=0,DLY_BET_CON_TRA=0,SPI_2X_CLK_DIV=10)\(\.\)  port map (clk=>clk,
            rst=>rst,din(15)=>spi_tx_d(23),din(14)=>spi_tx_d(22),din(13)=>spi_tx_d(21),
            din(12)=>spi_tx_d(20),din(11)=>spi_tx_d(19),din(10)=>spi_tx_d(18),
            din(9)=>spi_tx_d(17),din(8)=>spi_tx_d(16),din(7)=>spi_tx_d(15),
            din(6)=>spi_tx_d(14),din(5)=>spi_tx_d(13),din(4)=>spi_tx_d(12),
            din(3)=>spi_tx_d(11),din(2)=>spi_tx_d(10),din(1)=>spi_tx_d(9),
            din(0)=>spi_tx_d(8),wr=>spi_tx_d_valid_r,dout_valid=>spi_rx_d_valid,
            spi_cs=>adc_spi_csn,spi_sck=>adc_spi_ck,spi_mosi=>adc_spi_mosi,
            spi_miso=>adc_spi_miso);   -- ADC/adc_config.v(392)
    spi_tx_d(23) <= config_din_data(23) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(22) <= config_din_data(22) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(21) <= config_din_data(21) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(20) <= config_din_data(20) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(19) <= config_din_data(19) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(18) <= config_din_data(18) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(17) <= config_din_data(17) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(16) <= config_din_data(16) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(15) <= config_din_data(15) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(14) <= config_din_data(14) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(13) <= config_din_data(13) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(12) <= config_din_data(12) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(11) <= config_din_data(11) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(10) <= config_din_data(10) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(9) <= config_din_data(9) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    spi_tx_d(8) <= config_din_data(8) when spi_tx_d_valid_r='1' else addr(5);   -- ADC/adc_config.v(408)
    config_dout_valid <= spi_rx_d_valid or reg_dout_valid_r;   -- ADC/adc_config.v(414)
    
end architecture \.\;   -- ADC/adc_config.v(27)


--
-- Verific VHDL Description of module adc_top
--

library ieee ;
use ieee.std_logic_1164.all ;

entity adc_top is
    port (init_clk: in std_logic;   -- ADC/adc_top.v(30)
        init_rst: in std_logic;   -- ADC/adc_top.v(31)
        adc_config_done: out std_logic;   -- ADC/adc_top.v(32)
        config_din_valid: in std_logic;   -- ADC/adc_top.v(34)
        config_din_addr: in std_logic_vector(31 downto 0);   -- ADC/adc_top.v(35)
        config_din_data: in std_logic_vector(31 downto 0);   -- ADC/adc_top.v(36)
        config_dout_valid: out std_logic;   -- ADC/adc_top.v(38)
        config_dout_addr: out std_logic_vector(31 downto 0);   -- ADC/adc_top.v(39)
        config_dout_data: out std_logic_vector(31 downto 0);   -- ADC/adc_top.v(40)
        data_from_iserdes: out std_logic_vector(255 downto 0);   -- ADC/adc_top.v(42)
        adc_clkdiv: out std_logic_vector(1 downto 0);   -- ADC/adc_top.v(43)
        adc_sync_p: in std_logic_vector(1 downto 0);   -- ADC/adc_top.v(46)
        adc_sync_n: in std_logic_vector(1 downto 0);   -- ADC/adc_top.v(47)
        adc_in_p: in std_logic_vector(31 downto 0);   -- ADC/adc_top.v(48)
        adc_in_n: in std_logic_vector(31 downto 0);   -- ADC/adc_top.v(49)
        adc_dr_p: in std_logic_vector(1 downto 0);   -- ADC/adc_top.v(50)
        adc_dr_n: in std_logic_vector(1 downto 0);   -- ADC/adc_top.v(51)
        adc_spi_csn: out std_logic;   -- ADC/adc_top.v(52)
        adc_spi_sclk: out std_logic;   -- ADC/adc_top.v(53)
        adc_spi_mosi: out std_logic;   -- ADC/adc_top.v(54)
        adc_spi_miso: in std_logic   -- ADC/adc_top.v(55)
    );
    
end entity adc_top;   -- ADC/adc_top.v(25)

architecture \.\ of adc_top is 
    component \IBUFDS(DIFF_TERM="TRUE",IBUF_LOW_PWR="TRUE",IOSTANDARD="LVDS_25")\ is
        port (O: inout std_logic_vector(1 downto 0);
            I: inout std_logic;
            IB: inout std_logic
        );
        
    end component \IBUFDS(DIFF_TERM="TRUE",IBUF_LOW_PWR="TRUE",IOSTANDARD="LVDS_25")\;   -- ADC/adc_top.v(71)
    component \ddr_8to1_16chan_rx_gcu(USE_BUFIO=0,IDELAY_INITIAL_VALUE=0,N=0)\ is
        port (data_rx_p: inout std_logic_vector(15 downto 0);
            data_rx_n: inout std_logic_vector(15 downto 0);
            clock_rx_p: inout std_logic;
            clock_rx_n: inout std_logic;
            rxclk: inout std_logic;
            rxclkdiv: inout std_logic;
            rxrst: inout std_logic;
            manual_enable: inout std_logic;
            manual_chan_sel: inout std_logic_vector(3 downto 0);
            manual_inc: inout std_logic;
            manual_dec: inout std_logic;
            manual_bitslip: inout std_logic;
            manual_idly_rst: inout std_logic;
            training_start: inout std_logic;
            training_done: inout std_logic;
            tap: inout std_logic_vector(79 downto 0);
            rxdataisgood: inout std_logic;
            data_from_iserdes_r: inout std_logic_vector(127 downto 0)
        );
        
    end component \ddr_8to1_16chan_rx_gcu(USE_BUFIO=0,IDELAY_INITIAL_VALUE=0,N=0)\;   -- ADC/adc_top.v(98)
    signal data_from_iserdes_c : std_logic_vector(255 downto 0);   -- ADC/adc_top.v(42)
    signal adc_clkdiv_c : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(43)
    signal adc_sync_p_c : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(46)
    signal adc_sync_n_c : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(47)
    signal adc_in_p_c : std_logic_vector(31 downto 0);   -- ADC/adc_top.v(48)
    signal adc_in_n_c : std_logic_vector(31 downto 0);   -- ADC/adc_top.v(49)
    signal adc_dr_p_c : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(50)
    signal adc_dr_n_c : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(51)
    signal adc_manual_enable : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(61)
    signal adc_manual_inc : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(61)
    signal adc_manual_dec : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(61)
    signal adc_manual_bitslip : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(61)
    signal adc_manual_idly_rst : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(61)
    signal adc_manual_chan_sel : std_logic_vector(7 downto 0);   -- ADC/adc_top.v(62)
    signal training_start : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(63)
    signal training_done : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(63)
    signal tap : std_logic_vector(159 downto 0);   -- ADC/adc_top.v(64)
    signal rxdataisgood : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(65)
    signal adc_sync_in : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(66)
    signal adc_rst : std_logic_vector(1 downto 0);   -- ADC/adc_top.v(67)
    signal OPEN_net : std_logic_vector(0 to 10);
    
begin
    data_from_iserdes(127) <= data_from_iserdes_c(127);   -- ADC/adc_top.v(42)
    data_from_iserdes(126) <= data_from_iserdes_c(126);   -- ADC/adc_top.v(42)
    data_from_iserdes(125) <= data_from_iserdes_c(125);   -- ADC/adc_top.v(42)
    data_from_iserdes(124) <= data_from_iserdes_c(124);   -- ADC/adc_top.v(42)
    data_from_iserdes(123) <= data_from_iserdes_c(123);   -- ADC/adc_top.v(42)
    data_from_iserdes(122) <= data_from_iserdes_c(122);   -- ADC/adc_top.v(42)
    data_from_iserdes(121) <= data_from_iserdes_c(121);   -- ADC/adc_top.v(42)
    data_from_iserdes(120) <= data_from_iserdes_c(120);   -- ADC/adc_top.v(42)
    data_from_iserdes(119) <= data_from_iserdes_c(119);   -- ADC/adc_top.v(42)
    data_from_iserdes(118) <= data_from_iserdes_c(118);   -- ADC/adc_top.v(42)
    data_from_iserdes(117) <= data_from_iserdes_c(117);   -- ADC/adc_top.v(42)
    data_from_iserdes(116) <= data_from_iserdes_c(116);   -- ADC/adc_top.v(42)
    data_from_iserdes(115) <= data_from_iserdes_c(115);   -- ADC/adc_top.v(42)
    data_from_iserdes(114) <= data_from_iserdes_c(114);   -- ADC/adc_top.v(42)
    data_from_iserdes(113) <= data_from_iserdes_c(113);   -- ADC/adc_top.v(42)
    data_from_iserdes(112) <= data_from_iserdes_c(112);   -- ADC/adc_top.v(42)
    data_from_iserdes(111) <= data_from_iserdes_c(111);   -- ADC/adc_top.v(42)
    data_from_iserdes(110) <= data_from_iserdes_c(110);   -- ADC/adc_top.v(42)
    data_from_iserdes(109) <= data_from_iserdes_c(109);   -- ADC/adc_top.v(42)
    data_from_iserdes(108) <= data_from_iserdes_c(108);   -- ADC/adc_top.v(42)
    data_from_iserdes(107) <= data_from_iserdes_c(107);   -- ADC/adc_top.v(42)
    data_from_iserdes(106) <= data_from_iserdes_c(106);   -- ADC/adc_top.v(42)
    data_from_iserdes(105) <= data_from_iserdes_c(105);   -- ADC/adc_top.v(42)
    data_from_iserdes(104) <= data_from_iserdes_c(104);   -- ADC/adc_top.v(42)
    data_from_iserdes(103) <= data_from_iserdes_c(103);   -- ADC/adc_top.v(42)
    data_from_iserdes(102) <= data_from_iserdes_c(102);   -- ADC/adc_top.v(42)
    data_from_iserdes(101) <= data_from_iserdes_c(101);   -- ADC/adc_top.v(42)
    data_from_iserdes(100) <= data_from_iserdes_c(100);   -- ADC/adc_top.v(42)
    data_from_iserdes(99) <= data_from_iserdes_c(99);   -- ADC/adc_top.v(42)
    data_from_iserdes(98) <= data_from_iserdes_c(98);   -- ADC/adc_top.v(42)
    data_from_iserdes(97) <= data_from_iserdes_c(97);   -- ADC/adc_top.v(42)
    data_from_iserdes(96) <= data_from_iserdes_c(96);   -- ADC/adc_top.v(42)
    data_from_iserdes(95) <= data_from_iserdes_c(95);   -- ADC/adc_top.v(42)
    data_from_iserdes(94) <= data_from_iserdes_c(94);   -- ADC/adc_top.v(42)
    data_from_iserdes(93) <= data_from_iserdes_c(93);   -- ADC/adc_top.v(42)
    data_from_iserdes(92) <= data_from_iserdes_c(92);   -- ADC/adc_top.v(42)
    data_from_iserdes(91) <= data_from_iserdes_c(91);   -- ADC/adc_top.v(42)
    data_from_iserdes(90) <= data_from_iserdes_c(90);   -- ADC/adc_top.v(42)
    data_from_iserdes(89) <= data_from_iserdes_c(89);   -- ADC/adc_top.v(42)
    data_from_iserdes(88) <= data_from_iserdes_c(88);   -- ADC/adc_top.v(42)
    data_from_iserdes(87) <= data_from_iserdes_c(87);   -- ADC/adc_top.v(42)
    data_from_iserdes(86) <= data_from_iserdes_c(86);   -- ADC/adc_top.v(42)
    data_from_iserdes(85) <= data_from_iserdes_c(85);   -- ADC/adc_top.v(42)
    data_from_iserdes(84) <= data_from_iserdes_c(84);   -- ADC/adc_top.v(42)
    data_from_iserdes(83) <= data_from_iserdes_c(83);   -- ADC/adc_top.v(42)
    data_from_iserdes(82) <= data_from_iserdes_c(82);   -- ADC/adc_top.v(42)
    data_from_iserdes(81) <= data_from_iserdes_c(81);   -- ADC/adc_top.v(42)
    data_from_iserdes(80) <= data_from_iserdes_c(80);   -- ADC/adc_top.v(42)
    data_from_iserdes(79) <= data_from_iserdes_c(79);   -- ADC/adc_top.v(42)
    data_from_iserdes(78) <= data_from_iserdes_c(78);   -- ADC/adc_top.v(42)
    data_from_iserdes(77) <= data_from_iserdes_c(77);   -- ADC/adc_top.v(42)
    data_from_iserdes(76) <= data_from_iserdes_c(76);   -- ADC/adc_top.v(42)
    data_from_iserdes(75) <= data_from_iserdes_c(75);   -- ADC/adc_top.v(42)
    data_from_iserdes(74) <= data_from_iserdes_c(74);   -- ADC/adc_top.v(42)
    data_from_iserdes(73) <= data_from_iserdes_c(73);   -- ADC/adc_top.v(42)
    data_from_iserdes(72) <= data_from_iserdes_c(72);   -- ADC/adc_top.v(42)
    data_from_iserdes(71) <= data_from_iserdes_c(71);   -- ADC/adc_top.v(42)
    data_from_iserdes(70) <= data_from_iserdes_c(70);   -- ADC/adc_top.v(42)
    data_from_iserdes(69) <= data_from_iserdes_c(69);   -- ADC/adc_top.v(42)
    data_from_iserdes(68) <= data_from_iserdes_c(68);   -- ADC/adc_top.v(42)
    data_from_iserdes(67) <= data_from_iserdes_c(67);   -- ADC/adc_top.v(42)
    data_from_iserdes(66) <= data_from_iserdes_c(66);   -- ADC/adc_top.v(42)
    data_from_iserdes(65) <= data_from_iserdes_c(65);   -- ADC/adc_top.v(42)
    data_from_iserdes(64) <= data_from_iserdes_c(64);   -- ADC/adc_top.v(42)
    data_from_iserdes(63) <= data_from_iserdes_c(63);   -- ADC/adc_top.v(42)
    data_from_iserdes(62) <= data_from_iserdes_c(62);   -- ADC/adc_top.v(42)
    data_from_iserdes(61) <= data_from_iserdes_c(61);   -- ADC/adc_top.v(42)
    data_from_iserdes(60) <= data_from_iserdes_c(60);   -- ADC/adc_top.v(42)
    data_from_iserdes(59) <= data_from_iserdes_c(59);   -- ADC/adc_top.v(42)
    data_from_iserdes(58) <= data_from_iserdes_c(58);   -- ADC/adc_top.v(42)
    data_from_iserdes(57) <= data_from_iserdes_c(57);   -- ADC/adc_top.v(42)
    data_from_iserdes(56) <= data_from_iserdes_c(56);   -- ADC/adc_top.v(42)
    data_from_iserdes(55) <= data_from_iserdes_c(55);   -- ADC/adc_top.v(42)
    data_from_iserdes(54) <= data_from_iserdes_c(54);   -- ADC/adc_top.v(42)
    data_from_iserdes(53) <= data_from_iserdes_c(53);   -- ADC/adc_top.v(42)
    data_from_iserdes(52) <= data_from_iserdes_c(52);   -- ADC/adc_top.v(42)
    data_from_iserdes(51) <= data_from_iserdes_c(51);   -- ADC/adc_top.v(42)
    data_from_iserdes(50) <= data_from_iserdes_c(50);   -- ADC/adc_top.v(42)
    data_from_iserdes(49) <= data_from_iserdes_c(49);   -- ADC/adc_top.v(42)
    data_from_iserdes(48) <= data_from_iserdes_c(48);   -- ADC/adc_top.v(42)
    data_from_iserdes(47) <= data_from_iserdes_c(47);   -- ADC/adc_top.v(42)
    data_from_iserdes(46) <= data_from_iserdes_c(46);   -- ADC/adc_top.v(42)
    data_from_iserdes(45) <= data_from_iserdes_c(45);   -- ADC/adc_top.v(42)
    data_from_iserdes(44) <= data_from_iserdes_c(44);   -- ADC/adc_top.v(42)
    data_from_iserdes(43) <= data_from_iserdes_c(43);   -- ADC/adc_top.v(42)
    data_from_iserdes(42) <= data_from_iserdes_c(42);   -- ADC/adc_top.v(42)
    data_from_iserdes(41) <= data_from_iserdes_c(41);   -- ADC/adc_top.v(42)
    data_from_iserdes(40) <= data_from_iserdes_c(40);   -- ADC/adc_top.v(42)
    data_from_iserdes(39) <= data_from_iserdes_c(39);   -- ADC/adc_top.v(42)
    data_from_iserdes(38) <= data_from_iserdes_c(38);   -- ADC/adc_top.v(42)
    data_from_iserdes(37) <= data_from_iserdes_c(37);   -- ADC/adc_top.v(42)
    data_from_iserdes(36) <= data_from_iserdes_c(36);   -- ADC/adc_top.v(42)
    data_from_iserdes(35) <= data_from_iserdes_c(35);   -- ADC/adc_top.v(42)
    data_from_iserdes(34) <= data_from_iserdes_c(34);   -- ADC/adc_top.v(42)
    data_from_iserdes(33) <= data_from_iserdes_c(33);   -- ADC/adc_top.v(42)
    data_from_iserdes(32) <= data_from_iserdes_c(32);   -- ADC/adc_top.v(42)
    data_from_iserdes(31) <= data_from_iserdes_c(31);   -- ADC/adc_top.v(42)
    data_from_iserdes(30) <= data_from_iserdes_c(30);   -- ADC/adc_top.v(42)
    data_from_iserdes(29) <= data_from_iserdes_c(29);   -- ADC/adc_top.v(42)
    data_from_iserdes(28) <= data_from_iserdes_c(28);   -- ADC/adc_top.v(42)
    data_from_iserdes(27) <= data_from_iserdes_c(27);   -- ADC/adc_top.v(42)
    data_from_iserdes(26) <= data_from_iserdes_c(26);   -- ADC/adc_top.v(42)
    data_from_iserdes(25) <= data_from_iserdes_c(25);   -- ADC/adc_top.v(42)
    data_from_iserdes(24) <= data_from_iserdes_c(24);   -- ADC/adc_top.v(42)
    data_from_iserdes(23) <= data_from_iserdes_c(23);   -- ADC/adc_top.v(42)
    data_from_iserdes(22) <= data_from_iserdes_c(22);   -- ADC/adc_top.v(42)
    data_from_iserdes(21) <= data_from_iserdes_c(21);   -- ADC/adc_top.v(42)
    data_from_iserdes(20) <= data_from_iserdes_c(20);   -- ADC/adc_top.v(42)
    data_from_iserdes(19) <= data_from_iserdes_c(19);   -- ADC/adc_top.v(42)
    data_from_iserdes(18) <= data_from_iserdes_c(18);   -- ADC/adc_top.v(42)
    data_from_iserdes(17) <= data_from_iserdes_c(17);   -- ADC/adc_top.v(42)
    data_from_iserdes(16) <= data_from_iserdes_c(16);   -- ADC/adc_top.v(42)
    data_from_iserdes(15) <= data_from_iserdes_c(15);   -- ADC/adc_top.v(42)
    data_from_iserdes(14) <= data_from_iserdes_c(14);   -- ADC/adc_top.v(42)
    data_from_iserdes(13) <= data_from_iserdes_c(13);   -- ADC/adc_top.v(42)
    data_from_iserdes(12) <= data_from_iserdes_c(12);   -- ADC/adc_top.v(42)
    data_from_iserdes(11) <= data_from_iserdes_c(11);   -- ADC/adc_top.v(42)
    data_from_iserdes(10) <= data_from_iserdes_c(10);   -- ADC/adc_top.v(42)
    data_from_iserdes(9) <= data_from_iserdes_c(9);   -- ADC/adc_top.v(42)
    data_from_iserdes(8) <= data_from_iserdes_c(8);   -- ADC/adc_top.v(42)
    data_from_iserdes(7) <= data_from_iserdes_c(7);   -- ADC/adc_top.v(42)
    data_from_iserdes(6) <= data_from_iserdes_c(6);   -- ADC/adc_top.v(42)
    data_from_iserdes(5) <= data_from_iserdes_c(5);   -- ADC/adc_top.v(42)
    data_from_iserdes(4) <= data_from_iserdes_c(4);   -- ADC/adc_top.v(42)
    data_from_iserdes(3) <= data_from_iserdes_c(3);   -- ADC/adc_top.v(42)
    data_from_iserdes(2) <= data_from_iserdes_c(2);   -- ADC/adc_top.v(42)
    data_from_iserdes(1) <= data_from_iserdes_c(1);   -- ADC/adc_top.v(42)
    data_from_iserdes(0) <= data_from_iserdes_c(0);   -- ADC/adc_top.v(42)
    adc_clkdiv(1) <= adc_clkdiv_c(1);   -- ADC/adc_top.v(43)
    adc_clkdiv(0) <= adc_clkdiv_c(0);   -- ADC/adc_top.v(43)
    adc_sync_p_c(0) <= adc_sync_p(0);   -- ADC/adc_top.v(46)
    adc_sync_n_c(0) <= adc_sync_n(0);   -- ADC/adc_top.v(47)
    adc_in_p_c(15) <= adc_in_p(15);   -- ADC/adc_top.v(48)
    adc_in_p_c(14) <= adc_in_p(14);   -- ADC/adc_top.v(48)
    adc_in_p_c(13) <= adc_in_p(13);   -- ADC/adc_top.v(48)
    adc_in_p_c(12) <= adc_in_p(12);   -- ADC/adc_top.v(48)
    adc_in_p_c(11) <= adc_in_p(11);   -- ADC/adc_top.v(48)
    adc_in_p_c(10) <= adc_in_p(10);   -- ADC/adc_top.v(48)
    adc_in_p_c(9) <= adc_in_p(9);   -- ADC/adc_top.v(48)
    adc_in_p_c(8) <= adc_in_p(8);   -- ADC/adc_top.v(48)
    adc_in_p_c(7) <= adc_in_p(7);   -- ADC/adc_top.v(48)
    adc_in_p_c(6) <= adc_in_p(6);   -- ADC/adc_top.v(48)
    adc_in_p_c(5) <= adc_in_p(5);   -- ADC/adc_top.v(48)
    adc_in_p_c(4) <= adc_in_p(4);   -- ADC/adc_top.v(48)
    adc_in_p_c(3) <= adc_in_p(3);   -- ADC/adc_top.v(48)
    adc_in_p_c(2) <= adc_in_p(2);   -- ADC/adc_top.v(48)
    adc_in_p_c(1) <= adc_in_p(1);   -- ADC/adc_top.v(48)
    adc_in_p_c(0) <= adc_in_p(0);   -- ADC/adc_top.v(48)
    adc_in_n_c(15) <= adc_in_n(15);   -- ADC/adc_top.v(49)
    adc_in_n_c(14) <= adc_in_n(14);   -- ADC/adc_top.v(49)
    adc_in_n_c(13) <= adc_in_n(13);   -- ADC/adc_top.v(49)
    adc_in_n_c(12) <= adc_in_n(12);   -- ADC/adc_top.v(49)
    adc_in_n_c(11) <= adc_in_n(11);   -- ADC/adc_top.v(49)
    adc_in_n_c(10) <= adc_in_n(10);   -- ADC/adc_top.v(49)
    adc_in_n_c(9) <= adc_in_n(9);   -- ADC/adc_top.v(49)
    adc_in_n_c(8) <= adc_in_n(8);   -- ADC/adc_top.v(49)
    adc_in_n_c(7) <= adc_in_n(7);   -- ADC/adc_top.v(49)
    adc_in_n_c(6) <= adc_in_n(6);   -- ADC/adc_top.v(49)
    adc_in_n_c(5) <= adc_in_n(5);   -- ADC/adc_top.v(49)
    adc_in_n_c(4) <= adc_in_n(4);   -- ADC/adc_top.v(49)
    adc_in_n_c(3) <= adc_in_n(3);   -- ADC/adc_top.v(49)
    adc_in_n_c(2) <= adc_in_n(2);   -- ADC/adc_top.v(49)
    adc_in_n_c(1) <= adc_in_n(1);   -- ADC/adc_top.v(49)
    adc_in_n_c(0) <= adc_in_n(0);   -- ADC/adc_top.v(49)
    adc_dr_p_c(0) <= adc_dr_p(0);   -- ADC/adc_top.v(50)
    adc_dr_n_c(0) <= adc_dr_n(0);   -- ADC/adc_top.v(51)
    training_done(1) <= '1' ;
    \ddr_8to1_16chan_rx_proc[0].IBUFDS_inst\: component \IBUFDS(DIFF_TERM="TRUE",IBUF_LOW_PWR="TRUE",IOSTANDARD="LVDS_25")\ port map (O(1)=>adc_sync_in(1),
            O(0)=>adc_sync_in(0),I=>adc_sync_p_c(0),IB=>adc_sync_n_c(0));   -- ADC/adc_top.v(75)
    \ddr_8to1_16chan_rx_proc[0].signal_rx_rst\: entity work.Signal_CrossDomain(\.\)  port map (SignalIn_clkA=>init_rst,
            clkB=>adc_clkdiv_c(0),SignalOut_clkB=>adc_rst(0));   -- ADC/adc_top.v(92)
    \ddr_8to1_16chan_rx_proc[0].chan_rx\: component \ddr_8to1_16chan_rx_gcu(USE_BUFIO=0,IDELAY_INITIAL_VALUE=0,N=0)\ port map (data_rx_p(15)=>adc_in_p_c(15),
            data_rx_p(14)=>adc_in_p_c(14),data_rx_p(13)=>adc_in_p_c(13),data_rx_p(12)=>adc_in_p_c(12),
            data_rx_p(11)=>adc_in_p_c(11),data_rx_p(10)=>adc_in_p_c(10),data_rx_p(9)=>adc_in_p_c(9),
            data_rx_p(8)=>adc_in_p_c(8),data_rx_p(7)=>adc_in_p_c(7),data_rx_p(6)=>adc_in_p_c(6),
            data_rx_p(5)=>adc_in_p_c(5),data_rx_p(4)=>adc_in_p_c(4),data_rx_p(3)=>adc_in_p_c(3),
            data_rx_p(2)=>adc_in_p_c(2),data_rx_p(1)=>adc_in_p_c(1),data_rx_p(0)=>adc_in_p_c(0),
            data_rx_n(15)=>adc_in_n_c(15),data_rx_n(14)=>adc_in_n_c(14),data_rx_n(13)=>adc_in_n_c(13),
            data_rx_n(12)=>adc_in_n_c(12),data_rx_n(11)=>adc_in_n_c(11),data_rx_n(10)=>adc_in_n_c(10),
            data_rx_n(9)=>adc_in_n_c(9),data_rx_n(8)=>adc_in_n_c(8),data_rx_n(7)=>adc_in_n_c(7),
            data_rx_n(6)=>adc_in_n_c(6),data_rx_n(5)=>adc_in_n_c(5),data_rx_n(4)=>adc_in_n_c(4),
            data_rx_n(3)=>adc_in_n_c(3),data_rx_n(2)=>adc_in_n_c(2),data_rx_n(1)=>adc_in_n_c(1),
            data_rx_n(0)=>adc_in_n_c(0),clock_rx_p=>adc_dr_p_c(0),clock_rx_n=>adc_dr_n_c(0),
            rxclkdiv=>adc_clkdiv_c(0),rxrst=>adc_rst(0),manual_enable=>adc_manual_enable(0),
            manual_chan_sel(3)=>adc_manual_chan_sel(3),manual_chan_sel(2)=>adc_manual_chan_sel(2),
            manual_chan_sel(1)=>adc_manual_chan_sel(1),manual_chan_sel(0)=>adc_manual_chan_sel(0),
            manual_inc=>adc_manual_inc(0),manual_dec=>adc_manual_dec(0),manual_bitslip=>adc_manual_bitslip(0),
            manual_idly_rst=>adc_manual_idly_rst(0),training_start=>training_start(0),
            training_done=>training_done(0),tap(79)=>tap(79),tap(78)=>tap(78),
            tap(77)=>tap(77),tap(76)=>tap(76),tap(75)=>tap(75),tap(74)=>tap(74),
            tap(73)=>tap(73),tap(72)=>tap(72),tap(71)=>tap(71),tap(70)=>tap(70),
            tap(69)=>tap(69),tap(68)=>tap(68),tap(67)=>tap(67),tap(66)=>tap(66),
            tap(65)=>tap(65),tap(64)=>tap(64),tap(63)=>tap(63),tap(62)=>tap(62),
            tap(61)=>tap(61),tap(60)=>tap(60),tap(59)=>tap(59),tap(58)=>tap(58),
            tap(57)=>tap(57),tap(56)=>tap(56),tap(55)=>tap(55),tap(54)=>tap(54),
            tap(53)=>tap(53),tap(52)=>tap(52),tap(51)=>tap(51),tap(50)=>tap(50),
            tap(49)=>tap(49),tap(48)=>tap(48),tap(47)=>tap(47),tap(46)=>tap(46),
            tap(45)=>tap(45),tap(44)=>tap(44),tap(43)=>tap(43),tap(42)=>tap(42),
            tap(41)=>tap(41),tap(40)=>tap(40),tap(39)=>tap(39),tap(38)=>tap(38),
            tap(37)=>tap(37),tap(36)=>tap(36),tap(35)=>tap(35),tap(34)=>tap(34),
            tap(33)=>tap(33),tap(32)=>tap(32),tap(31)=>tap(31),tap(30)=>tap(30),
            tap(29)=>tap(29),tap(28)=>tap(28),tap(27)=>tap(27),tap(26)=>tap(26),
            tap(25)=>tap(25),tap(24)=>tap(24),tap(23)=>tap(23),tap(22)=>tap(22),
            tap(21)=>tap(21),tap(20)=>tap(20),tap(19)=>tap(19),tap(18)=>tap(18),
            tap(17)=>tap(17),tap(16)=>tap(16),tap(15)=>tap(15),tap(14)=>tap(14),
            tap(13)=>tap(13),tap(12)=>tap(12),tap(11)=>tap(11),tap(10)=>tap(10),
            tap(9)=>tap(9),tap(8)=>tap(8),tap(7)=>tap(7),tap(6)=>tap(6),
            tap(5)=>tap(5),tap(4)=>tap(4),tap(3)=>tap(3),tap(2)=>tap(2),
            tap(1)=>tap(1),tap(0)=>tap(0),rxdataisgood=>rxdataisgood(0),data_from_iserdes_r(127)=>data_from_iserdes_c(127),
            data_from_iserdes_r(126)=>data_from_iserdes_c(126),data_from_iserdes_r(125)=>data_from_iserdes_c(125),
            data_from_iserdes_r(124)=>data_from_iserdes_c(124),data_from_iserdes_r(123)=>data_from_iserdes_c(123),
            data_from_iserdes_r(122)=>data_from_iserdes_c(122),data_from_iserdes_r(121)=>data_from_iserdes_c(121),
            data_from_iserdes_r(120)=>data_from_iserdes_c(120),data_from_iserdes_r(119)=>data_from_iserdes_c(119),
            data_from_iserdes_r(118)=>data_from_iserdes_c(118),data_from_iserdes_r(117)=>data_from_iserdes_c(117),
            data_from_iserdes_r(116)=>data_from_iserdes_c(116),data_from_iserdes_r(115)=>data_from_iserdes_c(115),
            data_from_iserdes_r(114)=>data_from_iserdes_c(114),data_from_iserdes_r(113)=>data_from_iserdes_c(113),
            data_from_iserdes_r(112)=>data_from_iserdes_c(112),data_from_iserdes_r(111)=>data_from_iserdes_c(111),
            data_from_iserdes_r(110)=>data_from_iserdes_c(110),data_from_iserdes_r(109)=>data_from_iserdes_c(109),
            data_from_iserdes_r(108)=>data_from_iserdes_c(108),data_from_iserdes_r(107)=>data_from_iserdes_c(107),
            data_from_iserdes_r(106)=>data_from_iserdes_c(106),data_from_iserdes_r(105)=>data_from_iserdes_c(105),
            data_from_iserdes_r(104)=>data_from_iserdes_c(104),data_from_iserdes_r(103)=>data_from_iserdes_c(103),
            data_from_iserdes_r(102)=>data_from_iserdes_c(102),data_from_iserdes_r(101)=>data_from_iserdes_c(101),
            data_from_iserdes_r(100)=>data_from_iserdes_c(100),data_from_iserdes_r(99)=>data_from_iserdes_c(99),
            data_from_iserdes_r(98)=>data_from_iserdes_c(98),data_from_iserdes_r(97)=>data_from_iserdes_c(97),
            data_from_iserdes_r(96)=>data_from_iserdes_c(96),data_from_iserdes_r(95)=>data_from_iserdes_c(95),
            data_from_iserdes_r(94)=>data_from_iserdes_c(94),data_from_iserdes_r(93)=>data_from_iserdes_c(93),
            data_from_iserdes_r(92)=>data_from_iserdes_c(92),data_from_iserdes_r(91)=>data_from_iserdes_c(91),
            data_from_iserdes_r(90)=>data_from_iserdes_c(90),data_from_iserdes_r(89)=>data_from_iserdes_c(89),
            data_from_iserdes_r(88)=>data_from_iserdes_c(88),data_from_iserdes_r(87)=>data_from_iserdes_c(87),
            data_from_iserdes_r(86)=>data_from_iserdes_c(86),data_from_iserdes_r(85)=>data_from_iserdes_c(85),
            data_from_iserdes_r(84)=>data_from_iserdes_c(84),data_from_iserdes_r(83)=>data_from_iserdes_c(83),
            data_from_iserdes_r(82)=>data_from_iserdes_c(82),data_from_iserdes_r(81)=>data_from_iserdes_c(81),
            data_from_iserdes_r(80)=>data_from_iserdes_c(80),data_from_iserdes_r(79)=>data_from_iserdes_c(79),
            data_from_iserdes_r(78)=>data_from_iserdes_c(78),data_from_iserdes_r(77)=>data_from_iserdes_c(77),
            data_from_iserdes_r(76)=>data_from_iserdes_c(76),data_from_iserdes_r(75)=>data_from_iserdes_c(75),
            data_from_iserdes_r(74)=>data_from_iserdes_c(74),data_from_iserdes_r(73)=>data_from_iserdes_c(73),
            data_from_iserdes_r(72)=>data_from_iserdes_c(72),data_from_iserdes_r(71)=>data_from_iserdes_c(71),
            data_from_iserdes_r(70)=>data_from_iserdes_c(70),data_from_iserdes_r(69)=>data_from_iserdes_c(69),
            data_from_iserdes_r(68)=>data_from_iserdes_c(68),data_from_iserdes_r(67)=>data_from_iserdes_c(67),
            data_from_iserdes_r(66)=>data_from_iserdes_c(66),data_from_iserdes_r(65)=>data_from_iserdes_c(65),
            data_from_iserdes_r(64)=>data_from_iserdes_c(64),data_from_iserdes_r(63)=>data_from_iserdes_c(63),
            data_from_iserdes_r(62)=>data_from_iserdes_c(62),data_from_iserdes_r(61)=>data_from_iserdes_c(61),
            data_from_iserdes_r(60)=>data_from_iserdes_c(60),data_from_iserdes_r(59)=>data_from_iserdes_c(59),
            data_from_iserdes_r(58)=>data_from_iserdes_c(58),data_from_iserdes_r(57)=>data_from_iserdes_c(57),
            data_from_iserdes_r(56)=>data_from_iserdes_c(56),data_from_iserdes_r(55)=>data_from_iserdes_c(55),
            data_from_iserdes_r(54)=>data_from_iserdes_c(54),data_from_iserdes_r(53)=>data_from_iserdes_c(53),
            data_from_iserdes_r(52)=>data_from_iserdes_c(52),data_from_iserdes_r(51)=>data_from_iserdes_c(51),
            data_from_iserdes_r(50)=>data_from_iserdes_c(50),data_from_iserdes_r(49)=>data_from_iserdes_c(49),
            data_from_iserdes_r(48)=>data_from_iserdes_c(48),data_from_iserdes_r(47)=>data_from_iserdes_c(47),
            data_from_iserdes_r(46)=>data_from_iserdes_c(46),data_from_iserdes_r(45)=>data_from_iserdes_c(45),
            data_from_iserdes_r(44)=>data_from_iserdes_c(44),data_from_iserdes_r(43)=>data_from_iserdes_c(43),
            data_from_iserdes_r(42)=>data_from_iserdes_c(42),data_from_iserdes_r(41)=>data_from_iserdes_c(41),
            data_from_iserdes_r(40)=>data_from_iserdes_c(40),data_from_iserdes_r(39)=>data_from_iserdes_c(39),
            data_from_iserdes_r(38)=>data_from_iserdes_c(38),data_from_iserdes_r(37)=>data_from_iserdes_c(37),
            data_from_iserdes_r(36)=>data_from_iserdes_c(36),data_from_iserdes_r(35)=>data_from_iserdes_c(35),
            data_from_iserdes_r(34)=>data_from_iserdes_c(34),data_from_iserdes_r(33)=>data_from_iserdes_c(33),
            data_from_iserdes_r(32)=>data_from_iserdes_c(32),data_from_iserdes_r(31)=>data_from_iserdes_c(31),
            data_from_iserdes_r(30)=>data_from_iserdes_c(30),data_from_iserdes_r(29)=>data_from_iserdes_c(29),
            data_from_iserdes_r(28)=>data_from_iserdes_c(28),data_from_iserdes_r(27)=>data_from_iserdes_c(27),
            data_from_iserdes_r(26)=>data_from_iserdes_c(26),data_from_iserdes_r(25)=>data_from_iserdes_c(25),
            data_from_iserdes_r(24)=>data_from_iserdes_c(24),data_from_iserdes_r(23)=>data_from_iserdes_c(23),
            data_from_iserdes_r(22)=>data_from_iserdes_c(22),data_from_iserdes_r(21)=>data_from_iserdes_c(21),
            data_from_iserdes_r(20)=>data_from_iserdes_c(20),data_from_iserdes_r(19)=>data_from_iserdes_c(19),
            data_from_iserdes_r(18)=>data_from_iserdes_c(18),data_from_iserdes_r(17)=>data_from_iserdes_c(17),
            data_from_iserdes_r(16)=>data_from_iserdes_c(16),data_from_iserdes_r(15)=>data_from_iserdes_c(15),
            data_from_iserdes_r(14)=>data_from_iserdes_c(14),data_from_iserdes_r(13)=>data_from_iserdes_c(13),
            data_from_iserdes_r(12)=>data_from_iserdes_c(12),data_from_iserdes_r(11)=>data_from_iserdes_c(11),
            data_from_iserdes_r(10)=>data_from_iserdes_c(10),data_from_iserdes_r(9)=>data_from_iserdes_c(9),
            data_from_iserdes_r(8)=>data_from_iserdes_c(8),data_from_iserdes_r(7)=>data_from_iserdes_c(7),
            data_from_iserdes_r(6)=>data_from_iserdes_c(6),data_from_iserdes_r(5)=>data_from_iserdes_c(5),
            data_from_iserdes_r(4)=>data_from_iserdes_c(4),data_from_iserdes_r(3)=>data_from_iserdes_c(3),
            data_from_iserdes_r(2)=>data_from_iserdes_c(2),data_from_iserdes_r(1)=>data_from_iserdes_c(1),
            data_from_iserdes_r(0)=>data_from_iserdes_c(0));   -- ADC/adc_top.v(102)
    adc_config_i: entity work.adc_config(\.\)  port map (clk=>init_clk,rst=>init_rst,
            config_done=>adc_config_done,config_din_valid=>config_din_valid,
            config_din_addr(31)=>config_din_addr(31),config_din_addr(30)=>config_din_addr(30),
            config_din_addr(29)=>config_din_addr(29),config_din_addr(28)=>config_din_addr(28),
            config_din_addr(27)=>config_din_addr(27),config_din_addr(26)=>config_din_addr(26),
            config_din_addr(25)=>config_din_addr(25),config_din_addr(24)=>config_din_addr(24),
            config_din_addr(23)=>config_din_addr(23),config_din_addr(22)=>config_din_addr(22),
            config_din_addr(21)=>config_din_addr(21),config_din_addr(20)=>config_din_addr(20),
            config_din_addr(19)=>config_din_addr(19),config_din_addr(18)=>config_din_addr(18),
            config_din_addr(17)=>config_din_addr(17),config_din_addr(16)=>config_din_addr(16),
            config_din_addr(15)=>config_din_addr(15),config_din_addr(14)=>config_din_addr(14),
            config_din_addr(13)=>config_din_addr(13),config_din_addr(12)=>config_din_addr(12),
            config_din_addr(11)=>config_din_addr(11),config_din_addr(10)=>config_din_addr(10),
            config_din_addr(9)=>config_din_addr(9),config_din_addr(8)=>config_din_addr(8),
            config_din_addr(7)=>config_din_addr(7),config_din_addr(6)=>config_din_addr(6),
            config_din_addr(5)=>config_din_addr(5),config_din_addr(4)=>config_din_addr(4),
            config_din_addr(3)=>config_din_addr(3),config_din_addr(2)=>config_din_addr(2),
            config_din_addr(1)=>config_din_addr(1),config_din_addr(0)=>config_din_addr(0),
            config_din_data(31)=>config_din_data(31),config_din_data(30)=>config_din_data(30),
            config_din_data(29)=>config_din_data(29),config_din_data(28)=>config_din_data(28),
            config_din_data(27)=>config_din_data(27),config_din_data(26)=>config_din_data(26),
            config_din_data(25)=>config_din_data(25),config_din_data(24)=>config_din_data(24),
            config_din_data(23)=>config_din_data(23),config_din_data(22)=>config_din_data(22),
            config_din_data(21)=>config_din_data(21),config_din_data(20)=>config_din_data(20),
            config_din_data(19)=>config_din_data(19),config_din_data(18)=>config_din_data(18),
            config_din_data(17)=>config_din_data(17),config_din_data(16)=>config_din_data(16),
            config_din_data(15)=>config_din_data(15),config_din_data(14)=>config_din_data(14),
            config_din_data(13)=>config_din_data(13),config_din_data(12)=>config_din_data(12),
            config_din_data(11)=>config_din_data(11),config_din_data(10)=>config_din_data(10),
            config_din_data(9)=>config_din_data(9),config_din_data(8)=>config_din_data(8),
            config_din_data(7)=>config_din_data(7),config_din_data(6)=>config_din_data(6),
            config_din_data(5)=>config_din_data(5),config_din_data(4)=>config_din_data(4),
            config_din_data(3)=>config_din_data(3),config_din_data(2)=>config_din_data(2),
            config_din_data(1)=>config_din_data(1),config_din_data(0)=>config_din_data(0),
            adc_clkdiv(1)=>adc_clkdiv_c(1),adc_clkdiv(0)=>adc_clkdiv_c(0),
            training_start(1)=>OPEN_net(10),training_start(0)=>training_start(0),
            training_done(1)=>training_done(1),training_done(0)=>training_done(0),
            tap(159)=>tap(159),tap(158)=>tap(158),tap(157)=>tap(157),tap(156)=>tap(156),
            tap(155)=>tap(155),tap(154)=>tap(154),tap(153)=>tap(153),tap(152)=>tap(152),
            tap(151)=>tap(151),tap(150)=>tap(150),tap(149)=>tap(149),tap(148)=>tap(148),
            tap(147)=>tap(147),tap(146)=>tap(146),tap(145)=>tap(145),tap(144)=>tap(144),
            tap(143)=>tap(143),tap(142)=>tap(142),tap(141)=>tap(141),tap(140)=>tap(140),
            tap(139)=>tap(139),tap(138)=>tap(138),tap(137)=>tap(137),tap(136)=>tap(136),
            tap(135)=>tap(135),tap(134)=>tap(134),tap(133)=>tap(133),tap(132)=>tap(132),
            tap(131)=>tap(131),tap(130)=>tap(130),tap(129)=>tap(129),tap(128)=>tap(128),
            tap(127)=>tap(127),tap(126)=>tap(126),tap(125)=>tap(125),tap(124)=>tap(124),
            tap(123)=>tap(123),tap(122)=>tap(122),tap(121)=>tap(121),tap(120)=>tap(120),
            tap(119)=>tap(119),tap(118)=>tap(118),tap(117)=>tap(117),tap(116)=>tap(116),
            tap(115)=>tap(115),tap(114)=>tap(114),tap(113)=>tap(113),tap(112)=>tap(112),
            tap(111)=>tap(111),tap(110)=>tap(110),tap(109)=>tap(109),tap(108)=>tap(108),
            tap(107)=>tap(107),tap(106)=>tap(106),tap(105)=>tap(105),tap(104)=>tap(104),
            tap(103)=>tap(103),tap(102)=>tap(102),tap(101)=>tap(101),tap(100)=>tap(100),
            tap(99)=>tap(99),tap(98)=>tap(98),tap(97)=>tap(97),tap(96)=>tap(96),
            tap(95)=>tap(95),tap(94)=>tap(94),tap(93)=>tap(93),tap(92)=>tap(92),
            tap(91)=>tap(91),tap(90)=>tap(90),tap(89)=>tap(89),tap(88)=>tap(88),
            tap(87)=>tap(87),tap(86)=>tap(86),tap(85)=>tap(85),tap(84)=>tap(84),
            tap(83)=>tap(83),tap(82)=>tap(82),tap(81)=>tap(81),tap(80)=>tap(80),
            tap(79)=>tap(79),tap(78)=>tap(78),tap(77)=>tap(77),tap(76)=>tap(76),
            tap(75)=>tap(75),tap(74)=>tap(74),tap(73)=>tap(73),tap(72)=>tap(72),
            tap(71)=>tap(71),tap(70)=>tap(70),tap(69)=>tap(69),tap(68)=>tap(68),
            tap(67)=>tap(67),tap(66)=>tap(66),tap(65)=>tap(65),tap(64)=>tap(64),
            tap(63)=>tap(63),tap(62)=>tap(62),tap(61)=>tap(61),tap(60)=>tap(60),
            tap(59)=>tap(59),tap(58)=>tap(58),tap(57)=>tap(57),tap(56)=>tap(56),
            tap(55)=>tap(55),tap(54)=>tap(54),tap(53)=>tap(53),tap(52)=>tap(52),
            tap(51)=>tap(51),tap(50)=>tap(50),tap(49)=>tap(49),tap(48)=>tap(48),
            tap(47)=>tap(47),tap(46)=>tap(46),tap(45)=>tap(45),tap(44)=>tap(44),
            tap(43)=>tap(43),tap(42)=>tap(42),tap(41)=>tap(41),tap(40)=>tap(40),
            tap(39)=>tap(39),tap(38)=>tap(38),tap(37)=>tap(37),tap(36)=>tap(36),
            tap(35)=>tap(35),tap(34)=>tap(34),tap(33)=>tap(33),tap(32)=>tap(32),
            tap(31)=>tap(31),tap(30)=>tap(30),tap(29)=>tap(29),tap(28)=>tap(28),
            tap(27)=>tap(27),tap(26)=>tap(26),tap(25)=>tap(25),tap(24)=>tap(24),
            tap(23)=>tap(23),tap(22)=>tap(22),tap(21)=>tap(21),tap(20)=>tap(20),
            tap(19)=>tap(19),tap(18)=>tap(18),tap(17)=>tap(17),tap(16)=>tap(16),
            tap(15)=>tap(15),tap(14)=>tap(14),tap(13)=>tap(13),tap(12)=>tap(12),
            tap(11)=>tap(11),tap(10)=>tap(10),tap(9)=>tap(9),tap(8)=>tap(8),
            tap(7)=>tap(7),tap(6)=>tap(6),tap(5)=>tap(5),tap(4)=>tap(4),
            tap(3)=>tap(3),tap(2)=>tap(2),tap(1)=>tap(1),tap(0)=>tap(0),
            idly_enable(1)=>OPEN_net(9),idly_enable(0)=>adc_manual_enable(0),
            idly_chan_sel(7)=>OPEN_net(8),idly_chan_sel(6)=>OPEN_net(7),idly_chan_sel(5)=>OPEN_net(6),
            idly_chan_sel(4)=>OPEN_net(5),idly_chan_sel(3)=>adc_manual_chan_sel(3),
            idly_chan_sel(2)=>adc_manual_chan_sel(2),idly_chan_sel(1)=>adc_manual_chan_sel(1),
            idly_chan_sel(0)=>adc_manual_chan_sel(0),idly_inc(1)=>OPEN_net(4),
            idly_inc(0)=>adc_manual_inc(0),idly_dec(1)=>OPEN_net(3),idly_dec(0)=>adc_manual_dec(0),
            idly_bitslip(1)=>OPEN_net(2),idly_bitslip(0)=>adc_manual_bitslip(0),
            idly_rst(1)=>OPEN_net(1),idly_rst(0)=>adc_manual_idly_rst(0),adc_spi_ck=>adc_spi_sclk,
            adc_spi_mosi=>adc_spi_mosi,adc_spi_miso=>adc_spi_miso,adc_spi_csn=>adc_spi_csn);   -- ADC/adc_top.v(135)
    
end architecture \.\;   -- ADC/adc_top.v(25)

