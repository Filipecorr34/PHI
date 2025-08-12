LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY maquina_vendas IS
    PORT (
        clk    : IN  STD_LOGIC;
        rst    : IN  STD_LOGIC;
        m      : IN  STD_LOGIC;
        v      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        r1, r2 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        b1, b2 : IN  STD_LOGIC;
        f1, f2 : OUT STD_LOGIC;
        nt     : OUT STD_LOGIC;
        vt     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY maquina_vendas;

ARCHITECTURE structural OF maquina_vendas IS
    -- Declaração dos componentes
    COMPONENT bloco_operativo IS
        PORT (
            clk             : IN  STD_LOGIC;
            rst             : IN  STD_LOGIC;
            credito_clr     : IN  STD_LOGIC;
            credito_load    : IN  STD_LOGIC;
            troco_load      : IN  STD_LOGIC;
            sel_custo       : IN  STD_LOGIC;
            v               : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            r1, r2          : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            vt              : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            credito_suficiente : OUT STD_LOGIC;
				troco_necessario   : OUT STD_LOGIC 

        );
    END COMPONENT;

    COMPONENT bloco_controle IS
        PORT (
            clk             : IN  STD_LOGIC;
            rst             : IN  STD_LOGIC;
            m               : IN  STD_LOGIC;
            b1, b2          : IN  STD_LOGIC;
            credito_suficiente : IN  STD_LOGIC;
				troco_necessario   : IN  STD_LOGIC;
            f1, f2          : OUT STD_LOGIC;
            nt              : OUT STD_LOGIC;
            credito_clr     : OUT STD_LOGIC;
            credito_load    : OUT STD_LOGIC;
            troco_load      : OUT STD_LOGIC;
            sel_custo       : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Sinais de interconexão BO <-> BC
    SIGNAL s_credito_suficiente : STD_LOGIC;
	 SIGNAL s_troco_necessario   : STD_LOGIC;
    SIGNAL s_credito_clr        : STD_LOGIC;
    SIGNAL s_credito_load       : STD_LOGIC;
    SIGNAL s_troco_load         : STD_LOGIC;
    SIGNAL s_sel_custo          : STD_LOGIC;

BEGIN
    -- Instanciação do Bloco Operativo
    BO_inst: bloco_operativo
        PORT MAP (
            clk             => clk,
            rst             => rst,
            credito_clr     => s_credito_clr,
            credito_load    => s_credito_load,
            troco_load      => s_troco_load,
            sel_custo       => s_sel_custo,
            v               => v,
            r1              => r1,
            r2              => r2,
            vt              => vt,
            credito_suficiente => s_credito_suficiente,
				troco_necessario   => s_troco_necessario
        );

    -- Instanciação do Bloco de Controle
    BC_inst: bloco_controle
        PORT MAP (
            clk             => clk,
            rst             => rst,
            m               => m,
            b1              => b1,
            b2              => b2,
            credito_suficiente => s_credito_suficiente,
				troco_necessario   => s_troco_necessario,
            f1              => f1,
            f2              => f2,
            nt              => nt,
            credito_clr     => s_credito_clr,
            credito_load    => s_credito_load,
            troco_load      => s_troco_load,
            sel_custo       => s_sel_custo
        );

END ARCHITECTURE structural;
