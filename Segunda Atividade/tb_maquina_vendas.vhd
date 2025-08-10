LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY tb_maquina_vendas IS
END ENTITY tb_maquina_vendas;

ARCHITECTURE test OF tb_maquina_vendas IS
    -- Componente a ser testado
    COMPONENT maquina_vendas IS
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
    END COMPONENT;

    -- Sinais de estímulo e observação
    SIGNAL clk, rst, m, b1, b2, f1, f2, nt : STD_LOGIC := '0';
    SIGNAL v, r1, r2, vt                  : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    
    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    -- Instanciação do UUT (Unit Under Test)
    UUT: maquina_vendas
        PORT MAP (clk=>clk, rst=>rst, m=>m, v=>v, r1=>r1, r2=>r2, b1=>b1, b2=>b2, f1=>f1, f2=>f2, nt=>nt, vt=>vt);

    -- Geração de Clock
    PROCESS BEGIN
        clk <= '0'; WAIT FOR CLK_PERIOD/2;
        clk <= '1'; WAIT FOR CLK_PERIOD/2;
    END PROCESS;
    
    -- Processo de estímulo
    PROCESS
    BEGIN
        -- Define os preços dos produtos
        r1 <= std_logic_vector(to_unsigned(75, 8));  -- Produto 1 custa 75 centavos
        r2 <= std_logic_vector(to_unsigned(125, 8)); -- Produto 2 custa 125 centavos

        -- Inicia com um reset
        rst <= '1'; WAIT FOR CLK_PERIOD * 2;
        rst <= '0'; WAIT FOR CLK_PERIOD;
        
        -- Cenário 1: Tenta comprar produto 1 sem crédito
        b1 <= '1'; WAIT FOR CLK_PERIOD;
        b1 <= '0'; WAIT FOR CLK_PERIOD * 5; -- Espera-se que nada aconteça

        -- Cenário 2: Insere moedas e compra produto 1 com troco
        -- Inserindo 50 centavos
        m <= '1'; v <= std_logic_vector(to_unsigned(50, 8)); WAIT FOR CLK_PERIOD;
        m <= '0'; WAIT FOR CLK_PERIOD * 2;
        -- Inserindo 25 centavos (total 75)
        m <= '1'; v <= std_logic_vector(to_unsigned(25, 8)); WAIT FOR CLK_PERIOD;
        m <= '0'; WAIT FOR CLK_PERIOD * 2;
        -- Inserindo 10 centavos (total 85)
        m <= '1'; v <= std_logic_vector(to_unsigned(10, 8)); WAIT FOR CLK_PERIOD;
        m <= '0'; WAIT FOR CLK_PERIOD * 5;
        
        -- Pressiona o botão 1 para comprar
        b1 <= '1'; WAIT FOR CLK_PERIOD;
        b1 <= '0'; WAIT FOR CLK_PERIOD * 5; -- Espera-se f1=1, depois nt=1 e vt=10

        -- Cenário 3: Insere mais moedas e compra produto 2
        -- Inserindo 50 centavos
        m <= '1'; v <= std_logic_vector(to_unsigned(50, 8)); WAIT FOR CLK_PERIOD;
        m <= '0'; WAIT FOR CLK_PERIOD * 2;
        -- Inserindo 50 centavos (total 100)
        m <= '1'; v <= std_logic_vector(to_unsigned(50, 8)); WAIT FOR CLK_PERIOD;
        m <= '0'; WAIT FOR CLK_PERIOD * 2;
        -- Inserindo 25 centavos (total 125)
        m <= '1'; v <= std_logic_vector(to_unsigned(25, 8)); WAIT FOR CLK_PERIOD;
        m <= '0'; WAIT FOR CLK_PERIOD * 5;

        -- Pressiona o botão 2 para comprar
        b2 <= '1'; WAIT FOR CLK_PERIOD;
        b2 <= '0'; WAIT FOR CLK_PERIOD * 5; -- Espera-se f2=1, depois nt=1 e vt=0

        WAIT; -- Fim da simulação
    END PROCESS;

END ARCHITECTURE test;