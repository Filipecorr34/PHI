LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY somador_subtrator_4bits IS
    PORT (
        A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        SUB  : IN  STD_LOGIC; -- '0' para SOMA, '1' para SUBTRAÇÃO
        S    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout : OUT STD_LOGIC -- Carry out final / Overflow
    );
END ENTITY somador_subtrator_4bits;

ARCHITECTURE structural OF somador_subtrator_4bits IS

    -- Declaração do componente para corresponder EXATAMENTE ao seu arquivo.
    COMPONENT somador_completo_1bit IS
        PORT (
            A, B, Cin : IN  STD_LOGIC;
            S, Cout   : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Sinais internos
    SIGNAL C         : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL B_operand : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    B_operand <= B XOR (SUB & SUB & SUB & SUB);
    C(0) <= SUB;

    -- Instanciação dos 4 somadores.
    GEN_RIPPLE_CARRY_ADDER: FOR i IN 0 TO 3 GENERATE
        FA_i: entity work.somador_completo_1bit(logica)
            PORT MAP (
                A    => A(i),
                B    => B_operand(i),
                Cin  => C(i),
                S    => S(i),
                Cout => C(i+1)
            );
    END GENERATE GEN_RIPPLE_CARRY_ADDER;

    -- A saída de carry final
    Cout <= C(4);

END ARCHITECTURE structural;