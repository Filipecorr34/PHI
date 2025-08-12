LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bloco_controle IS
    PORT (
        clk                 : IN  STD_LOGIC;
        rst                 : IN  STD_LOGIC;
        m                   : IN  STD_LOGIC;
        b1, b2              : IN  STD_LOGIC;
        credito_suficiente  : IN  STD_LOGIC;
        troco_necessario    : IN  STD_LOGIC;
        f1, f2              : OUT STD_LOGIC;
        nt                  : OUT STD_LOGIC;
        credito_clr         : OUT STD_LOGIC;
        credito_load        : OUT STD_LOGIC;
        troco_load          : OUT STD_LOGIC;
        sel_custo           : OUT STD_LOGIC
    );
END ENTITY bloco_controle;

ARCHITECTURE fsm OF bloco_controle IS
    TYPE T_ESTADO IS (E_INICIAL, E_SOMA, E_VERIFICA, E_ENTREGA, E_TROCO);
    SIGNAL estado_atual, proximo_estado : T_ESTADO;
    SIGNAL sel_custo_reg : STD_LOGIC;
BEGIN
    -- Processo sequencial
    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            estado_atual <= E_INICIAL;
            sel_custo_reg <= '0';
        ELSIF (rising_edge(clk)) THEN
            estado_atual <= proximo_estado;
            IF (estado_atual = E_INICIAL AND (b1 = '1' OR b2 = '1')) THEN
                IF b1 = '1' THEN
                    sel_custo_reg <= '0';
                ELSE
                    sel_custo_reg <= '1';
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- Processo combinacional (lógica de próximo estado e saídas)
    PROCESS (estado_atual, m, b1, b2, credito_suficiente, troco_necessario)
    BEGIN
        -- Valores padrão
        proximo_estado <= estado_atual;
        f1 <= '0'; f2 <= '0'; nt <= '0';
        credito_clr <= '0'; credito_load <= '0'; troco_load <= '0';
        sel_custo <= sel_custo_reg;

        CASE estado_atual IS
            WHEN E_INICIAL =>
                IF (m = '1') THEN
                    proximo_estado <= E_SOMA;
                ELSIF (b1 = '1' OR b2 = '1') THEN
                    proximo_estado <= E_VERIFICA;
                END IF;

            WHEN E_SOMA =>
                credito_load <= '1';
                proximo_estado <= E_INICIAL;

            WHEN E_VERIFICA =>
                IF (credito_suficiente = '1') THEN
                    proximo_estado <= E_ENTREGA;
                ELSE
                    proximo_estado <= E_INICIAL;
                END IF;

            WHEN E_ENTREGA =>
                credito_clr <= '1';
                troco_load  <= '1';
                IF (sel_custo_reg = '0') THEN
                    f1 <= '1';
                ELSE
                    f2 <= '1';
                END IF;
                
                IF (troco_necessario = '1') THEN
                    proximo_estado <= E_TROCO;
                ELSE
                    proximo_estado <= E_INICIAL;
                END IF;

            WHEN E_TROCO =>
                nt <= '1';
                proximo_estado <= E_INICIAL;
        END CASE;
    END PROCESS;

END ARCHITECTURE fsm;
