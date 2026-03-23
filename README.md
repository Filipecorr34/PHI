# Projetos de Hardware e Interfaceamento (PHI) - 2025.2

Repositório destinado aos projetos desenvolvidos para a disciplina de Projetos de Hardware e Interfaceamento (PHI) da Faculdade de Engenharia da Computação e Telecomunicações (FCT), do Instituto de Tecnologia (ITEC) na Universidade Federal do Pará (UFPA)
## 👨‍💻 Autores
| Nome                  |  GitHub                                             |
|-----------------------|-----------------------------------------------------|
| **Adryele Oliveira**  |  [@elleoliveir](https://github.com/elleoliveir)     |
| **Amanda Lopes**      |  [@a-mand](https://github.com/a-mand)               |
| **Filipe Corrêa**     |  [@Filipecorr34](https://github.com/Filipecorr34)   |
| **Livia Hipolito**    |  [@liviahipolito](https://github.com/liviahipolito)  |
---

## 🛠️ Ferramentas Utilizadas
* **Linguagem de Descrição de Hardware:** VHDL
* **Síntese e Prototipagem:** Quartus Prime
* **Simulação Digital:** ModelSim / Questasim
* **Simulação Analógica:** Tina-TI

---

## 📂 Projetos Desenvolvidos

### 1. Somador e Subtrator de 4 Bits (VHDL)
Desenvolvimento de um sistema digital combinacional para operações aritméticas binárias.
* **Arquitetura:** Implementação modular começando por um somador completo de 1 bit baseado em portas lógicas básicas.
* **Operação:** O módulo de nível superior (*top-level*) conecta quatro somadores de 1 bit em uma estrutura de *ripple carry*.
* **Subtração:** Utiliza a técnica de **Complemento a Dois**. O sinal de controle `SUB` inverte o operando B e injeta o carry inicial, permitindo realizar $A - B$ através de uma operação de soma.
* **Validação:** Verificação funcional realizada via testbench com leitura e escrita em arquivos de texto (`entrada.txt` e `saida.txt`).
  
### 2. Máquina de Vendas Melhorada (Arquitetura BO-BC)
Projeto focado na metodologia de **Bloco Operativo (BO)** e **Bloco de Controle (BC)** para automação de vendas.
* **Objetivo:** Criar um sistema que aceita moedas, acumula crédito, permite a escolha de dois produtos e gerencia o troco.
* **Bloco Operativo:** Contém registradores para saldo (`credito_reg`) e troco (`troco_reg`), além de comparadores e subtratores para a lógica de preço.
* **Bloco de Controle:** Implementado como uma Máquina de Estados (FSM) com os estados: `E_INICIAL`, `E_SOMA`, `E_VERIFICA`, `E_ENTREGA` e `E_TROCO`.
* **Diferencial:** O sistema compartilha recursos aritméticos para otimização de custo, realizando cálculos em ciclos de clock distintos.

### 3. Condicionamento de Sinais (Sensor Fotodetector)
Implementação de um sistema analógico para preparar sinais ópticos para aquisição por um ADC de 12 bits.
* **Amplificador de Instrumentação:** Responsável por isolar o sensor e elevar sinais na ordem de microvolts para a faixa de milivolts.
* **Filtro Passa-Faixa Sallen-Key:** Filtro ativo de 2ª ordem projetado para isolar a frequência de interesse de **5 kHz**, eliminando ruídos e harmônicos indesejados.
* **Estágio de Saída (Offset):** Ajusta o ganho final e realiza o deslocamento DC para centralizar a onda em 2048 mV, garantindo que o sinal oscile apenas na faixa positiva (0V a 4V).

### 4. Conversores AD e DA (3 Bits)
Estudo e implementação de circuitos de conversão de dados em nível de portas lógicas (Família 74XX).
* **Conversor AD (Flash):** Arquitetura de alta velocidade utilizando um banco de comparadores em paralelo e um codificador de prioridade.
* **Conversor DA (Divisor Kelvin):** Utiliza um decodificador para acionar chaves analógicas em uma rede de resistores, reconstruindo o sinal analógico.
* **Sistema Integrado:** Simulação do ciclo completo (Analógico → Digital → Analógico), demonstrando visualmente o efeito da quantização e a precisão da reconstrução com 3 bits de resolução.
---
## 🚀 Como Simular
1. Para projetos **VHDL**: Utilize o Quartus Prime para síntese e o ModelSim para análise das formas de onda (`.vhd`).
2. Para projetos **Analógicos**: Abra os arquivos de esquemático (`.tsc`) no software Tina-TI e execute a "Análise Transiente".
---
## 📈 Resultados e Simulações
* **Simulações Digitais:** Verificação de overflow em somas e geração de resultados negativos em complemento a dois no somador de 4 bits.
* **Simulações Analógicas:** Análise de transiente e diagramas de Bode confirmando a seletividade do filtro de 5 kHz e a precisão do deslocamento de nível para o ADC.
* **Integração AD/DA:** Reconstrução da onda senoidal original em formato de "escada" (quantizada), validando a precisão do sistema integrado.
---
© 2025 - Engenharia da Computação - Disciplina de PHI - UFPA.
