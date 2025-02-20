
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VRV1_104_vhdl is
port
(
	GPIOA_IN			: in  std_logic_vector(31 downto 0);
	GPIOA_OUT			: out std_logic_vector(31 downto 0);
	GPIOA_OE			: out std_logic_vector(31 downto 0);

	UART1_TXD_O 	: out std_ulogic;
	UART1_RXD_I 	: in  std_ulogic := '0';

	SPIM1_SS    	: out std_logic_vector(3 downto 0);
	SPIM1_SCLK  	: out std_logic;
	SPIM1_MOSI  	: out std_logic;
	SPIM1_MISO  	: in  std_logic;

	JTAG_TCK			: in std_logic;
	JTAG_TDI			: in std_logic;
	JTAG_TDO			: out std_logic;
	JTAG_TMS			: in std_logic;

	APB_PADDR			: out std_logic_vector(19 downto 0);
	APB_PSEL			: out std_logic;
	APB_PENABLE		: out std_logic;
	APB_PREADY		: in  std_logic;
	APB_PWRITE		: out std_logic;
	APB_PWDATA		: out std_logic_vector(31 downto 0);
	APB_PRDATA		: in  std_logic_vector(31 downto 0);
	APB_PSLVERROR	: in  std_logic;

	RESET	      	: in std_ulogic := '0'; 	-- async reset, positive logic
	CLK_100	 			: in std_logic 						-- 100 MHz clock, fixed for the used SDRAM
);
end entity;

architecture behavioral of VRV1_104_vhdl
is
	component VRV1_104 is
	port
	(
		io_gpioA_read  				: in  std_logic_vector(31 downto 0);
		io_gpioA_write  			: out std_logic_vector(31 downto 0);
		io_gpioA_writeEnable  : out std_logic_vector(31 downto 0);

		io_uart1_rxd       		: in  std_logic;
		io_uart1_txd       		: out std_logic;

		io_spim1_ss   				: out std_logic_vector(3 downto 0);
		io_spim1_sclk 				: out std_logic;
		io_spim1_mosi 				: out std_logic;
		io_spim1_miso 				: in  std_logic;

		io_jtag_tms           : in  std_logic;
		io_jtag_tdi           : in  std_logic;
		io_jtag_tdo           : out std_logic;
		io_jtag_tck           : in  std_logic;

		io_apb2_PADDR					: out std_logic_vector(19 downto 0);
		io_apb2_PSEL					: out std_logic_vector(0 downto 0);
		io_apb2_PENABLE				: out std_logic;
		io_apb2_PREADY				: in  std_logic;
		io_apb2_PWRITE				: out std_logic;
		io_apb2_PWDATA				: out std_logic_vector(31 downto 0);
		io_apb2_PRDATA				: in  std_logic_vector(31 downto 0);
		io_apb2_PSLVERROR			: in  std_logic;

		io_timerExternal_clear  : in  std_logic;
		io_timerExternal_tick		: in  std_logic;
		io_coreInterrupt				: in  std_logic;

		io_mainClk              : in  std_logic;
		io_asyncReset           : in  std_logic
	);
	end component;

begin

	u0 : component VRV1_104
	port map
	(
		io_gpioA_read  				=> GPIOA_IN,
		io_gpioA_write  			=> GPIOA_OUT,
		io_gpioA_writeEnable  => GPIOA_OE,

		io_uart1_rxd       		=> UART1_RXD_I,
		io_uart1_txd       		=> UART1_TXD_O,

		io_spim1_ss   				=> SPIM1_SS,
		io_spim1_sclk 				=> SPIM1_SCLK,
		io_spim1_mosi 				=> SPIM1_MOSI,
		io_spim1_miso 				=> SPIM1_MISO,

		io_jtag_tms           => JTAG_TMS,
		io_jtag_tdi           => JTAG_TDI,
		io_jtag_tdo           => JTAG_TDO,
		io_jtag_tck           => JTAG_TCK,

		io_apb2_PADDR					=> APB_PADDR,
		io_apb2_PSEL(0)				=> APB_PSEL,
		io_apb2_PENABLE				=> APB_PENABLE,
		io_apb2_PREADY				=> APB_PREADY,
		io_apb2_PWRITE				=> APB_PWRITE,
		io_apb2_PWDATA				=> APB_PWDATA,
		io_apb2_PRDATA				=> APB_PRDATA,
		io_apb2_PSLVERROR			=> APB_PSLVERROR,

		io_timerExternal_clear  => '0',
		io_timerExternal_tick		=> '0',
		io_coreInterrupt				=> '0',

		io_mainClk              => CLK_100,
		io_asyncReset           => RESET
	);

end architecture;
