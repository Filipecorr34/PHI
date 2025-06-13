LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- Bibliotecas essenciais para I/O de texto
USE std.textio.all;
USE ieee.std_logic_textio.all; -- Chave para ler/escrever std_logic_vector no VHDL-2008

ENTITY tb_somador_subtrator_4bits IS
END ENTITY tb_somador_subtrator_4bits;

ARCHITECTURE behavior OF tb_somador_subtrator_4bits IS

    -- Componente a ser testado
    COMPONENT somador_subtrator_4bits IS
        PORT (
            A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            SUB  : IN  STD_LOGIC;
            S    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Sinais internos para conectar ao UUT
    SIGNAL s_A    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL s_B    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL s_SUB  : STD_LOGIC;
    SIGNAL s_S    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL s_Cout : STD_LOGIC;

    CONSTANT period : TIME := 20 ns;

BEGIN
    -- Instanciação do UUT
    uut: somador_subtrator_4bits
        PORT MAP (
            A    => s_A,
            B    => s_B,
            SUB  => s_SUB,
            S    => s_S,
            Cout => s_Cout
        );

    -- Processo que lê os vetores de teste do arquivo e escreve os resultados
    stimulus_process: PROCESS
        -- Declaração dos arquivos
        FILE file_in  : TEXT OPEN READ_MODE  IS "entrada.txt";
        FILE file_out : TEXT OPEN WRITE_MODE IS "saida.txt";
        
        -- Variáveis para buffer de linha e dados
        VARIABLE line_in   : LINE;
        VARIABLE line_out  : LINE;
        VARIABLE var_A, var_B : STD_LOGIC_VECTOR(3 DOWNTO 0);
        VARIABLE var_SUB   : STD_LOGIC;
        VARIABLE space     : CHARACTER; -- Para consumir os espaços no arquivo

    BEGIN
        -- Escreve um cabeçalho no arquivo de saída
        write(line_out, string'("--- Relatorio de Simulacao do Somador/Subtrator ---"));
        writeline(file_out, line_out);
        
        -- Loop que executa enquanto houver linhas no arquivo de entrada
        WHILE NOT endfile(file_in) LOOP
            -- 1. Ler uma linha do arquivo de entrada
            readline(file_in, line_in);
            
            -- 2. Ler os valores da linha para as variáveis
            read(line_in, var_A);
            read(line_in, space); -- Lê o espaço entre A e B
            read(line_in, var_B);
            read(line_in, space); -- Lê o espaço entre B e SUB
            read(line_in, var_SUB);

            -- 3. Aplicar os valores lidos aos sinais
            s_A   <= var_A;
            s_B   <= var_B;
            s_SUB <= var_SUB;

            -- 4. Esperar um tempo para o circuito processar
            WAIT FOR period;

            -- 5. Escrever o resultado no arquivo de saída
            write(line_out, string'("Operacao: "));
            write(line_out, s_A); -- Escreve o valor de A
            
            IF s_SUB = '0' THEN
                write(line_out, string'(" + "));
            ELSE
                write(line_out, string'(" - "));
            END IF;
            
            write(line_out, s_B); -- Escreve o valor de B
            write(line_out, string'(" | Resultado: S="));
            write(line_out, s_S); -- Escreve o resultado da soma/subtração
            write(line_out, string'(", Cout="));
            write(line_out, s_Cout); -- Escreve o carry out
            
            -- Escreve a linha completa no arquivo de saída
            writeline(file_out, line_out);
        END LOOP;

        -- Fecha os arquivos ao final do processo
        file_close(file_in);
        file_close(file_out);

        -- Fim da simulação
        REPORT "Simulacao concluida. Verifique o arquivo saida.txt.";
        WAIT;
    END PROCESS stimulus_process;

END ARCHITECTURE behavior;