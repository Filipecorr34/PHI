LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY complemento_2 IS
    PORT (
        data_in  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY complemento_2;

ARCHITECTURE behavioral OF complemento_2 IS
BEGIN
    data_out <= std_logic_vector(unsigned(NOT data_in) + 1);
END ARCHITECTURE behavioral;