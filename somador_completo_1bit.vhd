library ieee;
use ieee.std_logic_1164.all;

entity somador_completo_1bit is
    port (
        A, B, Cin : in std_logic;   -- Entradas: bits a serem somados e carry de entrada
        S, Cout   : out std_logic    -- Saídas: resultado da soma e carry de saída
    );
end somador_completo_1bit;

architecture logica of somador_completo_1bit is
    -- Sinais intermediários
    signal xor1_out, and1_out, and2_out : std_logic;
begin
    -- Implementação usando portas lógicas
    xor1_out <= A xor B;
    S <= xor1_out xor Cin;
    
    and1_out <= A and B;
    and2_out <= xor1_out and Cin;
    
    Cout <= and1_out or and2_out;
end architecture logica;