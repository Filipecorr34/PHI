# ===================================================================
# Arquivo de Atribuições TCL para o Somador/Subtrator de 4 bits
# Placa: Terasic DE1-SoC
# ===================================================================

# --- Configuração do Padrão de Tensão da Entrada A ---

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to A[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to A[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to A[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to A[0]

# --- Mapeamento das Entradas A[3..0] -> Usando SW3, SW2, SW1, SW0 ---
set_location_assignment PIN_AF10 -to A[3]
set_location_assignment PIN_AF9  -to A[2]
set_location_assignment PIN_AC12 -to A[1]
set_location_assignment PIN_AB12 -to A[0]

# --- Configuração do Padrão de Tensão da Entrada B ---

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[0]

# --- Mapeamento das Entradas B[3..0] -> Usando SW7, SW6, SW5, SW4 ---
set_location_assignment PIN_AC9  -to B[3]
set_location_assignment PIN_AE11 -to B[2]
set_location_assignment PIN_AD12 -to B[1]
set_location_assignment PIN_AD11 -to B[0]

# --- Configuração do Padrão de Tensão Do Seletor SUB ---

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SUB

# Entrada SUB -> Usando SW9
set_location_assignment PIN_AE12 -to SUB

# --- Configuração do Padrão de Tensão da Saida S ---

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to S[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to S[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to S[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to S[0]

# --- Mapeamento das Saídas S[3..0] -> Usando LEDR3, LEDR2, LEDR1, LEDR0 ---
set_location_assignment PIN_V18 -to S[3]
set_location_assignment PIN_V17 -to S[2]
set_location_assignment PIN_W16 -to S[1]
set_location_assignment PIN_V16 -to S[0]

# --- Configuração do Padrão de Tensão Do Bit de Estouro/Overflow Cout ---

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Cout

# Saída Cout -> Usando LEDR9
set_location_assignment PIN_Y21 -to Cout