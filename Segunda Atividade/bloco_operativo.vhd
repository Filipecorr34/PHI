LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bloco_operativo IS
    PORT (
        clk             : IN  STD_LOGIC;
        rst             : IN  STD_LOGIC;
        -- Sinais de Controle do BC
        credito_clr     : IN  STD_LOGIC;
        credito_load    : IN  STD_LOGIC;
        troco_load      : IN  STD_LOGIC;
        sel_custo       : IN  STD_LOGIC;
        -- Entradas de Dados
        v               : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        r1, r2          : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        -- Saídas de Dados e Status
        vt              : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        credito_suficiente : OUT STD_LOGIC
    );
END ENTITY bloco_operativo;

ARCHITECTURE structural OF bloco_operativo IS
    SIGNAL credito_reg, credito_prox : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL troco_reg, troco_prox   : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL custo_selecionado      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL soma_credito           : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    -- Multiplexador para selecionar o custo do produto
    custo_selecionado <= r1 WHEN sel_custo = '0' ELSE r2;

    -- Componentes Aritméticos
    soma_credito <= std_logic_vector(unsigned(credito_reg) + unsigned(v));
    troco_prox   <= std_logic_vector(unsigned(credito_reg) - unsigned(custo_selecionado));

    -- Comparador
    credito_suficiente <= '1' WHEN unsigned(credito_reg) >= unsigned(custo_selecionado) ELSE '0';

    -- Registrador de Crédito
    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            credito_reg <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            IF (credito_clr = '1') THEN
                credito_reg <= (OTHERS => '0');
            ELSIF (credito_load = '1') THEN
                credito_reg <= soma_credito;
            END IF;
        END IF;
    END PROCESS;

    -- Registrador de Troco
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (troco_load = '1') THEN
                troco_reg <= troco_prox;
            END IF;
        END IF;
    END PROCESS;

    -- Saída do valor do troco
    vt <= troco_reg;

END ARCHITECTURE structural;