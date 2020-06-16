
--
-- Verific VHDL Description of module \pll_config(CONFIG_BASE_ADDR=32'b0100000)\
--

-- \pll_config(CONFIG_BASE_ADDR=32'b0100000)\ is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of module \adc_top(CONFIG_BASE_ADDR=32'b01000000,N=0)\
--

-- \adc_top(CONFIG_BASE_ADDR=32'b01000000,N=0)\ is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of module \adc_top(CONFIG_BASE_ADDR=32'b01100000,N=1)\
--

-- \adc_top(CONFIG_BASE_ADDR=32'b01100000,N=1)\ is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of OPERATOR reduce_or_21
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_21 is
    port (a: in std_logic_vector(20 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_21;

architecture INTERFACE of reduce_or_21 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,
        n16,n17,n18,n19 : std_logic; 
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
    n10 <= a(10) or a(11);
    n11 <= a(13) or a(14);
    n12 <= a(12) or n11;
    n13 <= n10 or n12;
    n14 <= a(16) or a(17);
    n15 <= a(15) or n14;
    n16 <= a(19) or a(20);
    n17 <= a(18) or n16;
    n18 <= n15 or n17;
    n19 <= n13 or n18;
    o <= n9 or n19;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of module IDELAYCTRL
--

-- IDELAYCTRL is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of module ADU_top
--

library ieee ;
use ieee.std_logic_1164.all ;

entity ADU_top is
    port (init_clk: in std_logic;   -- ADU_top.v(26)
        init_rst: in std_logic;   -- ADU_top.v(28)
        test_pulse: in std_logic;   -- ADU_top.v(29)
        init_done_out: out std_logic;   -- ADU_top.v(30)
        ADCA_DCLKP: in std_logic;   -- ADU_top.v(33)
        ADCA_DCLKN: in std_logic;   -- ADU_top.v(34)
        ADCA_DP: in std_logic_vector(13 downto 0);   -- ADU_top.v(35)
        ADCA_DN: in std_logic_vector(13 downto 0);   -- ADU_top.v(36)
        ADCA_SYNCP: in std_logic;   -- ADU_top.v(37)
        ADCA_SYNCN: in std_logic;   -- ADU_top.v(38)
        ADCA_SCSB: out std_logic;   -- ADU_top.v(39)
        ADCB_DCLKP: in std_logic;   -- ADU_top.v(41)
        ADCB_DCLKN: in std_logic;   -- ADU_top.v(42)
        ADCB_DP: in std_logic_vector(13 downto 0);   -- ADU_top.v(43)
        ADCB_DN: in std_logic_vector(13 downto 0);   -- ADU_top.v(44)
        ADCB_SYNCP: in std_logic;   -- ADU_top.v(45)
        ADCB_SYNCN: in std_logic;   -- ADU_top.v(46)
        ADCB_SCSB: out std_logic;   -- ADU_top.v(47)
        PLL_LE: out std_logic;   -- ADU_top.v(49)
        SPI_CLK: out std_logic;   -- ADU_top.v(53)
        SPI_EN: out std_logic;   -- ADU_top.v(54)
        SPI_MOSI: out std_logic;   -- ADU_top.v(55)
        SPI_MISO: in std_logic;   -- ADU_top.v(56)
        CAL_CTRL: out std_logic;   -- ADU_top.v(58)
        config_din_valid: in std_logic;   -- ADU_top.v(62)
        config_din_addr: in std_logic_vector(31 downto 0);   -- ADU_top.v(63)
        config_din_data: in std_logic_vector(31 downto 0);   -- ADU_top.v(64)
        config_dout_valid: out std_logic;   -- ADU_top.v(66)
        config_dout_addr: out std_logic_vector(31 downto 0);   -- ADU_top.v(67)
        config_dout_data: out std_logic_vector(31 downto 0);   -- ADU_top.v(68)
        adca_user_clk: out std_logic;   -- ADU_top.v(70)
        adca_raw_data: out std_logic_vector(127 downto 0);   -- ADU_top.v(71)
        adcb_user_clk: out std_logic;   -- ADU_top.v(72)
        adcb_raw_data: out std_logic_vector(127 downto 0);   -- ADU_top.v(73)
        cs_control: inout std_logic_vector(35 downto 0)   -- ADU_top.v(74)
    );
    
end entity ADU_top;   -- ADU_top.v(21)

architecture \.\ of ADU_top is 
    component \pll_config(CONFIG_BASE_ADDR=32'b0100000)\ is
        port (clk: inout std_logic;
            rst: inout std_logic;
            config_done: inout std_logic;
            config_din_valid: inout std_logic;
            config_din_addr: inout std_logic_vector(31 downto 0);
            config_din_data: inout std_logic_vector(31 downto 0);
            config_dout_valid: inout std_logic;
            config_dout_addr: inout std_logic_vector(31 downto 0);
            config_dout_data: inout std_logic_vector(31 downto 0);
            pll_spi_ck: inout std_logic;
            pll_spi_mosi: inout std_logic;
            pll_spi_miso: inout std_logic;
            pll_spi_en: inout std_logic
        );
        
    end component \pll_config(CONFIG_BASE_ADDR=32'b0100000)\;   -- ADU_top.v(90)
    component \adc_top(CONFIG_BASE_ADDR=32'b01000000,N=0)\ is
        port (init_clk: inout std_logic;
            init_rst: inout std_logic;
            adc_config_done: inout std_logic;
            config_din_valid: inout std_logic;
            config_din_addr: inout std_logic_vector(31 downto 0);
            config_din_data: inout std_logic_vector(31 downto 0);
            config_dout_valid: inout std_logic;
            config_dout_addr: inout std_logic_vector(31 downto 0);
            config_dout_data: inout std_logic_vector(31 downto 0);
            data_from_iserdes: inout std_logic_vector(255 downto 0);
            adc_clkdiv: inout std_logic_vector(1 downto 0);
            adc_sync_p: inout std_logic;
            adc_sync_n: inout std_logic;
            adc_in_p: inout std_logic_vector(31 downto 0);
            adc_in_n: inout std_logic_vector(31 downto 0);
            adc_dr_p: inout std_logic_vector(1 downto 0);
            adc_dr_n: inout std_logic_vector(1 downto 0);
            adc_spi_csn: inout std_logic;
            adc_spi_sclk: inout std_logic;
            adc_spi_mosi: inout std_logic;
            adc_spi_miso: inout std_logic
        );
        
    end component \adc_top(CONFIG_BASE_ADDR=32'b01000000,N=0)\;   -- ADU_top.v(159)
    component \adc_top(CONFIG_BASE_ADDR=32'b01100000,N=1)\ is
        port (init_clk: inout std_logic;
            init_rst: inout std_logic;
            adc_config_done: inout std_logic;
            config_din_valid: inout std_logic;
            config_din_addr: inout std_logic_vector(31 downto 0);
            config_din_data: inout std_logic_vector(31 downto 0);
            config_dout_valid: inout std_logic;
            config_dout_addr: inout std_logic_vector(31 downto 0);
            config_dout_data: inout std_logic_vector(31 downto 0);
            data_from_iserdes: inout std_logic_vector(255 downto 0);
            adc_clkdiv: inout std_logic_vector(1 downto 0);
            adc_sync_p: inout std_logic;
            adc_sync_n: inout std_logic;
            adc_in_p: inout std_logic_vector(31 downto 0);
            adc_in_n: inout std_logic_vector(31 downto 0);
            adc_dr_p: inout std_logic_vector(1 downto 0);
            adc_dr_n: inout std_logic_vector(1 downto 0);
            adc_spi_csn: inout std_logic;
            adc_spi_sclk: inout std_logic;
            adc_spi_mosi: inout std_logic;
            adc_spi_miso: inout std_logic
        );
        
    end component \adc_top(CONFIG_BASE_ADDR=32'b01100000,N=1)\;   -- ADU_top.v(197)
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
    component IDELAYCTRL is
        port (RDY: inout std_logic;
            REFCLK: inout std_logic;
            RST: inout std_logic
        );
        
    end component IDELAYCTRL;   -- ADU_top.v(327)
    signal init_clk_c : std_logic;   -- ADU_top.v(26)
    signal init_rst_c : std_logic;   -- ADU_top.v(28)
    signal ADCA_DCLKP_c : std_logic;   -- ADU_top.v(33)
    signal ADCA_DCLKN_c : std_logic;   -- ADU_top.v(34)
    signal ADCA_DP_c : std_logic_vector(13 downto 0);   -- ADU_top.v(35)
    signal ADCA_DN_c : std_logic_vector(13 downto 0);   -- ADU_top.v(36)
    signal ADCA_SYNCP_c : std_logic;   -- ADU_top.v(37)
    signal ADCA_SYNCN_c : std_logic;   -- ADU_top.v(38)
    signal ADCA_SCSB_c : std_logic;   -- ADU_top.v(39)
    signal ADCB_DCLKP_c : std_logic;   -- ADU_top.v(41)
    signal ADCB_DCLKN_c : std_logic;   -- ADU_top.v(42)
    signal ADCB_DP_c : std_logic_vector(13 downto 0);   -- ADU_top.v(43)
    signal ADCB_DN_c : std_logic_vector(13 downto 0);   -- ADU_top.v(44)
    signal ADCB_SYNCP_c : std_logic;   -- ADU_top.v(45)
    signal ADCB_SYNCN_c : std_logic;   -- ADU_top.v(46)
    signal ADCB_SCSB_c : std_logic;   -- ADU_top.v(47)
    signal PLL_LE_c : std_logic;   -- ADU_top.v(49)
    signal SPI_MISO_c : std_logic;   -- ADU_top.v(56)
    signal config_din_valid_c : std_logic;   -- ADU_top.v(62)
    signal config_din_addr_c : std_logic_vector(31 downto 0);   -- ADU_top.v(63)
    signal config_din_data_c : std_logic_vector(31 downto 0);   -- ADU_top.v(64)
    signal adcb_raw_data_c : std_logic_vector(127 downto 0);   -- ADU_top.v(73)
    signal config_pll_dout_valid : std_logic;   -- ADU_top.v(84)
    signal config_pll_dout_addr : std_logic_vector(31 downto 0);   -- ADU_top.v(85)
    signal config_pll_dout_data : std_logic_vector(31 downto 0);   -- ADU_top.v(86)
    signal pll_config_done : std_logic; -- KEEP="TRUE"    -- ADU_top.v(87)
    signal pll_spi_clk : std_logic;   -- ADU_top.v(88)
    signal pll_spi_mosi : std_logic;   -- ADU_top.v(88)
    signal config_adca_dout_valid : std_logic;   -- ADU_top.v(141)
    signal config_adca_dout_addr : std_logic_vector(31 downto 0);   -- ADU_top.v(142)
    signal config_adca_dout_data : std_logic_vector(31 downto 0);   -- ADU_top.v(143)
    signal config_adcb_dout_valid : std_logic;   -- ADU_top.v(144)
    signal config_adcb_dout_addr : std_logic_vector(31 downto 0);   -- ADU_top.v(145)
    signal config_adcb_dout_data : std_logic_vector(31 downto 0);   -- ADU_top.v(146)
    signal adca_spi_clk : std_logic;   -- ADU_top.v(148)
    signal adca_spi_mosi : std_logic;   -- ADU_top.v(148)
    signal adcb_spi_clk : std_logic;   -- ADU_top.v(149)
    signal adcb_spi_mosi : std_logic;   -- ADU_top.v(149)
    signal adca_config_done : std_logic;   -- ADU_top.v(151)
    signal adcb_config_done : std_logic;   -- ADU_top.v(152)
    signal dataa_from_iserdes : std_logic_vector(255 downto 0);   -- ADU_top.v(154)
    signal datab_from_iserdes : std_logic_vector(255 downto 0);   -- ADU_top.v(155)
    signal adca_clkdiv : std_logic_vector(1 downto 0);   -- ADU_top.v(156)
    signal adcb_clkdiv : std_logic_vector(1 downto 0);   -- ADU_top.v(157)
    signal cal : std_logic_vector(20 downto 0);   -- ADU_top.v(319)
    signal idelayctrl_ready : std_logic;   -- ADU_top.v(328)
    signal clk200 : std_logic;   -- ADU_top.v(329)
    signal n4,n5,n31,n33,n35,n37,n38,n39,n40,n41,n42,n43,n44,n45,
        n46,n47,n48,n49,n50,n51,n52,n53,n54,n55,n56,n57,n58,n59,
        n60,n61,n62,n63,n64,n65,n66,n67,n68,n69,n70,n71,n72,n73,
        n74,n75,n76,n77,n78,n79,n80,n81,n82,n83,n84,n85,n86,n87,
        n88,n89,n90,n91,n92,n93,n94,n95,n96,n97,n98,n99,n100,n133,
        n134,n135,n136,n137,n138,n139,n140,n141,n142,n143,n144,n145,
        n146,n147,n148,n149,n150,n151,n152,n153,n154,n155,n156,n157,
        n158,n159,n160,n161,n162,n163,n164,n165,n166,n167,n168,n169,
        n170,n171,n172,n173,n174,n175,n176,n177,n178,n179,n180,n181,
        n182,n183,n184,n185,n186,n187,n188,n189,n190,n191,n192,n193,
        n194,n195,n196,n252 : std_logic; 
begin
    init_clk_c <= init_clk;   -- ADU_top.v(26)
    init_rst_c <= init_rst;   -- ADU_top.v(28)
    init_done_out <= adcb_config_done;   -- ADU_top.v(30)
    ADCA_DCLKP_c <= ADCA_DCLKP;   -- ADU_top.v(33)
    ADCA_DCLKN_c <= ADCA_DCLKN;   -- ADU_top.v(34)
    ADCA_DP_c(13) <= ADCA_DP(13);   -- ADU_top.v(35)
    ADCA_DP_c(12) <= ADCA_DP(12);   -- ADU_top.v(35)
    ADCA_DP_c(11) <= ADCA_DP(11);   -- ADU_top.v(35)
    ADCA_DP_c(10) <= ADCA_DP(10);   -- ADU_top.v(35)
    ADCA_DP_c(9) <= ADCA_DP(9);   -- ADU_top.v(35)
    ADCA_DP_c(8) <= ADCA_DP(8);   -- ADU_top.v(35)
    ADCA_DP_c(7) <= ADCA_DP(7);   -- ADU_top.v(35)
    ADCA_DP_c(6) <= ADCA_DP(6);   -- ADU_top.v(35)
    ADCA_DP_c(5) <= ADCA_DP(5);   -- ADU_top.v(35)
    ADCA_DP_c(4) <= ADCA_DP(4);   -- ADU_top.v(35)
    ADCA_DP_c(3) <= ADCA_DP(3);   -- ADU_top.v(35)
    ADCA_DP_c(2) <= ADCA_DP(2);   -- ADU_top.v(35)
    ADCA_DP_c(1) <= ADCA_DP(1);   -- ADU_top.v(35)
    ADCA_DP_c(0) <= ADCA_DP(0);   -- ADU_top.v(35)
    ADCA_DN_c(13) <= ADCA_DN(13);   -- ADU_top.v(36)
    ADCA_DN_c(12) <= ADCA_DN(12);   -- ADU_top.v(36)
    ADCA_DN_c(11) <= ADCA_DN(11);   -- ADU_top.v(36)
    ADCA_DN_c(10) <= ADCA_DN(10);   -- ADU_top.v(36)
    ADCA_DN_c(9) <= ADCA_DN(9);   -- ADU_top.v(36)
    ADCA_DN_c(8) <= ADCA_DN(8);   -- ADU_top.v(36)
    ADCA_DN_c(7) <= ADCA_DN(7);   -- ADU_top.v(36)
    ADCA_DN_c(6) <= ADCA_DN(6);   -- ADU_top.v(36)
    ADCA_DN_c(5) <= ADCA_DN(5);   -- ADU_top.v(36)
    ADCA_DN_c(4) <= ADCA_DN(4);   -- ADU_top.v(36)
    ADCA_DN_c(3) <= ADCA_DN(3);   -- ADU_top.v(36)
    ADCA_DN_c(2) <= ADCA_DN(2);   -- ADU_top.v(36)
    ADCA_DN_c(1) <= ADCA_DN(1);   -- ADU_top.v(36)
    ADCA_DN_c(0) <= ADCA_DN(0);   -- ADU_top.v(36)
    ADCA_SYNCP_c <= ADCA_SYNCP;   -- ADU_top.v(37)
    ADCA_SYNCN_c <= ADCA_SYNCN;   -- ADU_top.v(38)
    ADCA_SCSB <= ADCA_SCSB_c;   -- ADU_top.v(39)
    ADCB_DCLKP_c <= ADCB_DCLKP;   -- ADU_top.v(41)
    ADCB_DCLKN_c <= ADCB_DCLKN;   -- ADU_top.v(42)
    ADCB_DP_c(13) <= ADCB_DP(13);   -- ADU_top.v(43)
    ADCB_DP_c(12) <= ADCB_DP(12);   -- ADU_top.v(43)
    ADCB_DP_c(11) <= ADCB_DP(11);   -- ADU_top.v(43)
    ADCB_DP_c(10) <= ADCB_DP(10);   -- ADU_top.v(43)
    ADCB_DP_c(9) <= ADCB_DP(9);   -- ADU_top.v(43)
    ADCB_DP_c(8) <= ADCB_DP(8);   -- ADU_top.v(43)
    ADCB_DP_c(7) <= ADCB_DP(7);   -- ADU_top.v(43)
    ADCB_DP_c(6) <= ADCB_DP(6);   -- ADU_top.v(43)
    ADCB_DP_c(5) <= ADCB_DP(5);   -- ADU_top.v(43)
    ADCB_DP_c(4) <= ADCB_DP(4);   -- ADU_top.v(43)
    ADCB_DP_c(3) <= ADCB_DP(3);   -- ADU_top.v(43)
    ADCB_DP_c(2) <= ADCB_DP(2);   -- ADU_top.v(43)
    ADCB_DP_c(1) <= ADCB_DP(1);   -- ADU_top.v(43)
    ADCB_DP_c(0) <= ADCB_DP(0);   -- ADU_top.v(43)
    ADCB_DN_c(13) <= ADCB_DN(13);   -- ADU_top.v(44)
    ADCB_DN_c(12) <= ADCB_DN(12);   -- ADU_top.v(44)
    ADCB_DN_c(11) <= ADCB_DN(11);   -- ADU_top.v(44)
    ADCB_DN_c(10) <= ADCB_DN(10);   -- ADU_top.v(44)
    ADCB_DN_c(9) <= ADCB_DN(9);   -- ADU_top.v(44)
    ADCB_DN_c(8) <= ADCB_DN(8);   -- ADU_top.v(44)
    ADCB_DN_c(7) <= ADCB_DN(7);   -- ADU_top.v(44)
    ADCB_DN_c(6) <= ADCB_DN(6);   -- ADU_top.v(44)
    ADCB_DN_c(5) <= ADCB_DN(5);   -- ADU_top.v(44)
    ADCB_DN_c(4) <= ADCB_DN(4);   -- ADU_top.v(44)
    ADCB_DN_c(3) <= ADCB_DN(3);   -- ADU_top.v(44)
    ADCB_DN_c(2) <= ADCB_DN(2);   -- ADU_top.v(44)
    ADCB_DN_c(1) <= ADCB_DN(1);   -- ADU_top.v(44)
    ADCB_DN_c(0) <= ADCB_DN(0);   -- ADU_top.v(44)
    ADCB_SYNCP_c <= ADCB_SYNCP;   -- ADU_top.v(45)
    ADCB_SYNCN_c <= ADCB_SYNCN;   -- ADU_top.v(46)
    ADCB_SCSB <= ADCB_SCSB_c;   -- ADU_top.v(47)
    PLL_LE <= PLL_LE_c;   -- ADU_top.v(49)
    SPI_MISO_c <= SPI_MISO;   -- ADU_top.v(56)
    config_din_valid_c <= config_din_valid;   -- ADU_top.v(62)
    config_din_addr_c(31) <= config_din_addr(31);   -- ADU_top.v(63)
    config_din_addr_c(30) <= config_din_addr(30);   -- ADU_top.v(63)
    config_din_addr_c(29) <= config_din_addr(29);   -- ADU_top.v(63)
    config_din_addr_c(28) <= config_din_addr(28);   -- ADU_top.v(63)
    config_din_addr_c(27) <= config_din_addr(27);   -- ADU_top.v(63)
    config_din_addr_c(26) <= config_din_addr(26);   -- ADU_top.v(63)
    config_din_addr_c(25) <= config_din_addr(25);   -- ADU_top.v(63)
    config_din_addr_c(24) <= config_din_addr(24);   -- ADU_top.v(63)
    config_din_addr_c(23) <= config_din_addr(23);   -- ADU_top.v(63)
    config_din_addr_c(22) <= config_din_addr(22);   -- ADU_top.v(63)
    config_din_addr_c(21) <= config_din_addr(21);   -- ADU_top.v(63)
    config_din_addr_c(20) <= config_din_addr(20);   -- ADU_top.v(63)
    config_din_addr_c(19) <= config_din_addr(19);   -- ADU_top.v(63)
    config_din_addr_c(18) <= config_din_addr(18);   -- ADU_top.v(63)
    config_din_addr_c(17) <= config_din_addr(17);   -- ADU_top.v(63)
    config_din_addr_c(16) <= config_din_addr(16);   -- ADU_top.v(63)
    config_din_addr_c(15) <= config_din_addr(15);   -- ADU_top.v(63)
    config_din_addr_c(14) <= config_din_addr(14);   -- ADU_top.v(63)
    config_din_addr_c(13) <= config_din_addr(13);   -- ADU_top.v(63)
    config_din_addr_c(12) <= config_din_addr(12);   -- ADU_top.v(63)
    config_din_addr_c(11) <= config_din_addr(11);   -- ADU_top.v(63)
    config_din_addr_c(10) <= config_din_addr(10);   -- ADU_top.v(63)
    config_din_addr_c(9) <= config_din_addr(9);   -- ADU_top.v(63)
    config_din_addr_c(8) <= config_din_addr(8);   -- ADU_top.v(63)
    config_din_addr_c(7) <= config_din_addr(7);   -- ADU_top.v(63)
    config_din_addr_c(6) <= config_din_addr(6);   -- ADU_top.v(63)
    config_din_addr_c(5) <= config_din_addr(5);   -- ADU_top.v(63)
    config_din_addr_c(4) <= config_din_addr(4);   -- ADU_top.v(63)
    config_din_addr_c(3) <= config_din_addr(3);   -- ADU_top.v(63)
    config_din_addr_c(2) <= config_din_addr(2);   -- ADU_top.v(63)
    config_din_addr_c(1) <= config_din_addr(1);   -- ADU_top.v(63)
    config_din_addr_c(0) <= config_din_addr(0);   -- ADU_top.v(63)
    config_din_data_c(31) <= config_din_data(31);   -- ADU_top.v(64)
    config_din_data_c(30) <= config_din_data(30);   -- ADU_top.v(64)
    config_din_data_c(29) <= config_din_data(29);   -- ADU_top.v(64)
    config_din_data_c(28) <= config_din_data(28);   -- ADU_top.v(64)
    config_din_data_c(27) <= config_din_data(27);   -- ADU_top.v(64)
    config_din_data_c(26) <= config_din_data(26);   -- ADU_top.v(64)
    config_din_data_c(25) <= config_din_data(25);   -- ADU_top.v(64)
    config_din_data_c(24) <= config_din_data(24);   -- ADU_top.v(64)
    config_din_data_c(23) <= config_din_data(23);   -- ADU_top.v(64)
    config_din_data_c(22) <= config_din_data(22);   -- ADU_top.v(64)
    config_din_data_c(21) <= config_din_data(21);   -- ADU_top.v(64)
    config_din_data_c(20) <= config_din_data(20);   -- ADU_top.v(64)
    config_din_data_c(19) <= config_din_data(19);   -- ADU_top.v(64)
    config_din_data_c(18) <= config_din_data(18);   -- ADU_top.v(64)
    config_din_data_c(17) <= config_din_data(17);   -- ADU_top.v(64)
    config_din_data_c(16) <= config_din_data(16);   -- ADU_top.v(64)
    config_din_data_c(15) <= config_din_data(15);   -- ADU_top.v(64)
    config_din_data_c(14) <= config_din_data(14);   -- ADU_top.v(64)
    config_din_data_c(13) <= config_din_data(13);   -- ADU_top.v(64)
    config_din_data_c(12) <= config_din_data(12);   -- ADU_top.v(64)
    config_din_data_c(11) <= config_din_data(11);   -- ADU_top.v(64)
    config_din_data_c(10) <= config_din_data(10);   -- ADU_top.v(64)
    config_din_data_c(9) <= config_din_data(9);   -- ADU_top.v(64)
    config_din_data_c(8) <= config_din_data(8);   -- ADU_top.v(64)
    config_din_data_c(7) <= config_din_data(7);   -- ADU_top.v(64)
    config_din_data_c(6) <= config_din_data(6);   -- ADU_top.v(64)
    config_din_data_c(5) <= config_din_data(5);   -- ADU_top.v(64)
    config_din_data_c(4) <= config_din_data(4);   -- ADU_top.v(64)
    config_din_data_c(3) <= config_din_data(3);   -- ADU_top.v(64)
    config_din_data_c(2) <= config_din_data(2);   -- ADU_top.v(64)
    config_din_data_c(1) <= config_din_data(1);   -- ADU_top.v(64)
    config_din_data_c(0) <= config_din_data(0);   -- ADU_top.v(64)
    adca_user_clk <= adca_clkdiv(0);   -- ADU_top.v(70)
    adca_raw_data(127) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(126) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(125) <= dataa_from_iserdes(104);   -- ADU_top.v(71)
    adca_raw_data(124) <= dataa_from_iserdes(96);   -- ADU_top.v(71)
    adca_raw_data(123) <= dataa_from_iserdes(88);   -- ADU_top.v(71)
    adca_raw_data(122) <= dataa_from_iserdes(80);   -- ADU_top.v(71)
    adca_raw_data(121) <= dataa_from_iserdes(72);   -- ADU_top.v(71)
    adca_raw_data(120) <= dataa_from_iserdes(64);   -- ADU_top.v(71)
    adca_raw_data(119) <= dataa_from_iserdes(56);   -- ADU_top.v(71)
    adca_raw_data(118) <= dataa_from_iserdes(48);   -- ADU_top.v(71)
    adca_raw_data(117) <= dataa_from_iserdes(40);   -- ADU_top.v(71)
    adca_raw_data(116) <= dataa_from_iserdes(32);   -- ADU_top.v(71)
    adca_raw_data(115) <= dataa_from_iserdes(24);   -- ADU_top.v(71)
    adca_raw_data(114) <= dataa_from_iserdes(16);   -- ADU_top.v(71)
    adca_raw_data(113) <= dataa_from_iserdes(8);   -- ADU_top.v(71)
    adca_raw_data(112) <= dataa_from_iserdes(0);   -- ADU_top.v(71)
    adca_raw_data(111) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(110) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(109) <= dataa_from_iserdes(105);   -- ADU_top.v(71)
    adca_raw_data(108) <= dataa_from_iserdes(97);   -- ADU_top.v(71)
    adca_raw_data(107) <= dataa_from_iserdes(89);   -- ADU_top.v(71)
    adca_raw_data(106) <= dataa_from_iserdes(81);   -- ADU_top.v(71)
    adca_raw_data(105) <= dataa_from_iserdes(73);   -- ADU_top.v(71)
    adca_raw_data(104) <= dataa_from_iserdes(65);   -- ADU_top.v(71)
    adca_raw_data(103) <= dataa_from_iserdes(57);   -- ADU_top.v(71)
    adca_raw_data(102) <= dataa_from_iserdes(49);   -- ADU_top.v(71)
    adca_raw_data(101) <= dataa_from_iserdes(41);   -- ADU_top.v(71)
    adca_raw_data(100) <= dataa_from_iserdes(33);   -- ADU_top.v(71)
    adca_raw_data(99) <= dataa_from_iserdes(25);   -- ADU_top.v(71)
    adca_raw_data(98) <= dataa_from_iserdes(17);   -- ADU_top.v(71)
    adca_raw_data(97) <= dataa_from_iserdes(9);   -- ADU_top.v(71)
    adca_raw_data(96) <= dataa_from_iserdes(1);   -- ADU_top.v(71)
    adca_raw_data(95) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(94) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(93) <= dataa_from_iserdes(106);   -- ADU_top.v(71)
    adca_raw_data(92) <= dataa_from_iserdes(98);   -- ADU_top.v(71)
    adca_raw_data(91) <= dataa_from_iserdes(90);   -- ADU_top.v(71)
    adca_raw_data(90) <= dataa_from_iserdes(82);   -- ADU_top.v(71)
    adca_raw_data(89) <= dataa_from_iserdes(74);   -- ADU_top.v(71)
    adca_raw_data(88) <= dataa_from_iserdes(66);   -- ADU_top.v(71)
    adca_raw_data(87) <= dataa_from_iserdes(58);   -- ADU_top.v(71)
    adca_raw_data(86) <= dataa_from_iserdes(50);   -- ADU_top.v(71)
    adca_raw_data(85) <= dataa_from_iserdes(42);   -- ADU_top.v(71)
    adca_raw_data(84) <= dataa_from_iserdes(34);   -- ADU_top.v(71)
    adca_raw_data(83) <= dataa_from_iserdes(26);   -- ADU_top.v(71)
    adca_raw_data(82) <= dataa_from_iserdes(18);   -- ADU_top.v(71)
    adca_raw_data(81) <= dataa_from_iserdes(10);   -- ADU_top.v(71)
    adca_raw_data(80) <= dataa_from_iserdes(2);   -- ADU_top.v(71)
    adca_raw_data(79) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(78) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(77) <= dataa_from_iserdes(107);   -- ADU_top.v(71)
    adca_raw_data(76) <= dataa_from_iserdes(99);   -- ADU_top.v(71)
    adca_raw_data(75) <= dataa_from_iserdes(91);   -- ADU_top.v(71)
    adca_raw_data(74) <= dataa_from_iserdes(83);   -- ADU_top.v(71)
    adca_raw_data(73) <= dataa_from_iserdes(75);   -- ADU_top.v(71)
    adca_raw_data(72) <= dataa_from_iserdes(67);   -- ADU_top.v(71)
    adca_raw_data(71) <= dataa_from_iserdes(59);   -- ADU_top.v(71)
    adca_raw_data(70) <= dataa_from_iserdes(51);   -- ADU_top.v(71)
    adca_raw_data(69) <= dataa_from_iserdes(43);   -- ADU_top.v(71)
    adca_raw_data(68) <= dataa_from_iserdes(35);   -- ADU_top.v(71)
    adca_raw_data(67) <= dataa_from_iserdes(27);   -- ADU_top.v(71)
    adca_raw_data(66) <= dataa_from_iserdes(19);   -- ADU_top.v(71)
    adca_raw_data(65) <= dataa_from_iserdes(11);   -- ADU_top.v(71)
    adca_raw_data(64) <= dataa_from_iserdes(3);   -- ADU_top.v(71)
    adca_raw_data(63) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(62) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(61) <= dataa_from_iserdes(108);   -- ADU_top.v(71)
    adca_raw_data(60) <= dataa_from_iserdes(100);   -- ADU_top.v(71)
    adca_raw_data(59) <= dataa_from_iserdes(92);   -- ADU_top.v(71)
    adca_raw_data(58) <= dataa_from_iserdes(84);   -- ADU_top.v(71)
    adca_raw_data(57) <= dataa_from_iserdes(76);   -- ADU_top.v(71)
    adca_raw_data(56) <= dataa_from_iserdes(68);   -- ADU_top.v(71)
    adca_raw_data(55) <= dataa_from_iserdes(60);   -- ADU_top.v(71)
    adca_raw_data(54) <= dataa_from_iserdes(52);   -- ADU_top.v(71)
    adca_raw_data(53) <= dataa_from_iserdes(44);   -- ADU_top.v(71)
    adca_raw_data(52) <= dataa_from_iserdes(36);   -- ADU_top.v(71)
    adca_raw_data(51) <= dataa_from_iserdes(28);   -- ADU_top.v(71)
    adca_raw_data(50) <= dataa_from_iserdes(20);   -- ADU_top.v(71)
    adca_raw_data(49) <= dataa_from_iserdes(12);   -- ADU_top.v(71)
    adca_raw_data(48) <= dataa_from_iserdes(4);   -- ADU_top.v(71)
    adca_raw_data(47) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(46) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(45) <= dataa_from_iserdes(109);   -- ADU_top.v(71)
    adca_raw_data(44) <= dataa_from_iserdes(101);   -- ADU_top.v(71)
    adca_raw_data(43) <= dataa_from_iserdes(93);   -- ADU_top.v(71)
    adca_raw_data(42) <= dataa_from_iserdes(85);   -- ADU_top.v(71)
    adca_raw_data(41) <= dataa_from_iserdes(77);   -- ADU_top.v(71)
    adca_raw_data(40) <= dataa_from_iserdes(69);   -- ADU_top.v(71)
    adca_raw_data(39) <= dataa_from_iserdes(61);   -- ADU_top.v(71)
    adca_raw_data(38) <= dataa_from_iserdes(53);   -- ADU_top.v(71)
    adca_raw_data(37) <= dataa_from_iserdes(45);   -- ADU_top.v(71)
    adca_raw_data(36) <= dataa_from_iserdes(37);   -- ADU_top.v(71)
    adca_raw_data(35) <= dataa_from_iserdes(29);   -- ADU_top.v(71)
    adca_raw_data(34) <= dataa_from_iserdes(21);   -- ADU_top.v(71)
    adca_raw_data(33) <= dataa_from_iserdes(13);   -- ADU_top.v(71)
    adca_raw_data(32) <= dataa_from_iserdes(5);   -- ADU_top.v(71)
    adca_raw_data(31) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(30) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(29) <= dataa_from_iserdes(110);   -- ADU_top.v(71)
    adca_raw_data(28) <= dataa_from_iserdes(102);   -- ADU_top.v(71)
    adca_raw_data(27) <= dataa_from_iserdes(94);   -- ADU_top.v(71)
    adca_raw_data(26) <= dataa_from_iserdes(86);   -- ADU_top.v(71)
    adca_raw_data(25) <= dataa_from_iserdes(78);   -- ADU_top.v(71)
    adca_raw_data(24) <= dataa_from_iserdes(70);   -- ADU_top.v(71)
    adca_raw_data(23) <= dataa_from_iserdes(62);   -- ADU_top.v(71)
    adca_raw_data(22) <= dataa_from_iserdes(54);   -- ADU_top.v(71)
    adca_raw_data(21) <= dataa_from_iserdes(46);   -- ADU_top.v(71)
    adca_raw_data(20) <= dataa_from_iserdes(38);   -- ADU_top.v(71)
    adca_raw_data(19) <= dataa_from_iserdes(30);   -- ADU_top.v(71)
    adca_raw_data(18) <= dataa_from_iserdes(22);   -- ADU_top.v(71)
    adca_raw_data(17) <= dataa_from_iserdes(14);   -- ADU_top.v(71)
    adca_raw_data(16) <= dataa_from_iserdes(6);   -- ADU_top.v(71)
    adca_raw_data(15) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(14) <= adcb_raw_data_c(14);   -- ADU_top.v(71)
    adca_raw_data(13) <= dataa_from_iserdes(111);   -- ADU_top.v(71)
    adca_raw_data(12) <= dataa_from_iserdes(103);   -- ADU_top.v(71)
    adca_raw_data(11) <= dataa_from_iserdes(95);   -- ADU_top.v(71)
    adca_raw_data(10) <= dataa_from_iserdes(87);   -- ADU_top.v(71)
    adca_raw_data(9) <= dataa_from_iserdes(79);   -- ADU_top.v(71)
    adca_raw_data(8) <= dataa_from_iserdes(71);   -- ADU_top.v(71)
    adca_raw_data(7) <= dataa_from_iserdes(63);   -- ADU_top.v(71)
    adca_raw_data(6) <= dataa_from_iserdes(55);   -- ADU_top.v(71)
    adca_raw_data(5) <= dataa_from_iserdes(47);   -- ADU_top.v(71)
    adca_raw_data(4) <= dataa_from_iserdes(39);   -- ADU_top.v(71)
    adca_raw_data(3) <= dataa_from_iserdes(31);   -- ADU_top.v(71)
    adca_raw_data(2) <= dataa_from_iserdes(23);   -- ADU_top.v(71)
    adca_raw_data(1) <= dataa_from_iserdes(15);   -- ADU_top.v(71)
    adca_raw_data(0) <= dataa_from_iserdes(7);   -- ADU_top.v(71)
    adcb_user_clk <= adcb_clkdiv(0);   -- ADU_top.v(72)
    adcb_raw_data(127) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(126) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(125) <= datab_from_iserdes(104);   -- ADU_top.v(73)
    adcb_raw_data(124) <= datab_from_iserdes(96);   -- ADU_top.v(73)
    adcb_raw_data(123) <= datab_from_iserdes(88);   -- ADU_top.v(73)
    adcb_raw_data(122) <= datab_from_iserdes(80);   -- ADU_top.v(73)
    adcb_raw_data(121) <= datab_from_iserdes(72);   -- ADU_top.v(73)
    adcb_raw_data(120) <= datab_from_iserdes(64);   -- ADU_top.v(73)
    adcb_raw_data(119) <= datab_from_iserdes(56);   -- ADU_top.v(73)
    adcb_raw_data(118) <= datab_from_iserdes(48);   -- ADU_top.v(73)
    adcb_raw_data(117) <= datab_from_iserdes(40);   -- ADU_top.v(73)
    adcb_raw_data(116) <= datab_from_iserdes(32);   -- ADU_top.v(73)
    adcb_raw_data(115) <= datab_from_iserdes(24);   -- ADU_top.v(73)
    adcb_raw_data(111) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(110) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(109) <= datab_from_iserdes(105);   -- ADU_top.v(73)
    adcb_raw_data(108) <= datab_from_iserdes(97);   -- ADU_top.v(73)
    adcb_raw_data(107) <= datab_from_iserdes(89);   -- ADU_top.v(73)
    adcb_raw_data(106) <= datab_from_iserdes(81);   -- ADU_top.v(73)
    adcb_raw_data(105) <= datab_from_iserdes(73);   -- ADU_top.v(73)
    adcb_raw_data(104) <= datab_from_iserdes(65);   -- ADU_top.v(73)
    adcb_raw_data(103) <= datab_from_iserdes(57);   -- ADU_top.v(73)
    adcb_raw_data(102) <= datab_from_iserdes(49);   -- ADU_top.v(73)
    adcb_raw_data(101) <= datab_from_iserdes(41);   -- ADU_top.v(73)
    adcb_raw_data(100) <= datab_from_iserdes(33);   -- ADU_top.v(73)
    adcb_raw_data(99) <= datab_from_iserdes(25);   -- ADU_top.v(73)
    adcb_raw_data(95) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(94) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(93) <= datab_from_iserdes(106);   -- ADU_top.v(73)
    adcb_raw_data(92) <= datab_from_iserdes(98);   -- ADU_top.v(73)
    adcb_raw_data(91) <= datab_from_iserdes(90);   -- ADU_top.v(73)
    adcb_raw_data(90) <= datab_from_iserdes(82);   -- ADU_top.v(73)
    adcb_raw_data(89) <= datab_from_iserdes(74);   -- ADU_top.v(73)
    adcb_raw_data(88) <= datab_from_iserdes(66);   -- ADU_top.v(73)
    adcb_raw_data(87) <= datab_from_iserdes(58);   -- ADU_top.v(73)
    adcb_raw_data(86) <= datab_from_iserdes(50);   -- ADU_top.v(73)
    adcb_raw_data(85) <= datab_from_iserdes(42);   -- ADU_top.v(73)
    adcb_raw_data(84) <= datab_from_iserdes(34);   -- ADU_top.v(73)
    adcb_raw_data(83) <= datab_from_iserdes(26);   -- ADU_top.v(73)
    adcb_raw_data(79) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(78) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(77) <= datab_from_iserdes(107);   -- ADU_top.v(73)
    adcb_raw_data(76) <= datab_from_iserdes(99);   -- ADU_top.v(73)
    adcb_raw_data(75) <= datab_from_iserdes(91);   -- ADU_top.v(73)
    adcb_raw_data(74) <= datab_from_iserdes(83);   -- ADU_top.v(73)
    adcb_raw_data(73) <= datab_from_iserdes(75);   -- ADU_top.v(73)
    adcb_raw_data(72) <= datab_from_iserdes(67);   -- ADU_top.v(73)
    adcb_raw_data(71) <= datab_from_iserdes(59);   -- ADU_top.v(73)
    adcb_raw_data(70) <= datab_from_iserdes(51);   -- ADU_top.v(73)
    adcb_raw_data(69) <= datab_from_iserdes(43);   -- ADU_top.v(73)
    adcb_raw_data(68) <= datab_from_iserdes(35);   -- ADU_top.v(73)
    adcb_raw_data(67) <= datab_from_iserdes(27);   -- ADU_top.v(73)
    adcb_raw_data(63) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(62) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(61) <= datab_from_iserdes(108);   -- ADU_top.v(73)
    adcb_raw_data(60) <= datab_from_iserdes(100);   -- ADU_top.v(73)
    adcb_raw_data(59) <= datab_from_iserdes(92);   -- ADU_top.v(73)
    adcb_raw_data(58) <= datab_from_iserdes(84);   -- ADU_top.v(73)
    adcb_raw_data(57) <= datab_from_iserdes(76);   -- ADU_top.v(73)
    adcb_raw_data(56) <= datab_from_iserdes(68);   -- ADU_top.v(73)
    adcb_raw_data(55) <= datab_from_iserdes(60);   -- ADU_top.v(73)
    adcb_raw_data(54) <= datab_from_iserdes(52);   -- ADU_top.v(73)
    adcb_raw_data(53) <= datab_from_iserdes(44);   -- ADU_top.v(73)
    adcb_raw_data(52) <= datab_from_iserdes(36);   -- ADU_top.v(73)
    adcb_raw_data(51) <= datab_from_iserdes(28);   -- ADU_top.v(73)
    adcb_raw_data(47) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(46) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(45) <= datab_from_iserdes(109);   -- ADU_top.v(73)
    adcb_raw_data(44) <= datab_from_iserdes(101);   -- ADU_top.v(73)
    adcb_raw_data(43) <= datab_from_iserdes(93);   -- ADU_top.v(73)
    adcb_raw_data(42) <= datab_from_iserdes(85);   -- ADU_top.v(73)
    adcb_raw_data(41) <= datab_from_iserdes(77);   -- ADU_top.v(73)
    adcb_raw_data(40) <= datab_from_iserdes(69);   -- ADU_top.v(73)
    adcb_raw_data(39) <= datab_from_iserdes(61);   -- ADU_top.v(73)
    adcb_raw_data(38) <= datab_from_iserdes(53);   -- ADU_top.v(73)
    adcb_raw_data(37) <= datab_from_iserdes(45);   -- ADU_top.v(73)
    adcb_raw_data(36) <= datab_from_iserdes(37);   -- ADU_top.v(73)
    adcb_raw_data(35) <= datab_from_iserdes(29);   -- ADU_top.v(73)
    adcb_raw_data(31) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(30) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(29) <= datab_from_iserdes(110);   -- ADU_top.v(73)
    adcb_raw_data(28) <= datab_from_iserdes(102);   -- ADU_top.v(73)
    adcb_raw_data(27) <= datab_from_iserdes(94);   -- ADU_top.v(73)
    adcb_raw_data(26) <= datab_from_iserdes(86);   -- ADU_top.v(73)
    adcb_raw_data(25) <= datab_from_iserdes(78);   -- ADU_top.v(73)
    adcb_raw_data(24) <= datab_from_iserdes(70);   -- ADU_top.v(73)
    adcb_raw_data(23) <= datab_from_iserdes(62);   -- ADU_top.v(73)
    adcb_raw_data(22) <= datab_from_iserdes(54);   -- ADU_top.v(73)
    adcb_raw_data(21) <= datab_from_iserdes(46);   -- ADU_top.v(73)
    adcb_raw_data(20) <= datab_from_iserdes(38);   -- ADU_top.v(73)
    adcb_raw_data(19) <= datab_from_iserdes(30);   -- ADU_top.v(73)
    adcb_raw_data(15) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(14) <= adcb_raw_data_c(14);   -- ADU_top.v(73)
    adcb_raw_data(13) <= datab_from_iserdes(111);   -- ADU_top.v(73)
    adcb_raw_data(12) <= datab_from_iserdes(103);   -- ADU_top.v(73)
    adcb_raw_data(11) <= datab_from_iserdes(95);   -- ADU_top.v(73)
    adcb_raw_data(10) <= datab_from_iserdes(87);   -- ADU_top.v(73)
    adcb_raw_data(9) <= datab_from_iserdes(79);   -- ADU_top.v(73)
    adcb_raw_data(8) <= datab_from_iserdes(71);   -- ADU_top.v(73)
    adcb_raw_data(7) <= datab_from_iserdes(63);   -- ADU_top.v(73)
    adcb_raw_data(6) <= datab_from_iserdes(55);   -- ADU_top.v(73)
    adcb_raw_data(5) <= datab_from_iserdes(47);   -- ADU_top.v(73)
    adcb_raw_data(4) <= datab_from_iserdes(39);   -- ADU_top.v(73)
    adcb_raw_data(3) <= datab_from_iserdes(31);   -- ADU_top.v(73)
    adcb_raw_data_c(14) <= '0' ;
    lmx2581_config: component \pll_config(CONFIG_BASE_ADDR=32'b0100000)\ port map (clk=>init_clk_c,
            rst=>init_rst_c,config_done=>pll_config_done,config_din_valid=>config_din_valid_c,
            config_din_addr(31)=>config_din_addr_c(31),config_din_addr(30)=>config_din_addr_c(30),
            config_din_addr(29)=>config_din_addr_c(29),config_din_addr(28)=>config_din_addr_c(28),
            config_din_addr(27)=>config_din_addr_c(27),config_din_addr(26)=>config_din_addr_c(26),
            config_din_addr(25)=>config_din_addr_c(25),config_din_addr(24)=>config_din_addr_c(24),
            config_din_addr(23)=>config_din_addr_c(23),config_din_addr(22)=>config_din_addr_c(22),
            config_din_addr(21)=>config_din_addr_c(21),config_din_addr(20)=>config_din_addr_c(20),
            config_din_addr(19)=>config_din_addr_c(19),config_din_addr(18)=>config_din_addr_c(18),
            config_din_addr(17)=>config_din_addr_c(17),config_din_addr(16)=>config_din_addr_c(16),
            config_din_addr(15)=>config_din_addr_c(15),config_din_addr(14)=>config_din_addr_c(14),
            config_din_addr(13)=>config_din_addr_c(13),config_din_addr(12)=>config_din_addr_c(12),
            config_din_addr(11)=>config_din_addr_c(11),config_din_addr(10)=>config_din_addr_c(10),
            config_din_addr(9)=>config_din_addr_c(9),config_din_addr(8)=>config_din_addr_c(8),
            config_din_addr(7)=>config_din_addr_c(7),config_din_addr(6)=>config_din_addr_c(6),
            config_din_addr(5)=>config_din_addr_c(5),config_din_addr(4)=>config_din_addr_c(4),
            config_din_addr(3)=>config_din_addr_c(3),config_din_addr(2)=>config_din_addr_c(2),
            config_din_addr(1)=>config_din_addr_c(1),config_din_addr(0)=>config_din_addr_c(0),
            config_din_data(31)=>config_din_data_c(31),config_din_data(30)=>config_din_data_c(30),
            config_din_data(29)=>config_din_data_c(29),config_din_data(28)=>config_din_data_c(28),
            config_din_data(27)=>config_din_data_c(27),config_din_data(26)=>config_din_data_c(26),
            config_din_data(25)=>config_din_data_c(25),config_din_data(24)=>config_din_data_c(24),
            config_din_data(23)=>config_din_data_c(23),config_din_data(22)=>config_din_data_c(22),
            config_din_data(21)=>config_din_data_c(21),config_din_data(20)=>config_din_data_c(20),
            config_din_data(19)=>config_din_data_c(19),config_din_data(18)=>config_din_data_c(18),
            config_din_data(17)=>config_din_data_c(17),config_din_data(16)=>config_din_data_c(16),
            config_din_data(15)=>config_din_data_c(15),config_din_data(14)=>config_din_data_c(14),
            config_din_data(13)=>config_din_data_c(13),config_din_data(12)=>config_din_data_c(12),
            config_din_data(11)=>config_din_data_c(11),config_din_data(10)=>config_din_data_c(10),
            config_din_data(9)=>config_din_data_c(9),config_din_data(8)=>config_din_data_c(8),
            config_din_data(7)=>config_din_data_c(7),config_din_data(6)=>config_din_data_c(6),
            config_din_data(5)=>config_din_data_c(5),config_din_data(4)=>config_din_data_c(4),
            config_din_data(3)=>config_din_data_c(3),config_din_data(2)=>config_din_data_c(2),
            config_din_data(1)=>config_din_data_c(1),config_din_data(0)=>config_din_data_c(0),
            config_dout_valid=>config_pll_dout_valid,config_dout_addr(31)=>config_pll_dout_addr(31),
            config_dout_addr(30)=>config_pll_dout_addr(30),config_dout_addr(29)=>config_pll_dout_addr(29),
            config_dout_addr(28)=>config_pll_dout_addr(28),config_dout_addr(27)=>config_pll_dout_addr(27),
            config_dout_addr(26)=>config_pll_dout_addr(26),config_dout_addr(25)=>config_pll_dout_addr(25),
            config_dout_addr(24)=>config_pll_dout_addr(24),config_dout_addr(23)=>config_pll_dout_addr(23),
            config_dout_addr(22)=>config_pll_dout_addr(22),config_dout_addr(21)=>config_pll_dout_addr(21),
            config_dout_addr(20)=>config_pll_dout_addr(20),config_dout_addr(19)=>config_pll_dout_addr(19),
            config_dout_addr(18)=>config_pll_dout_addr(18),config_dout_addr(17)=>config_pll_dout_addr(17),
            config_dout_addr(16)=>config_pll_dout_addr(16),config_dout_addr(15)=>config_pll_dout_addr(15),
            config_dout_addr(14)=>config_pll_dout_addr(14),config_dout_addr(13)=>config_pll_dout_addr(13),
            config_dout_addr(12)=>config_pll_dout_addr(12),config_dout_addr(11)=>config_pll_dout_addr(11),
            config_dout_addr(10)=>config_pll_dout_addr(10),config_dout_addr(9)=>config_pll_dout_addr(9),
            config_dout_addr(8)=>config_pll_dout_addr(8),config_dout_addr(7)=>config_pll_dout_addr(7),
            config_dout_addr(6)=>config_pll_dout_addr(6),config_dout_addr(5)=>config_pll_dout_addr(5),
            config_dout_addr(4)=>config_pll_dout_addr(4),config_dout_addr(3)=>config_pll_dout_addr(3),
            config_dout_addr(2)=>config_pll_dout_addr(2),config_dout_addr(1)=>config_pll_dout_addr(1),
            config_dout_addr(0)=>config_pll_dout_addr(0),config_dout_data(31)=>config_pll_dout_data(31),
            config_dout_data(30)=>config_pll_dout_data(30),config_dout_data(29)=>config_pll_dout_data(29),
            config_dout_data(28)=>config_pll_dout_data(28),config_dout_data(27)=>config_pll_dout_data(27),
            config_dout_data(26)=>config_pll_dout_data(26),config_dout_data(25)=>config_pll_dout_data(25),
            config_dout_data(24)=>config_pll_dout_data(24),config_dout_data(23)=>config_pll_dout_data(23),
            config_dout_data(22)=>config_pll_dout_data(22),config_dout_data(21)=>config_pll_dout_data(21),
            config_dout_data(20)=>config_pll_dout_data(20),config_dout_data(19)=>config_pll_dout_data(19),
            config_dout_data(18)=>config_pll_dout_data(18),config_dout_data(17)=>config_pll_dout_data(17),
            config_dout_data(16)=>config_pll_dout_data(16),config_dout_data(15)=>config_pll_dout_data(15),
            config_dout_data(14)=>config_pll_dout_data(14),config_dout_data(13)=>config_pll_dout_data(13),
            config_dout_data(12)=>config_pll_dout_data(12),config_dout_data(11)=>config_pll_dout_data(11),
            config_dout_data(10)=>config_pll_dout_data(10),config_dout_data(9)=>config_pll_dout_data(9),
            config_dout_data(8)=>config_pll_dout_data(8),config_dout_data(7)=>config_pll_dout_data(7),
            config_dout_data(6)=>config_pll_dout_data(6),config_dout_data(5)=>config_pll_dout_data(5),
            config_dout_data(4)=>config_pll_dout_data(4),config_dout_data(3)=>config_pll_dout_data(3),
            config_dout_data(2)=>config_pll_dout_data(2),config_dout_data(1)=>config_pll_dout_data(1),
            config_dout_data(0)=>config_pll_dout_data(0),pll_spi_ck=>pll_spi_clk,
            pll_spi_mosi=>pll_spi_mosi,pll_spi_miso=>SPI_MISO_c,pll_spi_en=>PLL_LE_c);   -- ADU_top.v(93)
    adca_top_i: component \adc_top(CONFIG_BASE_ADDR=32'b01000000,N=0)\ port map (init_clk=>init_clk_c,
            init_rst=>n4,adc_config_done=>adca_config_done,config_din_valid=>config_din_valid_c,
            config_din_addr(31)=>config_din_addr_c(31),config_din_addr(30)=>config_din_addr_c(30),
            config_din_addr(29)=>config_din_addr_c(29),config_din_addr(28)=>config_din_addr_c(28),
            config_din_addr(27)=>config_din_addr_c(27),config_din_addr(26)=>config_din_addr_c(26),
            config_din_addr(25)=>config_din_addr_c(25),config_din_addr(24)=>config_din_addr_c(24),
            config_din_addr(23)=>config_din_addr_c(23),config_din_addr(22)=>config_din_addr_c(22),
            config_din_addr(21)=>config_din_addr_c(21),config_din_addr(20)=>config_din_addr_c(20),
            config_din_addr(19)=>config_din_addr_c(19),config_din_addr(18)=>config_din_addr_c(18),
            config_din_addr(17)=>config_din_addr_c(17),config_din_addr(16)=>config_din_addr_c(16),
            config_din_addr(15)=>config_din_addr_c(15),config_din_addr(14)=>config_din_addr_c(14),
            config_din_addr(13)=>config_din_addr_c(13),config_din_addr(12)=>config_din_addr_c(12),
            config_din_addr(11)=>config_din_addr_c(11),config_din_addr(10)=>config_din_addr_c(10),
            config_din_addr(9)=>config_din_addr_c(9),config_din_addr(8)=>config_din_addr_c(8),
            config_din_addr(7)=>config_din_addr_c(7),config_din_addr(6)=>config_din_addr_c(6),
            config_din_addr(5)=>config_din_addr_c(5),config_din_addr(4)=>config_din_addr_c(4),
            config_din_addr(3)=>config_din_addr_c(3),config_din_addr(2)=>config_din_addr_c(2),
            config_din_addr(1)=>config_din_addr_c(1),config_din_addr(0)=>config_din_addr_c(0),
            config_din_data(31)=>config_din_data_c(31),config_din_data(30)=>config_din_data_c(30),
            config_din_data(29)=>config_din_data_c(29),config_din_data(28)=>config_din_data_c(28),
            config_din_data(27)=>config_din_data_c(27),config_din_data(26)=>config_din_data_c(26),
            config_din_data(25)=>config_din_data_c(25),config_din_data(24)=>config_din_data_c(24),
            config_din_data(23)=>config_din_data_c(23),config_din_data(22)=>config_din_data_c(22),
            config_din_data(21)=>config_din_data_c(21),config_din_data(20)=>config_din_data_c(20),
            config_din_data(19)=>config_din_data_c(19),config_din_data(18)=>config_din_data_c(18),
            config_din_data(17)=>config_din_data_c(17),config_din_data(16)=>config_din_data_c(16),
            config_din_data(15)=>config_din_data_c(15),config_din_data(14)=>config_din_data_c(14),
            config_din_data(13)=>config_din_data_c(13),config_din_data(12)=>config_din_data_c(12),
            config_din_data(11)=>config_din_data_c(11),config_din_data(10)=>config_din_data_c(10),
            config_din_data(9)=>config_din_data_c(9),config_din_data(8)=>config_din_data_c(8),
            config_din_data(7)=>config_din_data_c(7),config_din_data(6)=>config_din_data_c(6),
            config_din_data(5)=>config_din_data_c(5),config_din_data(4)=>config_din_data_c(4),
            config_din_data(3)=>config_din_data_c(3),config_din_data(2)=>config_din_data_c(2),
            config_din_data(1)=>config_din_data_c(1),config_din_data(0)=>config_din_data_c(0),
            config_dout_valid=>config_adca_dout_valid,config_dout_addr(31)=>config_adca_dout_addr(31),
            config_dout_addr(30)=>config_adca_dout_addr(30),config_dout_addr(29)=>config_adca_dout_addr(29),
            config_dout_addr(28)=>config_adca_dout_addr(28),config_dout_addr(27)=>config_adca_dout_addr(27),
            config_dout_addr(26)=>config_adca_dout_addr(26),config_dout_addr(25)=>config_adca_dout_addr(25),
            config_dout_addr(24)=>config_adca_dout_addr(24),config_dout_addr(23)=>config_adca_dout_addr(23),
            config_dout_addr(22)=>config_adca_dout_addr(22),config_dout_addr(21)=>config_adca_dout_addr(21),
            config_dout_addr(20)=>config_adca_dout_addr(20),config_dout_addr(19)=>config_adca_dout_addr(19),
            config_dout_addr(18)=>config_adca_dout_addr(18),config_dout_addr(17)=>config_adca_dout_addr(17),
            config_dout_addr(16)=>config_adca_dout_addr(16),config_dout_addr(15)=>config_adca_dout_addr(15),
            config_dout_addr(14)=>config_adca_dout_addr(14),config_dout_addr(13)=>config_adca_dout_addr(13),
            config_dout_addr(12)=>config_adca_dout_addr(12),config_dout_addr(11)=>config_adca_dout_addr(11),
            config_dout_addr(10)=>config_adca_dout_addr(10),config_dout_addr(9)=>config_adca_dout_addr(9),
            config_dout_addr(8)=>config_adca_dout_addr(8),config_dout_addr(7)=>config_adca_dout_addr(7),
            config_dout_addr(6)=>config_adca_dout_addr(6),config_dout_addr(5)=>config_adca_dout_addr(5),
            config_dout_addr(4)=>config_adca_dout_addr(4),config_dout_addr(3)=>config_adca_dout_addr(3),
            config_dout_addr(2)=>config_adca_dout_addr(2),config_dout_addr(1)=>config_adca_dout_addr(1),
            config_dout_addr(0)=>config_adca_dout_addr(0),config_dout_data(31)=>config_adca_dout_data(31),
            config_dout_data(30)=>config_adca_dout_data(30),config_dout_data(29)=>config_adca_dout_data(29),
            config_dout_data(28)=>config_adca_dout_data(28),config_dout_data(27)=>config_adca_dout_data(27),
            config_dout_data(26)=>config_adca_dout_data(26),config_dout_data(25)=>config_adca_dout_data(25),
            config_dout_data(24)=>config_adca_dout_data(24),config_dout_data(23)=>config_adca_dout_data(23),
            config_dout_data(22)=>config_adca_dout_data(22),config_dout_data(21)=>config_adca_dout_data(21),
            config_dout_data(20)=>config_adca_dout_data(20),config_dout_data(19)=>config_adca_dout_data(19),
            config_dout_data(18)=>config_adca_dout_data(18),config_dout_data(17)=>config_adca_dout_data(17),
            config_dout_data(16)=>config_adca_dout_data(16),config_dout_data(15)=>config_adca_dout_data(15),
            config_dout_data(14)=>config_adca_dout_data(14),config_dout_data(13)=>config_adca_dout_data(13),
            config_dout_data(12)=>config_adca_dout_data(12),config_dout_data(11)=>config_adca_dout_data(11),
            config_dout_data(10)=>config_adca_dout_data(10),config_dout_data(9)=>config_adca_dout_data(9),
            config_dout_data(8)=>config_adca_dout_data(8),config_dout_data(7)=>config_adca_dout_data(7),
            config_dout_data(6)=>config_adca_dout_data(6),config_dout_data(5)=>config_adca_dout_data(5),
            config_dout_data(4)=>config_adca_dout_data(4),config_dout_data(3)=>config_adca_dout_data(3),
            config_dout_data(2)=>config_adca_dout_data(2),config_dout_data(1)=>config_adca_dout_data(1),
            config_dout_data(0)=>config_adca_dout_data(0),data_from_iserdes(255)=>dataa_from_iserdes(255),
            data_from_iserdes(254)=>dataa_from_iserdes(254),data_from_iserdes(253)=>dataa_from_iserdes(253),
            data_from_iserdes(252)=>dataa_from_iserdes(252),data_from_iserdes(251)=>dataa_from_iserdes(251),
            data_from_iserdes(250)=>dataa_from_iserdes(250),data_from_iserdes(249)=>dataa_from_iserdes(249),
            data_from_iserdes(248)=>dataa_from_iserdes(248),data_from_iserdes(247)=>dataa_from_iserdes(247),
            data_from_iserdes(246)=>dataa_from_iserdes(246),data_from_iserdes(245)=>dataa_from_iserdes(245),
            data_from_iserdes(244)=>dataa_from_iserdes(244),data_from_iserdes(243)=>dataa_from_iserdes(243),
            data_from_iserdes(242)=>dataa_from_iserdes(242),data_from_iserdes(241)=>dataa_from_iserdes(241),
            data_from_iserdes(240)=>dataa_from_iserdes(240),data_from_iserdes(239)=>dataa_from_iserdes(239),
            data_from_iserdes(238)=>dataa_from_iserdes(238),data_from_iserdes(237)=>dataa_from_iserdes(237),
            data_from_iserdes(236)=>dataa_from_iserdes(236),data_from_iserdes(235)=>dataa_from_iserdes(235),
            data_from_iserdes(234)=>dataa_from_iserdes(234),data_from_iserdes(233)=>dataa_from_iserdes(233),
            data_from_iserdes(232)=>dataa_from_iserdes(232),data_from_iserdes(231)=>dataa_from_iserdes(231),
            data_from_iserdes(230)=>dataa_from_iserdes(230),data_from_iserdes(229)=>dataa_from_iserdes(229),
            data_from_iserdes(228)=>dataa_from_iserdes(228),data_from_iserdes(227)=>dataa_from_iserdes(227),
            data_from_iserdes(226)=>dataa_from_iserdes(226),data_from_iserdes(225)=>dataa_from_iserdes(225),
            data_from_iserdes(224)=>dataa_from_iserdes(224),data_from_iserdes(223)=>dataa_from_iserdes(223),
            data_from_iserdes(222)=>dataa_from_iserdes(222),data_from_iserdes(221)=>dataa_from_iserdes(221),
            data_from_iserdes(220)=>dataa_from_iserdes(220),data_from_iserdes(219)=>dataa_from_iserdes(219),
            data_from_iserdes(218)=>dataa_from_iserdes(218),data_from_iserdes(217)=>dataa_from_iserdes(217),
            data_from_iserdes(216)=>dataa_from_iserdes(216),data_from_iserdes(215)=>dataa_from_iserdes(215),
            data_from_iserdes(214)=>dataa_from_iserdes(214),data_from_iserdes(213)=>dataa_from_iserdes(213),
            data_from_iserdes(212)=>dataa_from_iserdes(212),data_from_iserdes(211)=>dataa_from_iserdes(211),
            data_from_iserdes(210)=>dataa_from_iserdes(210),data_from_iserdes(209)=>dataa_from_iserdes(209),
            data_from_iserdes(208)=>dataa_from_iserdes(208),data_from_iserdes(207)=>dataa_from_iserdes(207),
            data_from_iserdes(206)=>dataa_from_iserdes(206),data_from_iserdes(205)=>dataa_from_iserdes(205),
            data_from_iserdes(204)=>dataa_from_iserdes(204),data_from_iserdes(203)=>dataa_from_iserdes(203),
            data_from_iserdes(202)=>dataa_from_iserdes(202),data_from_iserdes(201)=>dataa_from_iserdes(201),
            data_from_iserdes(200)=>dataa_from_iserdes(200),data_from_iserdes(199)=>dataa_from_iserdes(199),
            data_from_iserdes(198)=>dataa_from_iserdes(198),data_from_iserdes(197)=>dataa_from_iserdes(197),
            data_from_iserdes(196)=>dataa_from_iserdes(196),data_from_iserdes(195)=>dataa_from_iserdes(195),
            data_from_iserdes(194)=>dataa_from_iserdes(194),data_from_iserdes(193)=>dataa_from_iserdes(193),
            data_from_iserdes(192)=>dataa_from_iserdes(192),data_from_iserdes(191)=>dataa_from_iserdes(191),
            data_from_iserdes(190)=>dataa_from_iserdes(190),data_from_iserdes(189)=>dataa_from_iserdes(189),
            data_from_iserdes(188)=>dataa_from_iserdes(188),data_from_iserdes(187)=>dataa_from_iserdes(187),
            data_from_iserdes(186)=>dataa_from_iserdes(186),data_from_iserdes(185)=>dataa_from_iserdes(185),
            data_from_iserdes(184)=>dataa_from_iserdes(184),data_from_iserdes(183)=>dataa_from_iserdes(183),
            data_from_iserdes(182)=>dataa_from_iserdes(182),data_from_iserdes(181)=>dataa_from_iserdes(181),
            data_from_iserdes(180)=>dataa_from_iserdes(180),data_from_iserdes(179)=>dataa_from_iserdes(179),
            data_from_iserdes(178)=>dataa_from_iserdes(178),data_from_iserdes(177)=>dataa_from_iserdes(177),
            data_from_iserdes(176)=>dataa_from_iserdes(176),data_from_iserdes(175)=>dataa_from_iserdes(175),
            data_from_iserdes(174)=>dataa_from_iserdes(174),data_from_iserdes(173)=>dataa_from_iserdes(173),
            data_from_iserdes(172)=>dataa_from_iserdes(172),data_from_iserdes(171)=>dataa_from_iserdes(171),
            data_from_iserdes(170)=>dataa_from_iserdes(170),data_from_iserdes(169)=>dataa_from_iserdes(169),
            data_from_iserdes(168)=>dataa_from_iserdes(168),data_from_iserdes(167)=>dataa_from_iserdes(167),
            data_from_iserdes(166)=>dataa_from_iserdes(166),data_from_iserdes(165)=>dataa_from_iserdes(165),
            data_from_iserdes(164)=>dataa_from_iserdes(164),data_from_iserdes(163)=>dataa_from_iserdes(163),
            data_from_iserdes(162)=>dataa_from_iserdes(162),data_from_iserdes(161)=>dataa_from_iserdes(161),
            data_from_iserdes(160)=>dataa_from_iserdes(160),data_from_iserdes(159)=>dataa_from_iserdes(159),
            data_from_iserdes(158)=>dataa_from_iserdes(158),data_from_iserdes(157)=>dataa_from_iserdes(157),
            data_from_iserdes(156)=>dataa_from_iserdes(156),data_from_iserdes(155)=>dataa_from_iserdes(155),
            data_from_iserdes(154)=>dataa_from_iserdes(154),data_from_iserdes(153)=>dataa_from_iserdes(153),
            data_from_iserdes(152)=>dataa_from_iserdes(152),data_from_iserdes(151)=>dataa_from_iserdes(151),
            data_from_iserdes(150)=>dataa_from_iserdes(150),data_from_iserdes(149)=>dataa_from_iserdes(149),
            data_from_iserdes(148)=>dataa_from_iserdes(148),data_from_iserdes(147)=>dataa_from_iserdes(147),
            data_from_iserdes(146)=>dataa_from_iserdes(146),data_from_iserdes(145)=>dataa_from_iserdes(145),
            data_from_iserdes(144)=>dataa_from_iserdes(144),data_from_iserdes(143)=>dataa_from_iserdes(143),
            data_from_iserdes(142)=>dataa_from_iserdes(142),data_from_iserdes(141)=>dataa_from_iserdes(141),
            data_from_iserdes(140)=>dataa_from_iserdes(140),data_from_iserdes(139)=>dataa_from_iserdes(139),
            data_from_iserdes(138)=>dataa_from_iserdes(138),data_from_iserdes(137)=>dataa_from_iserdes(137),
            data_from_iserdes(136)=>dataa_from_iserdes(136),data_from_iserdes(135)=>dataa_from_iserdes(135),
            data_from_iserdes(134)=>dataa_from_iserdes(134),data_from_iserdes(133)=>dataa_from_iserdes(133),
            data_from_iserdes(132)=>dataa_from_iserdes(132),data_from_iserdes(131)=>dataa_from_iserdes(131),
            data_from_iserdes(130)=>dataa_from_iserdes(130),data_from_iserdes(129)=>dataa_from_iserdes(129),
            data_from_iserdes(128)=>dataa_from_iserdes(128),data_from_iserdes(127)=>dataa_from_iserdes(127),
            data_from_iserdes(126)=>dataa_from_iserdes(126),data_from_iserdes(125)=>dataa_from_iserdes(125),
            data_from_iserdes(124)=>dataa_from_iserdes(124),data_from_iserdes(123)=>dataa_from_iserdes(123),
            data_from_iserdes(122)=>dataa_from_iserdes(122),data_from_iserdes(121)=>dataa_from_iserdes(121),
            data_from_iserdes(120)=>dataa_from_iserdes(120),data_from_iserdes(119)=>dataa_from_iserdes(119),
            data_from_iserdes(118)=>dataa_from_iserdes(118),data_from_iserdes(117)=>dataa_from_iserdes(117),
            data_from_iserdes(116)=>dataa_from_iserdes(116),data_from_iserdes(115)=>dataa_from_iserdes(115),
            data_from_iserdes(114)=>dataa_from_iserdes(114),data_from_iserdes(113)=>dataa_from_iserdes(113),
            data_from_iserdes(112)=>dataa_from_iserdes(112),data_from_iserdes(111)=>dataa_from_iserdes(111),
            data_from_iserdes(110)=>dataa_from_iserdes(110),data_from_iserdes(109)=>dataa_from_iserdes(109),
            data_from_iserdes(108)=>dataa_from_iserdes(108),data_from_iserdes(107)=>dataa_from_iserdes(107),
            data_from_iserdes(106)=>dataa_from_iserdes(106),data_from_iserdes(105)=>dataa_from_iserdes(105),
            data_from_iserdes(104)=>dataa_from_iserdes(104),data_from_iserdes(103)=>dataa_from_iserdes(103),
            data_from_iserdes(102)=>dataa_from_iserdes(102),data_from_iserdes(101)=>dataa_from_iserdes(101),
            data_from_iserdes(100)=>dataa_from_iserdes(100),data_from_iserdes(99)=>dataa_from_iserdes(99),
            data_from_iserdes(98)=>dataa_from_iserdes(98),data_from_iserdes(97)=>dataa_from_iserdes(97),
            data_from_iserdes(96)=>dataa_from_iserdes(96),data_from_iserdes(95)=>dataa_from_iserdes(95),
            data_from_iserdes(94)=>dataa_from_iserdes(94),data_from_iserdes(93)=>dataa_from_iserdes(93),
            data_from_iserdes(92)=>dataa_from_iserdes(92),data_from_iserdes(91)=>dataa_from_iserdes(91),
            data_from_iserdes(90)=>dataa_from_iserdes(90),data_from_iserdes(89)=>dataa_from_iserdes(89),
            data_from_iserdes(88)=>dataa_from_iserdes(88),data_from_iserdes(87)=>dataa_from_iserdes(87),
            data_from_iserdes(86)=>dataa_from_iserdes(86),data_from_iserdes(85)=>dataa_from_iserdes(85),
            data_from_iserdes(84)=>dataa_from_iserdes(84),data_from_iserdes(83)=>dataa_from_iserdes(83),
            data_from_iserdes(82)=>dataa_from_iserdes(82),data_from_iserdes(81)=>dataa_from_iserdes(81),
            data_from_iserdes(80)=>dataa_from_iserdes(80),data_from_iserdes(79)=>dataa_from_iserdes(79),
            data_from_iserdes(78)=>dataa_from_iserdes(78),data_from_iserdes(77)=>dataa_from_iserdes(77),
            data_from_iserdes(76)=>dataa_from_iserdes(76),data_from_iserdes(75)=>dataa_from_iserdes(75),
            data_from_iserdes(74)=>dataa_from_iserdes(74),data_from_iserdes(73)=>dataa_from_iserdes(73),
            data_from_iserdes(72)=>dataa_from_iserdes(72),data_from_iserdes(71)=>dataa_from_iserdes(71),
            data_from_iserdes(70)=>dataa_from_iserdes(70),data_from_iserdes(69)=>dataa_from_iserdes(69),
            data_from_iserdes(68)=>dataa_from_iserdes(68),data_from_iserdes(67)=>dataa_from_iserdes(67),
            data_from_iserdes(66)=>dataa_from_iserdes(66),data_from_iserdes(65)=>dataa_from_iserdes(65),
            data_from_iserdes(64)=>dataa_from_iserdes(64),data_from_iserdes(63)=>dataa_from_iserdes(63),
            data_from_iserdes(62)=>dataa_from_iserdes(62),data_from_iserdes(61)=>dataa_from_iserdes(61),
            data_from_iserdes(60)=>dataa_from_iserdes(60),data_from_iserdes(59)=>dataa_from_iserdes(59),
            data_from_iserdes(58)=>dataa_from_iserdes(58),data_from_iserdes(57)=>dataa_from_iserdes(57),
            data_from_iserdes(56)=>dataa_from_iserdes(56),data_from_iserdes(55)=>dataa_from_iserdes(55),
            data_from_iserdes(54)=>dataa_from_iserdes(54),data_from_iserdes(53)=>dataa_from_iserdes(53),
            data_from_iserdes(52)=>dataa_from_iserdes(52),data_from_iserdes(51)=>dataa_from_iserdes(51),
            data_from_iserdes(50)=>dataa_from_iserdes(50),data_from_iserdes(49)=>dataa_from_iserdes(49),
            data_from_iserdes(48)=>dataa_from_iserdes(48),data_from_iserdes(47)=>dataa_from_iserdes(47),
            data_from_iserdes(46)=>dataa_from_iserdes(46),data_from_iserdes(45)=>dataa_from_iserdes(45),
            data_from_iserdes(44)=>dataa_from_iserdes(44),data_from_iserdes(43)=>dataa_from_iserdes(43),
            data_from_iserdes(42)=>dataa_from_iserdes(42),data_from_iserdes(41)=>dataa_from_iserdes(41),
            data_from_iserdes(40)=>dataa_from_iserdes(40),data_from_iserdes(39)=>dataa_from_iserdes(39),
            data_from_iserdes(38)=>dataa_from_iserdes(38),data_from_iserdes(37)=>dataa_from_iserdes(37),
            data_from_iserdes(36)=>dataa_from_iserdes(36),data_from_iserdes(35)=>dataa_from_iserdes(35),
            data_from_iserdes(34)=>dataa_from_iserdes(34),data_from_iserdes(33)=>dataa_from_iserdes(33),
            data_from_iserdes(32)=>dataa_from_iserdes(32),data_from_iserdes(31)=>dataa_from_iserdes(31),
            data_from_iserdes(30)=>dataa_from_iserdes(30),data_from_iserdes(29)=>dataa_from_iserdes(29),
            data_from_iserdes(28)=>dataa_from_iserdes(28),data_from_iserdes(27)=>dataa_from_iserdes(27),
            data_from_iserdes(26)=>dataa_from_iserdes(26),data_from_iserdes(25)=>dataa_from_iserdes(25),
            data_from_iserdes(24)=>dataa_from_iserdes(24),data_from_iserdes(23)=>dataa_from_iserdes(23),
            data_from_iserdes(22)=>dataa_from_iserdes(22),data_from_iserdes(21)=>dataa_from_iserdes(21),
            data_from_iserdes(20)=>dataa_from_iserdes(20),data_from_iserdes(19)=>dataa_from_iserdes(19),
            data_from_iserdes(18)=>dataa_from_iserdes(18),data_from_iserdes(17)=>dataa_from_iserdes(17),
            data_from_iserdes(16)=>dataa_from_iserdes(16),data_from_iserdes(15)=>dataa_from_iserdes(15),
            data_from_iserdes(14)=>dataa_from_iserdes(14),data_from_iserdes(13)=>dataa_from_iserdes(13),
            data_from_iserdes(12)=>dataa_from_iserdes(12),data_from_iserdes(11)=>dataa_from_iserdes(11),
            data_from_iserdes(10)=>dataa_from_iserdes(10),data_from_iserdes(9)=>dataa_from_iserdes(9),
            data_from_iserdes(8)=>dataa_from_iserdes(8),data_from_iserdes(7)=>dataa_from_iserdes(7),
            data_from_iserdes(6)=>dataa_from_iserdes(6),data_from_iserdes(5)=>dataa_from_iserdes(5),
            data_from_iserdes(4)=>dataa_from_iserdes(4),data_from_iserdes(3)=>dataa_from_iserdes(3),
            data_from_iserdes(2)=>dataa_from_iserdes(2),data_from_iserdes(1)=>dataa_from_iserdes(1),
            data_from_iserdes(0)=>dataa_from_iserdes(0),adc_clkdiv(1)=>adca_clkdiv(1),
            adc_clkdiv(0)=>adca_clkdiv(0),adc_sync_p=>ADCA_SYNCP_c,adc_sync_n=>ADCA_SYNCN_c,
            adc_in_p(31)=>adcb_raw_data_c(14),adc_in_p(30)=>adcb_raw_data_c(14),
            adc_in_p(29)=>adcb_raw_data_c(14),adc_in_p(28)=>adcb_raw_data_c(14),
            adc_in_p(27)=>adcb_raw_data_c(14),adc_in_p(26)=>adcb_raw_data_c(14),
            adc_in_p(25)=>adcb_raw_data_c(14),adc_in_p(24)=>adcb_raw_data_c(14),
            adc_in_p(23)=>adcb_raw_data_c(14),adc_in_p(22)=>adcb_raw_data_c(14),
            adc_in_p(21)=>adcb_raw_data_c(14),adc_in_p(20)=>adcb_raw_data_c(14),
            adc_in_p(19)=>adcb_raw_data_c(14),adc_in_p(18)=>adcb_raw_data_c(14),
            adc_in_p(17)=>adcb_raw_data_c(14),adc_in_p(16)=>adcb_raw_data_c(14),
            adc_in_p(15)=>adcb_raw_data_c(14),adc_in_p(14)=>adcb_raw_data_c(14),
            adc_in_p(13)=>ADCA_DP_c(13),adc_in_p(12)=>ADCA_DP_c(12),adc_in_p(11)=>ADCA_DP_c(11),
            adc_in_p(10)=>ADCA_DP_c(10),adc_in_p(9)=>ADCA_DP_c(9),adc_in_p(8)=>ADCA_DP_c(8),
            adc_in_p(7)=>ADCA_DP_c(7),adc_in_p(6)=>ADCA_DP_c(6),adc_in_p(5)=>ADCA_DP_c(5),
            adc_in_p(4)=>ADCA_DP_c(4),adc_in_p(3)=>ADCA_DP_c(3),adc_in_p(2)=>ADCA_DP_c(2),
            adc_in_p(1)=>ADCA_DP_c(1),adc_in_p(0)=>ADCA_DP_c(0),adc_in_n(31)=>adcb_raw_data_c(14),
            adc_in_n(30)=>adcb_raw_data_c(14),adc_in_n(29)=>adcb_raw_data_c(14),
            adc_in_n(28)=>adcb_raw_data_c(14),adc_in_n(27)=>adcb_raw_data_c(14),
            adc_in_n(26)=>adcb_raw_data_c(14),adc_in_n(25)=>adcb_raw_data_c(14),
            adc_in_n(24)=>adcb_raw_data_c(14),adc_in_n(23)=>adcb_raw_data_c(14),
            adc_in_n(22)=>adcb_raw_data_c(14),adc_in_n(21)=>adcb_raw_data_c(14),
            adc_in_n(20)=>adcb_raw_data_c(14),adc_in_n(19)=>adcb_raw_data_c(14),
            adc_in_n(18)=>adcb_raw_data_c(14),adc_in_n(17)=>adcb_raw_data_c(14),
            adc_in_n(16)=>adcb_raw_data_c(14),adc_in_n(15)=>adcb_raw_data_c(14),
            adc_in_n(14)=>adcb_raw_data_c(14),adc_in_n(13)=>ADCA_DN_c(13),
            adc_in_n(12)=>ADCA_DN_c(12),adc_in_n(11)=>ADCA_DN_c(11),adc_in_n(10)=>ADCA_DN_c(10),
            adc_in_n(9)=>ADCA_DN_c(9),adc_in_n(8)=>ADCA_DN_c(8),adc_in_n(7)=>ADCA_DN_c(7),
            adc_in_n(6)=>ADCA_DN_c(6),adc_in_n(5)=>ADCA_DN_c(5),adc_in_n(4)=>ADCA_DN_c(4),
            adc_in_n(3)=>ADCA_DN_c(3),adc_in_n(2)=>ADCA_DN_c(2),adc_in_n(1)=>ADCA_DN_c(1),
            adc_in_n(0)=>ADCA_DN_c(0),adc_dr_p(1)=>adcb_raw_data_c(14),adc_dr_p(0)=>ADCA_DCLKP_c,
            adc_dr_n(1)=>adcb_raw_data_c(14),adc_dr_n(0)=>ADCA_DCLKN_c,adc_spi_csn=>ADCA_SCSB_c,
            adc_spi_sclk=>adca_spi_clk,adc_spi_mosi=>adca_spi_mosi,adc_spi_miso=>SPI_MISO_c);   -- ADU_top.v(163)
    n4 <= not pll_config_done;   -- ADU_top.v(165)
    adcb_top_i: component \adc_top(CONFIG_BASE_ADDR=32'b01100000,N=1)\ port map (init_clk=>init_clk_c,
            init_rst=>n5,adc_config_done=>adcb_config_done,config_din_valid=>config_din_valid_c,
            config_din_addr(31)=>config_din_addr_c(31),config_din_addr(30)=>config_din_addr_c(30),
            config_din_addr(29)=>config_din_addr_c(29),config_din_addr(28)=>config_din_addr_c(28),
            config_din_addr(27)=>config_din_addr_c(27),config_din_addr(26)=>config_din_addr_c(26),
            config_din_addr(25)=>config_din_addr_c(25),config_din_addr(24)=>config_din_addr_c(24),
            config_din_addr(23)=>config_din_addr_c(23),config_din_addr(22)=>config_din_addr_c(22),
            config_din_addr(21)=>config_din_addr_c(21),config_din_addr(20)=>config_din_addr_c(20),
            config_din_addr(19)=>config_din_addr_c(19),config_din_addr(18)=>config_din_addr_c(18),
            config_din_addr(17)=>config_din_addr_c(17),config_din_addr(16)=>config_din_addr_c(16),
            config_din_addr(15)=>config_din_addr_c(15),config_din_addr(14)=>config_din_addr_c(14),
            config_din_addr(13)=>config_din_addr_c(13),config_din_addr(12)=>config_din_addr_c(12),
            config_din_addr(11)=>config_din_addr_c(11),config_din_addr(10)=>config_din_addr_c(10),
            config_din_addr(9)=>config_din_addr_c(9),config_din_addr(8)=>config_din_addr_c(8),
            config_din_addr(7)=>config_din_addr_c(7),config_din_addr(6)=>config_din_addr_c(6),
            config_din_addr(5)=>config_din_addr_c(5),config_din_addr(4)=>config_din_addr_c(4),
            config_din_addr(3)=>config_din_addr_c(3),config_din_addr(2)=>config_din_addr_c(2),
            config_din_addr(1)=>config_din_addr_c(1),config_din_addr(0)=>config_din_addr_c(0),
            config_din_data(31)=>config_din_data_c(31),config_din_data(30)=>config_din_data_c(30),
            config_din_data(29)=>config_din_data_c(29),config_din_data(28)=>config_din_data_c(28),
            config_din_data(27)=>config_din_data_c(27),config_din_data(26)=>config_din_data_c(26),
            config_din_data(25)=>config_din_data_c(25),config_din_data(24)=>config_din_data_c(24),
            config_din_data(23)=>config_din_data_c(23),config_din_data(22)=>config_din_data_c(22),
            config_din_data(21)=>config_din_data_c(21),config_din_data(20)=>config_din_data_c(20),
            config_din_data(19)=>config_din_data_c(19),config_din_data(18)=>config_din_data_c(18),
            config_din_data(17)=>config_din_data_c(17),config_din_data(16)=>config_din_data_c(16),
            config_din_data(15)=>config_din_data_c(15),config_din_data(14)=>config_din_data_c(14),
            config_din_data(13)=>config_din_data_c(13),config_din_data(12)=>config_din_data_c(12),
            config_din_data(11)=>config_din_data_c(11),config_din_data(10)=>config_din_data_c(10),
            config_din_data(9)=>config_din_data_c(9),config_din_data(8)=>config_din_data_c(8),
            config_din_data(7)=>config_din_data_c(7),config_din_data(6)=>config_din_data_c(6),
            config_din_data(5)=>config_din_data_c(5),config_din_data(4)=>config_din_data_c(4),
            config_din_data(3)=>config_din_data_c(3),config_din_data(2)=>config_din_data_c(2),
            config_din_data(1)=>config_din_data_c(1),config_din_data(0)=>config_din_data_c(0),
            config_dout_valid=>config_adcb_dout_valid,config_dout_addr(31)=>config_adcb_dout_addr(31),
            config_dout_addr(30)=>config_adcb_dout_addr(30),config_dout_addr(29)=>config_adcb_dout_addr(29),
            config_dout_addr(28)=>config_adcb_dout_addr(28),config_dout_addr(27)=>config_adcb_dout_addr(27),
            config_dout_addr(26)=>config_adcb_dout_addr(26),config_dout_addr(25)=>config_adcb_dout_addr(25),
            config_dout_addr(24)=>config_adcb_dout_addr(24),config_dout_addr(23)=>config_adcb_dout_addr(23),
            config_dout_addr(22)=>config_adcb_dout_addr(22),config_dout_addr(21)=>config_adcb_dout_addr(21),
            config_dout_addr(20)=>config_adcb_dout_addr(20),config_dout_addr(19)=>config_adcb_dout_addr(19),
            config_dout_addr(18)=>config_adcb_dout_addr(18),config_dout_addr(17)=>config_adcb_dout_addr(17),
            config_dout_addr(16)=>config_adcb_dout_addr(16),config_dout_addr(15)=>config_adcb_dout_addr(15),
            config_dout_addr(14)=>config_adcb_dout_addr(14),config_dout_addr(13)=>config_adcb_dout_addr(13),
            config_dout_addr(12)=>config_adcb_dout_addr(12),config_dout_addr(11)=>config_adcb_dout_addr(11),
            config_dout_addr(10)=>config_adcb_dout_addr(10),config_dout_addr(9)=>config_adcb_dout_addr(9),
            config_dout_addr(8)=>config_adcb_dout_addr(8),config_dout_addr(7)=>config_adcb_dout_addr(7),
            config_dout_addr(6)=>config_adcb_dout_addr(6),config_dout_addr(5)=>config_adcb_dout_addr(5),
            config_dout_addr(4)=>config_adcb_dout_addr(4),config_dout_addr(3)=>config_adcb_dout_addr(3),
            config_dout_addr(2)=>config_adcb_dout_addr(2),config_dout_addr(1)=>config_adcb_dout_addr(1),
            config_dout_addr(0)=>config_adcb_dout_addr(0),config_dout_data(31)=>config_adcb_dout_data(31),
            config_dout_data(30)=>config_adcb_dout_data(30),config_dout_data(29)=>config_adcb_dout_data(29),
            config_dout_data(28)=>config_adcb_dout_data(28),config_dout_data(27)=>config_adcb_dout_data(27),
            config_dout_data(26)=>config_adcb_dout_data(26),config_dout_data(25)=>config_adcb_dout_data(25),
            config_dout_data(24)=>config_adcb_dout_data(24),config_dout_data(23)=>config_adcb_dout_data(23),
            config_dout_data(22)=>config_adcb_dout_data(22),config_dout_data(21)=>config_adcb_dout_data(21),
            config_dout_data(20)=>config_adcb_dout_data(20),config_dout_data(19)=>config_adcb_dout_data(19),
            config_dout_data(18)=>config_adcb_dout_data(18),config_dout_data(17)=>config_adcb_dout_data(17),
            config_dout_data(16)=>config_adcb_dout_data(16),config_dout_data(15)=>config_adcb_dout_data(15),
            config_dout_data(14)=>config_adcb_dout_data(14),config_dout_data(13)=>config_adcb_dout_data(13),
            config_dout_data(12)=>config_adcb_dout_data(12),config_dout_data(11)=>config_adcb_dout_data(11),
            config_dout_data(10)=>config_adcb_dout_data(10),config_dout_data(9)=>config_adcb_dout_data(9),
            config_dout_data(8)=>config_adcb_dout_data(8),config_dout_data(7)=>config_adcb_dout_data(7),
            config_dout_data(6)=>config_adcb_dout_data(6),config_dout_data(5)=>config_adcb_dout_data(5),
            config_dout_data(4)=>config_adcb_dout_data(4),config_dout_data(3)=>config_adcb_dout_data(3),
            config_dout_data(2)=>config_adcb_dout_data(2),config_dout_data(1)=>config_adcb_dout_data(1),
            config_dout_data(0)=>config_adcb_dout_data(0),data_from_iserdes(255)=>datab_from_iserdes(255),
            data_from_iserdes(254)=>datab_from_iserdes(254),data_from_iserdes(253)=>datab_from_iserdes(253),
            data_from_iserdes(252)=>datab_from_iserdes(252),data_from_iserdes(251)=>datab_from_iserdes(251),
            data_from_iserdes(250)=>datab_from_iserdes(250),data_from_iserdes(249)=>datab_from_iserdes(249),
            data_from_iserdes(248)=>datab_from_iserdes(248),data_from_iserdes(247)=>datab_from_iserdes(247),
            data_from_iserdes(246)=>datab_from_iserdes(246),data_from_iserdes(245)=>datab_from_iserdes(245),
            data_from_iserdes(244)=>datab_from_iserdes(244),data_from_iserdes(243)=>datab_from_iserdes(243),
            data_from_iserdes(242)=>datab_from_iserdes(242),data_from_iserdes(241)=>datab_from_iserdes(241),
            data_from_iserdes(240)=>datab_from_iserdes(240),data_from_iserdes(239)=>datab_from_iserdes(239),
            data_from_iserdes(238)=>datab_from_iserdes(238),data_from_iserdes(237)=>datab_from_iserdes(237),
            data_from_iserdes(236)=>datab_from_iserdes(236),data_from_iserdes(235)=>datab_from_iserdes(235),
            data_from_iserdes(234)=>datab_from_iserdes(234),data_from_iserdes(233)=>datab_from_iserdes(233),
            data_from_iserdes(232)=>datab_from_iserdes(232),data_from_iserdes(231)=>datab_from_iserdes(231),
            data_from_iserdes(230)=>datab_from_iserdes(230),data_from_iserdes(229)=>datab_from_iserdes(229),
            data_from_iserdes(228)=>datab_from_iserdes(228),data_from_iserdes(227)=>datab_from_iserdes(227),
            data_from_iserdes(226)=>datab_from_iserdes(226),data_from_iserdes(225)=>datab_from_iserdes(225),
            data_from_iserdes(224)=>datab_from_iserdes(224),data_from_iserdes(223)=>datab_from_iserdes(223),
            data_from_iserdes(222)=>datab_from_iserdes(222),data_from_iserdes(221)=>datab_from_iserdes(221),
            data_from_iserdes(220)=>datab_from_iserdes(220),data_from_iserdes(219)=>datab_from_iserdes(219),
            data_from_iserdes(218)=>datab_from_iserdes(218),data_from_iserdes(217)=>datab_from_iserdes(217),
            data_from_iserdes(216)=>datab_from_iserdes(216),data_from_iserdes(215)=>datab_from_iserdes(215),
            data_from_iserdes(214)=>datab_from_iserdes(214),data_from_iserdes(213)=>datab_from_iserdes(213),
            data_from_iserdes(212)=>datab_from_iserdes(212),data_from_iserdes(211)=>datab_from_iserdes(211),
            data_from_iserdes(210)=>datab_from_iserdes(210),data_from_iserdes(209)=>datab_from_iserdes(209),
            data_from_iserdes(208)=>datab_from_iserdes(208),data_from_iserdes(207)=>datab_from_iserdes(207),
            data_from_iserdes(206)=>datab_from_iserdes(206),data_from_iserdes(205)=>datab_from_iserdes(205),
            data_from_iserdes(204)=>datab_from_iserdes(204),data_from_iserdes(203)=>datab_from_iserdes(203),
            data_from_iserdes(202)=>datab_from_iserdes(202),data_from_iserdes(201)=>datab_from_iserdes(201),
            data_from_iserdes(200)=>datab_from_iserdes(200),data_from_iserdes(199)=>datab_from_iserdes(199),
            data_from_iserdes(198)=>datab_from_iserdes(198),data_from_iserdes(197)=>datab_from_iserdes(197),
            data_from_iserdes(196)=>datab_from_iserdes(196),data_from_iserdes(195)=>datab_from_iserdes(195),
            data_from_iserdes(194)=>datab_from_iserdes(194),data_from_iserdes(193)=>datab_from_iserdes(193),
            data_from_iserdes(192)=>datab_from_iserdes(192),data_from_iserdes(191)=>datab_from_iserdes(191),
            data_from_iserdes(190)=>datab_from_iserdes(190),data_from_iserdes(189)=>datab_from_iserdes(189),
            data_from_iserdes(188)=>datab_from_iserdes(188),data_from_iserdes(187)=>datab_from_iserdes(187),
            data_from_iserdes(186)=>datab_from_iserdes(186),data_from_iserdes(185)=>datab_from_iserdes(185),
            data_from_iserdes(184)=>datab_from_iserdes(184),data_from_iserdes(183)=>datab_from_iserdes(183),
            data_from_iserdes(182)=>datab_from_iserdes(182),data_from_iserdes(181)=>datab_from_iserdes(181),
            data_from_iserdes(180)=>datab_from_iserdes(180),data_from_iserdes(179)=>datab_from_iserdes(179),
            data_from_iserdes(178)=>datab_from_iserdes(178),data_from_iserdes(177)=>datab_from_iserdes(177),
            data_from_iserdes(176)=>datab_from_iserdes(176),data_from_iserdes(175)=>datab_from_iserdes(175),
            data_from_iserdes(174)=>datab_from_iserdes(174),data_from_iserdes(173)=>datab_from_iserdes(173),
            data_from_iserdes(172)=>datab_from_iserdes(172),data_from_iserdes(171)=>datab_from_iserdes(171),
            data_from_iserdes(170)=>datab_from_iserdes(170),data_from_iserdes(169)=>datab_from_iserdes(169),
            data_from_iserdes(168)=>datab_from_iserdes(168),data_from_iserdes(167)=>datab_from_iserdes(167),
            data_from_iserdes(166)=>datab_from_iserdes(166),data_from_iserdes(165)=>datab_from_iserdes(165),
            data_from_iserdes(164)=>datab_from_iserdes(164),data_from_iserdes(163)=>datab_from_iserdes(163),
            data_from_iserdes(162)=>datab_from_iserdes(162),data_from_iserdes(161)=>datab_from_iserdes(161),
            data_from_iserdes(160)=>datab_from_iserdes(160),data_from_iserdes(159)=>datab_from_iserdes(159),
            data_from_iserdes(158)=>datab_from_iserdes(158),data_from_iserdes(157)=>datab_from_iserdes(157),
            data_from_iserdes(156)=>datab_from_iserdes(156),data_from_iserdes(155)=>datab_from_iserdes(155),
            data_from_iserdes(154)=>datab_from_iserdes(154),data_from_iserdes(153)=>datab_from_iserdes(153),
            data_from_iserdes(152)=>datab_from_iserdes(152),data_from_iserdes(151)=>datab_from_iserdes(151),
            data_from_iserdes(150)=>datab_from_iserdes(150),data_from_iserdes(149)=>datab_from_iserdes(149),
            data_from_iserdes(148)=>datab_from_iserdes(148),data_from_iserdes(147)=>datab_from_iserdes(147),
            data_from_iserdes(146)=>datab_from_iserdes(146),data_from_iserdes(145)=>datab_from_iserdes(145),
            data_from_iserdes(144)=>datab_from_iserdes(144),data_from_iserdes(143)=>datab_from_iserdes(143),
            data_from_iserdes(142)=>datab_from_iserdes(142),data_from_iserdes(141)=>datab_from_iserdes(141),
            data_from_iserdes(140)=>datab_from_iserdes(140),data_from_iserdes(139)=>datab_from_iserdes(139),
            data_from_iserdes(138)=>datab_from_iserdes(138),data_from_iserdes(137)=>datab_from_iserdes(137),
            data_from_iserdes(136)=>datab_from_iserdes(136),data_from_iserdes(135)=>datab_from_iserdes(135),
            data_from_iserdes(134)=>datab_from_iserdes(134),data_from_iserdes(133)=>datab_from_iserdes(133),
            data_from_iserdes(132)=>datab_from_iserdes(132),data_from_iserdes(131)=>datab_from_iserdes(131),
            data_from_iserdes(130)=>datab_from_iserdes(130),data_from_iserdes(129)=>datab_from_iserdes(129),
            data_from_iserdes(128)=>datab_from_iserdes(128),data_from_iserdes(127)=>datab_from_iserdes(127),
            data_from_iserdes(126)=>datab_from_iserdes(126),data_from_iserdes(125)=>datab_from_iserdes(125),
            data_from_iserdes(124)=>datab_from_iserdes(124),data_from_iserdes(123)=>datab_from_iserdes(123),
            data_from_iserdes(122)=>datab_from_iserdes(122),data_from_iserdes(121)=>datab_from_iserdes(121),
            data_from_iserdes(120)=>datab_from_iserdes(120),data_from_iserdes(119)=>datab_from_iserdes(119),
            data_from_iserdes(118)=>datab_from_iserdes(118),data_from_iserdes(117)=>datab_from_iserdes(117),
            data_from_iserdes(116)=>datab_from_iserdes(116),data_from_iserdes(115)=>datab_from_iserdes(115),
            data_from_iserdes(114)=>datab_from_iserdes(114),data_from_iserdes(113)=>datab_from_iserdes(113),
            data_from_iserdes(112)=>datab_from_iserdes(112),data_from_iserdes(111)=>datab_from_iserdes(111),
            data_from_iserdes(110)=>datab_from_iserdes(110),data_from_iserdes(109)=>datab_from_iserdes(109),
            data_from_iserdes(108)=>datab_from_iserdes(108),data_from_iserdes(107)=>datab_from_iserdes(107),
            data_from_iserdes(106)=>datab_from_iserdes(106),data_from_iserdes(105)=>datab_from_iserdes(105),
            data_from_iserdes(104)=>datab_from_iserdes(104),data_from_iserdes(103)=>datab_from_iserdes(103),
            data_from_iserdes(102)=>datab_from_iserdes(102),data_from_iserdes(101)=>datab_from_iserdes(101),
            data_from_iserdes(100)=>datab_from_iserdes(100),data_from_iserdes(99)=>datab_from_iserdes(99),
            data_from_iserdes(98)=>datab_from_iserdes(98),data_from_iserdes(97)=>datab_from_iserdes(97),
            data_from_iserdes(96)=>datab_from_iserdes(96),data_from_iserdes(95)=>datab_from_iserdes(95),
            data_from_iserdes(94)=>datab_from_iserdes(94),data_from_iserdes(93)=>datab_from_iserdes(93),
            data_from_iserdes(92)=>datab_from_iserdes(92),data_from_iserdes(91)=>datab_from_iserdes(91),
            data_from_iserdes(90)=>datab_from_iserdes(90),data_from_iserdes(89)=>datab_from_iserdes(89),
            data_from_iserdes(88)=>datab_from_iserdes(88),data_from_iserdes(87)=>datab_from_iserdes(87),
            data_from_iserdes(86)=>datab_from_iserdes(86),data_from_iserdes(85)=>datab_from_iserdes(85),
            data_from_iserdes(84)=>datab_from_iserdes(84),data_from_iserdes(83)=>datab_from_iserdes(83),
            data_from_iserdes(82)=>datab_from_iserdes(82),data_from_iserdes(81)=>datab_from_iserdes(81),
            data_from_iserdes(80)=>datab_from_iserdes(80),data_from_iserdes(79)=>datab_from_iserdes(79),
            data_from_iserdes(78)=>datab_from_iserdes(78),data_from_iserdes(77)=>datab_from_iserdes(77),
            data_from_iserdes(76)=>datab_from_iserdes(76),data_from_iserdes(75)=>datab_from_iserdes(75),
            data_from_iserdes(74)=>datab_from_iserdes(74),data_from_iserdes(73)=>datab_from_iserdes(73),
            data_from_iserdes(72)=>datab_from_iserdes(72),data_from_iserdes(71)=>datab_from_iserdes(71),
            data_from_iserdes(70)=>datab_from_iserdes(70),data_from_iserdes(69)=>datab_from_iserdes(69),
            data_from_iserdes(68)=>datab_from_iserdes(68),data_from_iserdes(67)=>datab_from_iserdes(67),
            data_from_iserdes(66)=>datab_from_iserdes(66),data_from_iserdes(65)=>datab_from_iserdes(65),
            data_from_iserdes(64)=>datab_from_iserdes(64),data_from_iserdes(63)=>datab_from_iserdes(63),
            data_from_iserdes(62)=>datab_from_iserdes(62),data_from_iserdes(61)=>datab_from_iserdes(61),
            data_from_iserdes(60)=>datab_from_iserdes(60),data_from_iserdes(59)=>datab_from_iserdes(59),
            data_from_iserdes(58)=>datab_from_iserdes(58),data_from_iserdes(57)=>datab_from_iserdes(57),
            data_from_iserdes(56)=>datab_from_iserdes(56),data_from_iserdes(55)=>datab_from_iserdes(55),
            data_from_iserdes(54)=>datab_from_iserdes(54),data_from_iserdes(53)=>datab_from_iserdes(53),
            data_from_iserdes(52)=>datab_from_iserdes(52),data_from_iserdes(51)=>datab_from_iserdes(51),
            data_from_iserdes(50)=>datab_from_iserdes(50),data_from_iserdes(49)=>datab_from_iserdes(49),
            data_from_iserdes(48)=>datab_from_iserdes(48),data_from_iserdes(47)=>datab_from_iserdes(47),
            data_from_iserdes(46)=>datab_from_iserdes(46),data_from_iserdes(45)=>datab_from_iserdes(45),
            data_from_iserdes(44)=>datab_from_iserdes(44),data_from_iserdes(43)=>datab_from_iserdes(43),
            data_from_iserdes(42)=>datab_from_iserdes(42),data_from_iserdes(41)=>datab_from_iserdes(41),
            data_from_iserdes(40)=>datab_from_iserdes(40),data_from_iserdes(39)=>datab_from_iserdes(39),
            data_from_iserdes(38)=>datab_from_iserdes(38),data_from_iserdes(37)=>datab_from_iserdes(37),
            data_from_iserdes(36)=>datab_from_iserdes(36),data_from_iserdes(35)=>datab_from_iserdes(35),
            data_from_iserdes(34)=>datab_from_iserdes(34),data_from_iserdes(33)=>datab_from_iserdes(33),
            data_from_iserdes(32)=>datab_from_iserdes(32),data_from_iserdes(31)=>datab_from_iserdes(31),
            data_from_iserdes(30)=>datab_from_iserdes(30),data_from_iserdes(29)=>datab_from_iserdes(29),
            data_from_iserdes(28)=>datab_from_iserdes(28),data_from_iserdes(27)=>datab_from_iserdes(27),
            data_from_iserdes(26)=>datab_from_iserdes(26),data_from_iserdes(25)=>datab_from_iserdes(25),
            data_from_iserdes(24)=>datab_from_iserdes(24),data_from_iserdes(23)=>datab_from_iserdes(23),
            data_from_iserdes(22)=>datab_from_iserdes(22),data_from_iserdes(21)=>datab_from_iserdes(21),
            data_from_iserdes(20)=>datab_from_iserdes(20),data_from_iserdes(19)=>datab_from_iserdes(19),
            data_from_iserdes(18)=>datab_from_iserdes(18),data_from_iserdes(17)=>datab_from_iserdes(17),
            data_from_iserdes(16)=>datab_from_iserdes(16),data_from_iserdes(15)=>datab_from_iserdes(15),
            data_from_iserdes(14)=>datab_from_iserdes(14),data_from_iserdes(13)=>datab_from_iserdes(13),
            data_from_iserdes(12)=>datab_from_iserdes(12),data_from_iserdes(11)=>datab_from_iserdes(11),
            data_from_iserdes(10)=>datab_from_iserdes(10),data_from_iserdes(9)=>datab_from_iserdes(9),
            data_from_iserdes(8)=>datab_from_iserdes(8),data_from_iserdes(7)=>datab_from_iserdes(7),
            data_from_iserdes(6)=>datab_from_iserdes(6),data_from_iserdes(5)=>datab_from_iserdes(5),
            data_from_iserdes(4)=>datab_from_iserdes(4),data_from_iserdes(3)=>datab_from_iserdes(3),
            data_from_iserdes(2)=>datab_from_iserdes(2),data_from_iserdes(1)=>datab_from_iserdes(1),
            data_from_iserdes(0)=>datab_from_iserdes(0),adc_clkdiv(1)=>adcb_clkdiv(1),
            adc_clkdiv(0)=>adcb_clkdiv(0),adc_sync_p=>ADCB_SYNCP_c,adc_sync_n=>ADCB_SYNCN_c,
            adc_in_p(31)=>adcb_raw_data_c(14),adc_in_p(30)=>adcb_raw_data_c(14),
            adc_in_p(29)=>adcb_raw_data_c(14),adc_in_p(28)=>adcb_raw_data_c(14),
            adc_in_p(27)=>adcb_raw_data_c(14),adc_in_p(26)=>adcb_raw_data_c(14),
            adc_in_p(25)=>adcb_raw_data_c(14),adc_in_p(24)=>adcb_raw_data_c(14),
            adc_in_p(23)=>adcb_raw_data_c(14),adc_in_p(22)=>adcb_raw_data_c(14),
            adc_in_p(21)=>adcb_raw_data_c(14),adc_in_p(20)=>adcb_raw_data_c(14),
            adc_in_p(19)=>adcb_raw_data_c(14),adc_in_p(18)=>adcb_raw_data_c(14),
            adc_in_p(17)=>adcb_raw_data_c(14),adc_in_p(16)=>adcb_raw_data_c(14),
            adc_in_p(15)=>adcb_raw_data_c(14),adc_in_p(14)=>adcb_raw_data_c(14),
            adc_in_p(13)=>ADCB_DP_c(13),adc_in_p(12)=>ADCB_DP_c(12),adc_in_p(11)=>ADCB_DP_c(11),
            adc_in_p(10)=>ADCB_DP_c(10),adc_in_p(9)=>ADCB_DP_c(9),adc_in_p(8)=>ADCB_DP_c(8),
            adc_in_p(7)=>ADCB_DP_c(7),adc_in_p(6)=>ADCB_DP_c(6),adc_in_p(5)=>ADCB_DP_c(5),
            adc_in_p(4)=>ADCB_DP_c(4),adc_in_p(3)=>ADCB_DP_c(3),adc_in_p(2)=>ADCB_DP_c(2),
            adc_in_p(1)=>ADCB_DP_c(1),adc_in_p(0)=>ADCB_DP_c(0),adc_in_n(31)=>adcb_raw_data_c(14),
            adc_in_n(30)=>adcb_raw_data_c(14),adc_in_n(29)=>adcb_raw_data_c(14),
            adc_in_n(28)=>adcb_raw_data_c(14),adc_in_n(27)=>adcb_raw_data_c(14),
            adc_in_n(26)=>adcb_raw_data_c(14),adc_in_n(25)=>adcb_raw_data_c(14),
            adc_in_n(24)=>adcb_raw_data_c(14),adc_in_n(23)=>adcb_raw_data_c(14),
            adc_in_n(22)=>adcb_raw_data_c(14),adc_in_n(21)=>adcb_raw_data_c(14),
            adc_in_n(20)=>adcb_raw_data_c(14),adc_in_n(19)=>adcb_raw_data_c(14),
            adc_in_n(18)=>adcb_raw_data_c(14),adc_in_n(17)=>adcb_raw_data_c(14),
            adc_in_n(16)=>adcb_raw_data_c(14),adc_in_n(15)=>adcb_raw_data_c(14),
            adc_in_n(14)=>adcb_raw_data_c(14),adc_in_n(13)=>ADCB_DN_c(13),
            adc_in_n(12)=>ADCB_DN_c(12),adc_in_n(11)=>ADCB_DN_c(11),adc_in_n(10)=>ADCB_DN_c(10),
            adc_in_n(9)=>ADCB_DN_c(9),adc_in_n(8)=>ADCB_DN_c(8),adc_in_n(7)=>ADCB_DN_c(7),
            adc_in_n(6)=>ADCB_DN_c(6),adc_in_n(5)=>ADCB_DN_c(5),adc_in_n(4)=>ADCB_DN_c(4),
            adc_in_n(3)=>ADCB_DN_c(3),adc_in_n(2)=>ADCB_DN_c(2),adc_in_n(1)=>ADCB_DN_c(1),
            adc_in_n(0)=>ADCB_DN_c(0),adc_dr_p(1)=>adcb_raw_data_c(14),adc_dr_p(0)=>ADCB_DCLKP_c,
            adc_dr_n(1)=>adcb_raw_data_c(14),adc_dr_n(0)=>ADCB_DCLKN_c,adc_spi_csn=>ADCB_SCSB_c,
            adc_spi_sclk=>adcb_spi_clk,adc_spi_mosi=>adcb_spi_mosi,adc_spi_miso=>SPI_MISO_c);   -- ADU_top.v(201)
    n5 <= not adca_config_done;   -- ADU_top.v(203)
    adcb_raw_data(114) <= not datab_from_iserdes(16);   -- ADU_top.v(242)
    adcb_raw_data(113) <= not datab_from_iserdes(8);   -- ADU_top.v(242)
    adcb_raw_data(112) <= not datab_from_iserdes(0);   -- ADU_top.v(242)
    adcb_raw_data(98) <= not datab_from_iserdes(17);   -- ADU_top.v(243)
    adcb_raw_data(97) <= not datab_from_iserdes(9);   -- ADU_top.v(243)
    adcb_raw_data(96) <= not datab_from_iserdes(1);   -- ADU_top.v(243)
    adcb_raw_data(82) <= not datab_from_iserdes(18);   -- ADU_top.v(244)
    adcb_raw_data(81) <= not datab_from_iserdes(10);   -- ADU_top.v(244)
    adcb_raw_data(80) <= not datab_from_iserdes(2);   -- ADU_top.v(244)
    adcb_raw_data(66) <= not datab_from_iserdes(19);   -- ADU_top.v(245)
    adcb_raw_data(65) <= not datab_from_iserdes(11);   -- ADU_top.v(245)
    adcb_raw_data(64) <= not datab_from_iserdes(3);   -- ADU_top.v(245)
    adcb_raw_data(50) <= not datab_from_iserdes(20);   -- ADU_top.v(246)
    adcb_raw_data(49) <= not datab_from_iserdes(12);   -- ADU_top.v(246)
    adcb_raw_data(48) <= not datab_from_iserdes(4);   -- ADU_top.v(246)
    adcb_raw_data(34) <= not datab_from_iserdes(21);   -- ADU_top.v(247)
    adcb_raw_data(33) <= not datab_from_iserdes(13);   -- ADU_top.v(247)
    adcb_raw_data(32) <= not datab_from_iserdes(5);   -- ADU_top.v(247)
    adcb_raw_data(18) <= not datab_from_iserdes(22);   -- ADU_top.v(248)
    adcb_raw_data(17) <= not datab_from_iserdes(14);   -- ADU_top.v(248)
    adcb_raw_data(16) <= not datab_from_iserdes(6);   -- ADU_top.v(248)
    adcb_raw_data(2) <= not datab_from_iserdes(23);   -- ADU_top.v(249)
    adcb_raw_data(1) <= not datab_from_iserdes(15);   -- ADU_top.v(249)
    adcb_raw_data(0) <= not datab_from_iserdes(7);   -- ADU_top.v(249)
    SPI_EN <= not init_rst_c;   -- ADU_top.v(308)
    n31 <= pll_spi_clk or adca_spi_clk;   -- ADU_top.v(309)
    SPI_CLK <= n31 or adcb_spi_clk;   -- ADU_top.v(309)
    n33 <= pll_spi_mosi or adca_spi_mosi;   -- ADU_top.v(310)
    SPI_MOSI <= n33 or adcb_spi_mosi;   -- ADU_top.v(310)
    n35 <= config_pll_dout_valid or config_adca_dout_valid;   -- ADU_top.v(312)
    config_dout_valid <= n35 or config_adcb_dout_valid;   -- ADU_top.v(312)
    n37 <= config_adcb_dout_addr(31) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n38 <= config_adcb_dout_addr(30) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n39 <= config_adcb_dout_addr(29) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n40 <= config_adcb_dout_addr(28) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n41 <= config_adcb_dout_addr(27) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n42 <= config_adcb_dout_addr(26) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n43 <= config_adcb_dout_addr(25) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n44 <= config_adcb_dout_addr(24) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n45 <= config_adcb_dout_addr(23) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n46 <= config_adcb_dout_addr(22) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n47 <= config_adcb_dout_addr(21) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n48 <= config_adcb_dout_addr(20) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n49 <= config_adcb_dout_addr(19) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n50 <= config_adcb_dout_addr(18) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n51 <= config_adcb_dout_addr(17) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n52 <= config_adcb_dout_addr(16) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n53 <= config_adcb_dout_addr(15) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n54 <= config_adcb_dout_addr(14) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n55 <= config_adcb_dout_addr(13) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n56 <= config_adcb_dout_addr(12) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n57 <= config_adcb_dout_addr(11) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n58 <= config_adcb_dout_addr(10) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n59 <= config_adcb_dout_addr(9) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n60 <= config_adcb_dout_addr(8) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n61 <= config_adcb_dout_addr(7) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n62 <= config_adcb_dout_addr(6) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n63 <= config_adcb_dout_addr(5) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n64 <= config_adcb_dout_addr(4) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n65 <= config_adcb_dout_addr(3) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n66 <= config_adcb_dout_addr(2) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n67 <= config_adcb_dout_addr(1) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n68 <= config_adcb_dout_addr(0) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(313)
    n69 <= config_adca_dout_addr(31) when config_adca_dout_valid='1' else n37;   -- ADU_top.v(313)
    n70 <= config_adca_dout_addr(30) when config_adca_dout_valid='1' else n38;   -- ADU_top.v(313)
    n71 <= config_adca_dout_addr(29) when config_adca_dout_valid='1' else n39;   -- ADU_top.v(313)
    n72 <= config_adca_dout_addr(28) when config_adca_dout_valid='1' else n40;   -- ADU_top.v(313)
    n73 <= config_adca_dout_addr(27) when config_adca_dout_valid='1' else n41;   -- ADU_top.v(313)
    n74 <= config_adca_dout_addr(26) when config_adca_dout_valid='1' else n42;   -- ADU_top.v(313)
    n75 <= config_adca_dout_addr(25) when config_adca_dout_valid='1' else n43;   -- ADU_top.v(313)
    n76 <= config_adca_dout_addr(24) when config_adca_dout_valid='1' else n44;   -- ADU_top.v(313)
    n77 <= config_adca_dout_addr(23) when config_adca_dout_valid='1' else n45;   -- ADU_top.v(313)
    n78 <= config_adca_dout_addr(22) when config_adca_dout_valid='1' else n46;   -- ADU_top.v(313)
    n79 <= config_adca_dout_addr(21) when config_adca_dout_valid='1' else n47;   -- ADU_top.v(313)
    n80 <= config_adca_dout_addr(20) when config_adca_dout_valid='1' else n48;   -- ADU_top.v(313)
    n81 <= config_adca_dout_addr(19) when config_adca_dout_valid='1' else n49;   -- ADU_top.v(313)
    n82 <= config_adca_dout_addr(18) when config_adca_dout_valid='1' else n50;   -- ADU_top.v(313)
    n83 <= config_adca_dout_addr(17) when config_adca_dout_valid='1' else n51;   -- ADU_top.v(313)
    n84 <= config_adca_dout_addr(16) when config_adca_dout_valid='1' else n52;   -- ADU_top.v(313)
    n85 <= config_adca_dout_addr(15) when config_adca_dout_valid='1' else n53;   -- ADU_top.v(313)
    n86 <= config_adca_dout_addr(14) when config_adca_dout_valid='1' else n54;   -- ADU_top.v(313)
    n87 <= config_adca_dout_addr(13) when config_adca_dout_valid='1' else n55;   -- ADU_top.v(313)
    n88 <= config_adca_dout_addr(12) when config_adca_dout_valid='1' else n56;   -- ADU_top.v(313)
    n89 <= config_adca_dout_addr(11) when config_adca_dout_valid='1' else n57;   -- ADU_top.v(313)
    n90 <= config_adca_dout_addr(10) when config_adca_dout_valid='1' else n58;   -- ADU_top.v(313)
    n91 <= config_adca_dout_addr(9) when config_adca_dout_valid='1' else n59;   -- ADU_top.v(313)
    n92 <= config_adca_dout_addr(8) when config_adca_dout_valid='1' else n60;   -- ADU_top.v(313)
    n93 <= config_adca_dout_addr(7) when config_adca_dout_valid='1' else n61;   -- ADU_top.v(313)
    n94 <= config_adca_dout_addr(6) when config_adca_dout_valid='1' else n62;   -- ADU_top.v(313)
    n95 <= config_adca_dout_addr(5) when config_adca_dout_valid='1' else n63;   -- ADU_top.v(313)
    n96 <= config_adca_dout_addr(4) when config_adca_dout_valid='1' else n64;   -- ADU_top.v(313)
    n97 <= config_adca_dout_addr(3) when config_adca_dout_valid='1' else n65;   -- ADU_top.v(313)
    n98 <= config_adca_dout_addr(2) when config_adca_dout_valid='1' else n66;   -- ADU_top.v(313)
    n99 <= config_adca_dout_addr(1) when config_adca_dout_valid='1' else n67;   -- ADU_top.v(313)
    n100 <= config_adca_dout_addr(0) when config_adca_dout_valid='1' else n68;   -- ADU_top.v(313)
    config_dout_addr(31) <= config_pll_dout_addr(31) when config_pll_dout_valid='1' else n69;   -- ADU_top.v(313)
    config_dout_addr(30) <= config_pll_dout_addr(30) when config_pll_dout_valid='1' else n70;   -- ADU_top.v(313)
    config_dout_addr(29) <= config_pll_dout_addr(29) when config_pll_dout_valid='1' else n71;   -- ADU_top.v(313)
    config_dout_addr(28) <= config_pll_dout_addr(28) when config_pll_dout_valid='1' else n72;   -- ADU_top.v(313)
    config_dout_addr(27) <= config_pll_dout_addr(27) when config_pll_dout_valid='1' else n73;   -- ADU_top.v(313)
    config_dout_addr(26) <= config_pll_dout_addr(26) when config_pll_dout_valid='1' else n74;   -- ADU_top.v(313)
    config_dout_addr(25) <= config_pll_dout_addr(25) when config_pll_dout_valid='1' else n75;   -- ADU_top.v(313)
    config_dout_addr(24) <= config_pll_dout_addr(24) when config_pll_dout_valid='1' else n76;   -- ADU_top.v(313)
    config_dout_addr(23) <= config_pll_dout_addr(23) when config_pll_dout_valid='1' else n77;   -- ADU_top.v(313)
    config_dout_addr(22) <= config_pll_dout_addr(22) when config_pll_dout_valid='1' else n78;   -- ADU_top.v(313)
    config_dout_addr(21) <= config_pll_dout_addr(21) when config_pll_dout_valid='1' else n79;   -- ADU_top.v(313)
    config_dout_addr(20) <= config_pll_dout_addr(20) when config_pll_dout_valid='1' else n80;   -- ADU_top.v(313)
    config_dout_addr(19) <= config_pll_dout_addr(19) when config_pll_dout_valid='1' else n81;   -- ADU_top.v(313)
    config_dout_addr(18) <= config_pll_dout_addr(18) when config_pll_dout_valid='1' else n82;   -- ADU_top.v(313)
    config_dout_addr(17) <= config_pll_dout_addr(17) when config_pll_dout_valid='1' else n83;   -- ADU_top.v(313)
    config_dout_addr(16) <= config_pll_dout_addr(16) when config_pll_dout_valid='1' else n84;   -- ADU_top.v(313)
    config_dout_addr(15) <= config_pll_dout_addr(15) when config_pll_dout_valid='1' else n85;   -- ADU_top.v(313)
    config_dout_addr(14) <= config_pll_dout_addr(14) when config_pll_dout_valid='1' else n86;   -- ADU_top.v(313)
    config_dout_addr(13) <= config_pll_dout_addr(13) when config_pll_dout_valid='1' else n87;   -- ADU_top.v(313)
    config_dout_addr(12) <= config_pll_dout_addr(12) when config_pll_dout_valid='1' else n88;   -- ADU_top.v(313)
    config_dout_addr(11) <= config_pll_dout_addr(11) when config_pll_dout_valid='1' else n89;   -- ADU_top.v(313)
    config_dout_addr(10) <= config_pll_dout_addr(10) when config_pll_dout_valid='1' else n90;   -- ADU_top.v(313)
    config_dout_addr(9) <= config_pll_dout_addr(9) when config_pll_dout_valid='1' else n91;   -- ADU_top.v(313)
    config_dout_addr(8) <= config_pll_dout_addr(8) when config_pll_dout_valid='1' else n92;   -- ADU_top.v(313)
    config_dout_addr(7) <= config_pll_dout_addr(7) when config_pll_dout_valid='1' else n93;   -- ADU_top.v(313)
    config_dout_addr(6) <= config_pll_dout_addr(6) when config_pll_dout_valid='1' else n94;   -- ADU_top.v(313)
    config_dout_addr(5) <= config_pll_dout_addr(5) when config_pll_dout_valid='1' else n95;   -- ADU_top.v(313)
    config_dout_addr(4) <= config_pll_dout_addr(4) when config_pll_dout_valid='1' else n96;   -- ADU_top.v(313)
    config_dout_addr(3) <= config_pll_dout_addr(3) when config_pll_dout_valid='1' else n97;   -- ADU_top.v(313)
    config_dout_addr(2) <= config_pll_dout_addr(2) when config_pll_dout_valid='1' else n98;   -- ADU_top.v(313)
    config_dout_addr(1) <= config_pll_dout_addr(1) when config_pll_dout_valid='1' else n99;   -- ADU_top.v(313)
    config_dout_addr(0) <= config_pll_dout_addr(0) when config_pll_dout_valid='1' else n100;   -- ADU_top.v(313)
    n133 <= config_adcb_dout_data(31) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n134 <= config_adcb_dout_data(30) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n135 <= config_adcb_dout_data(29) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n136 <= config_adcb_dout_data(28) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n137 <= config_adcb_dout_data(27) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n138 <= config_adcb_dout_data(26) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n139 <= config_adcb_dout_data(25) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n140 <= config_adcb_dout_data(24) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n141 <= config_adcb_dout_data(23) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n142 <= config_adcb_dout_data(22) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n143 <= config_adcb_dout_data(21) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n144 <= config_adcb_dout_data(20) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n145 <= config_adcb_dout_data(19) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n146 <= config_adcb_dout_data(18) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n147 <= config_adcb_dout_data(17) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n148 <= config_adcb_dout_data(16) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n149 <= config_adcb_dout_data(15) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n150 <= config_adcb_dout_data(14) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n151 <= config_adcb_dout_data(13) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n152 <= config_adcb_dout_data(12) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n153 <= config_adcb_dout_data(11) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n154 <= config_adcb_dout_data(10) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n155 <= config_adcb_dout_data(9) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n156 <= config_adcb_dout_data(8) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n157 <= config_adcb_dout_data(7) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n158 <= config_adcb_dout_data(6) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n159 <= config_adcb_dout_data(5) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n160 <= config_adcb_dout_data(4) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n161 <= config_adcb_dout_data(3) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n162 <= config_adcb_dout_data(2) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n163 <= config_adcb_dout_data(1) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n164 <= config_adcb_dout_data(0) when config_adcb_dout_valid='1' else adcb_raw_data_c(14);   -- ADU_top.v(314)
    n165 <= config_adca_dout_data(31) when config_adca_dout_valid='1' else n133;   -- ADU_top.v(314)
    n166 <= config_adca_dout_data(30) when config_adca_dout_valid='1' else n134;   -- ADU_top.v(314)
    n167 <= config_adca_dout_data(29) when config_adca_dout_valid='1' else n135;   -- ADU_top.v(314)
    n168 <= config_adca_dout_data(28) when config_adca_dout_valid='1' else n136;   -- ADU_top.v(314)
    n169 <= config_adca_dout_data(27) when config_adca_dout_valid='1' else n137;   -- ADU_top.v(314)
    n170 <= config_adca_dout_data(26) when config_adca_dout_valid='1' else n138;   -- ADU_top.v(314)
    n171 <= config_adca_dout_data(25) when config_adca_dout_valid='1' else n139;   -- ADU_top.v(314)
    n172 <= config_adca_dout_data(24) when config_adca_dout_valid='1' else n140;   -- ADU_top.v(314)
    n173 <= config_adca_dout_data(23) when config_adca_dout_valid='1' else n141;   -- ADU_top.v(314)
    n174 <= config_adca_dout_data(22) when config_adca_dout_valid='1' else n142;   -- ADU_top.v(314)
    n175 <= config_adca_dout_data(21) when config_adca_dout_valid='1' else n143;   -- ADU_top.v(314)
    n176 <= config_adca_dout_data(20) when config_adca_dout_valid='1' else n144;   -- ADU_top.v(314)
    n177 <= config_adca_dout_data(19) when config_adca_dout_valid='1' else n145;   -- ADU_top.v(314)
    n178 <= config_adca_dout_data(18) when config_adca_dout_valid='1' else n146;   -- ADU_top.v(314)
    n179 <= config_adca_dout_data(17) when config_adca_dout_valid='1' else n147;   -- ADU_top.v(314)
    n180 <= config_adca_dout_data(16) when config_adca_dout_valid='1' else n148;   -- ADU_top.v(314)
    n181 <= config_adca_dout_data(15) when config_adca_dout_valid='1' else n149;   -- ADU_top.v(314)
    n182 <= config_adca_dout_data(14) when config_adca_dout_valid='1' else n150;   -- ADU_top.v(314)
    n183 <= config_adca_dout_data(13) when config_adca_dout_valid='1' else n151;   -- ADU_top.v(314)
    n184 <= config_adca_dout_data(12) when config_adca_dout_valid='1' else n152;   -- ADU_top.v(314)
    n185 <= config_adca_dout_data(11) when config_adca_dout_valid='1' else n153;   -- ADU_top.v(314)
    n186 <= config_adca_dout_data(10) when config_adca_dout_valid='1' else n154;   -- ADU_top.v(314)
    n187 <= config_adca_dout_data(9) when config_adca_dout_valid='1' else n155;   -- ADU_top.v(314)
    n188 <= config_adca_dout_data(8) when config_adca_dout_valid='1' else n156;   -- ADU_top.v(314)
    n189 <= config_adca_dout_data(7) when config_adca_dout_valid='1' else n157;   -- ADU_top.v(314)
    n190 <= config_adca_dout_data(6) when config_adca_dout_valid='1' else n158;   -- ADU_top.v(314)
    n191 <= config_adca_dout_data(5) when config_adca_dout_valid='1' else n159;   -- ADU_top.v(314)
    n192 <= config_adca_dout_data(4) when config_adca_dout_valid='1' else n160;   -- ADU_top.v(314)
    n193 <= config_adca_dout_data(3) when config_adca_dout_valid='1' else n161;   -- ADU_top.v(314)
    n194 <= config_adca_dout_data(2) when config_adca_dout_valid='1' else n162;   -- ADU_top.v(314)
    n195 <= config_adca_dout_data(1) when config_adca_dout_valid='1' else n163;   -- ADU_top.v(314)
    n196 <= config_adca_dout_data(0) when config_adca_dout_valid='1' else n164;   -- ADU_top.v(314)
    config_dout_data(31) <= config_pll_dout_data(31) when config_pll_dout_valid='1' else n165;   -- ADU_top.v(314)
    config_dout_data(30) <= config_pll_dout_data(30) when config_pll_dout_valid='1' else n166;   -- ADU_top.v(314)
    config_dout_data(29) <= config_pll_dout_data(29) when config_pll_dout_valid='1' else n167;   -- ADU_top.v(314)
    config_dout_data(28) <= config_pll_dout_data(28) when config_pll_dout_valid='1' else n168;   -- ADU_top.v(314)
    config_dout_data(27) <= config_pll_dout_data(27) when config_pll_dout_valid='1' else n169;   -- ADU_top.v(314)
    config_dout_data(26) <= config_pll_dout_data(26) when config_pll_dout_valid='1' else n170;   -- ADU_top.v(314)
    config_dout_data(25) <= config_pll_dout_data(25) when config_pll_dout_valid='1' else n171;   -- ADU_top.v(314)
    config_dout_data(24) <= config_pll_dout_data(24) when config_pll_dout_valid='1' else n172;   -- ADU_top.v(314)
    config_dout_data(23) <= config_pll_dout_data(23) when config_pll_dout_valid='1' else n173;   -- ADU_top.v(314)
    config_dout_data(22) <= config_pll_dout_data(22) when config_pll_dout_valid='1' else n174;   -- ADU_top.v(314)
    config_dout_data(21) <= config_pll_dout_data(21) when config_pll_dout_valid='1' else n175;   -- ADU_top.v(314)
    config_dout_data(20) <= config_pll_dout_data(20) when config_pll_dout_valid='1' else n176;   -- ADU_top.v(314)
    config_dout_data(19) <= config_pll_dout_data(19) when config_pll_dout_valid='1' else n177;   -- ADU_top.v(314)
    config_dout_data(18) <= config_pll_dout_data(18) when config_pll_dout_valid='1' else n178;   -- ADU_top.v(314)
    config_dout_data(17) <= config_pll_dout_data(17) when config_pll_dout_valid='1' else n179;   -- ADU_top.v(314)
    config_dout_data(16) <= config_pll_dout_data(16) when config_pll_dout_valid='1' else n180;   -- ADU_top.v(314)
    config_dout_data(15) <= config_pll_dout_data(15) when config_pll_dout_valid='1' else n181;   -- ADU_top.v(314)
    config_dout_data(14) <= config_pll_dout_data(14) when config_pll_dout_valid='1' else n182;   -- ADU_top.v(314)
    config_dout_data(13) <= config_pll_dout_data(13) when config_pll_dout_valid='1' else n183;   -- ADU_top.v(314)
    config_dout_data(12) <= config_pll_dout_data(12) when config_pll_dout_valid='1' else n184;   -- ADU_top.v(314)
    config_dout_data(11) <= config_pll_dout_data(11) when config_pll_dout_valid='1' else n185;   -- ADU_top.v(314)
    config_dout_data(10) <= config_pll_dout_data(10) when config_pll_dout_valid='1' else n186;   -- ADU_top.v(314)
    config_dout_data(9) <= config_pll_dout_data(9) when config_pll_dout_valid='1' else n187;   -- ADU_top.v(314)
    config_dout_data(8) <= config_pll_dout_data(8) when config_pll_dout_valid='1' else n188;   -- ADU_top.v(314)
    config_dout_data(7) <= config_pll_dout_data(7) when config_pll_dout_valid='1' else n189;   -- ADU_top.v(314)
    config_dout_data(6) <= config_pll_dout_data(6) when config_pll_dout_valid='1' else n190;   -- ADU_top.v(314)
    config_dout_data(5) <= config_pll_dout_data(5) when config_pll_dout_valid='1' else n191;   -- ADU_top.v(314)
    config_dout_data(4) <= config_pll_dout_data(4) when config_pll_dout_valid='1' else n192;   -- ADU_top.v(314)
    config_dout_data(3) <= config_pll_dout_data(3) when config_pll_dout_valid='1' else n193;   -- ADU_top.v(314)
    config_dout_data(2) <= config_pll_dout_data(2) when config_pll_dout_valid='1' else n194;   -- ADU_top.v(314)
    config_dout_data(1) <= config_pll_dout_data(1) when config_pll_dout_valid='1' else n195;   -- ADU_top.v(314)
    config_dout_data(0) <= config_pll_dout_data(0) when config_pll_dout_valid='1' else n196;   -- ADU_top.v(314)
    i231: VERIFIC_DFFRS (d=>cal(20),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(19));   -- ADU_top.v(320)
    i232: VERIFIC_DFFRS (d=>cal(19),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(18));   -- ADU_top.v(320)
    i233: VERIFIC_DFFRS (d=>cal(18),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(17));   -- ADU_top.v(320)
    i234: VERIFIC_DFFRS (d=>cal(17),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(16));   -- ADU_top.v(320)
    i235: VERIFIC_DFFRS (d=>cal(16),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(15));   -- ADU_top.v(320)
    i236: VERIFIC_DFFRS (d=>cal(15),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(14));   -- ADU_top.v(320)
    i237: VERIFIC_DFFRS (d=>cal(14),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(13));   -- ADU_top.v(320)
    i238: VERIFIC_DFFRS (d=>cal(13),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(12));   -- ADU_top.v(320)
    i239: VERIFIC_DFFRS (d=>cal(12),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(11));   -- ADU_top.v(320)
    i240: VERIFIC_DFFRS (d=>cal(11),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(10));   -- ADU_top.v(320)
    i241: VERIFIC_DFFRS (d=>cal(10),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(9));   -- ADU_top.v(320)
    i242: VERIFIC_DFFRS (d=>cal(9),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(8));   -- ADU_top.v(320)
    i243: VERIFIC_DFFRS (d=>cal(8),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(7));   -- ADU_top.v(320)
    i244: VERIFIC_DFFRS (d=>cal(7),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(6));   -- ADU_top.v(320)
    i245: VERIFIC_DFFRS (d=>cal(6),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(5));   -- ADU_top.v(320)
    i246: VERIFIC_DFFRS (d=>cal(5),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(4));   -- ADU_top.v(320)
    i247: VERIFIC_DFFRS (d=>cal(4),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(3));   -- ADU_top.v(320)
    i248: VERIFIC_DFFRS (d=>cal(3),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(2));   -- ADU_top.v(320)
    i249: VERIFIC_DFFRS (d=>cal(2),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(1));   -- ADU_top.v(320)
    i250: VERIFIC_DFFRS (d=>cal(1),clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(0));   -- ADU_top.v(320)
    reduce_or_250: entity work.reduce_or_21(INTERFACE)  port map (a(20)=>cal(20),
            a(19)=>cal(19),a(18)=>cal(18),a(17)=>cal(17),a(16)=>cal(16),
            a(15)=>cal(15),a(14)=>cal(14),a(13)=>cal(13),a(12)=>cal(12),
            a(11)=>cal(11),a(10)=>cal(10),a(9)=>cal(9),a(8)=>cal(8),a(7)=>cal(7),
            a(6)=>cal(6),a(5)=>cal(5),a(4)=>cal(4),a(3)=>cal(3),a(2)=>cal(2),
            a(1)=>cal(1),a(0)=>cal(0),o=>CAL_CTRL);   -- ADU_top.v(325)
    rx_idelayctrl: component IDELAYCTRL port map (RDY=>idelayctrl_ready,REFCLK=>clk200,
            RST=>init_rst_c);   -- ADU_top.v(327)
    n252 <= '0' ;
    i230: VERIFIC_DFFRS (d=>test_pulse,clk=>init_clk_c,s=>n252,r=>adcb_raw_data_c(14),
            q=>cal(20));   -- ADU_top.v(320)
    
end architecture \.\;   -- ADU_top.v(21)

