# Sistema de Monitoramento IoT com ESP8266 e Flutter

![Badge da Linguagem (Firmware)](https://img.shields.io/badge/firmware-C++%20(Arduino)-orange.svg)
![Badge da Linguagem (App)](https://img.shields.io/badge/app-Flutter%20(Dart)-blue.svg)
![Badge da Licença](https://img.shields.io/badge/license-MIT-green.svg)

> Projeto completo de IoT para monitoramento de ambientes, composto por um firmware para o microcontrolador ESP8266 e um aplicativo de interface desenvolvido em Flutter.

## 📝 Sobre o Projeto

Este repositório contém todos os componentes para um sistema de monitoramento de segurança, desenvolvido para a disciplina de Sistemas Embarcados. A solução é dividida em duas partes principais:

1.  **Firmware (ESP8266):** Um nó sensor inteligente que lê dados de um sensor de gás e um sensor de chama. Ele hospeda um servidor web local para expor os dados em tempo real via JSON e possui atuadores como um buzzer e um display LCD para status local.

2.  **Aplicativo (Flutter):** Um aplicativo cliente multiplataforma que permite ao usuário cadastrar, visualizar e remover múltiplos nós sensores. Ele se conecta aos dispositivos pela rede Wi-Fi, exibe os dados em tempo real e armazena a lista de sensores localmente para fácil acesso.

## ✨ Funcionalidades

### Funcionalidades do Aplicativo (Flutter)
-   **Cadastro Dinâmico de Sensores:** Adicione novos dispositivos facilmente informando um nome e o endereço IP.
-   **Visualização em Tempo Real:** Acompanhe os dados de gás e chama de cada sensor cadastrado.
-   **Gerenciamento de Dispositivos:** Remova sensores que não estão mais em uso diretamente pela interface.
-   **Persistência de Dados:** A lista de sensores fica salva no aplicativo, não sendo necessário cadastrá-los novamente ao reabrir o app.
-   **Interface Intuitiva:** Telas claras para visualização, gerenciamento e uma seção de ajuda integrada.

### Funcionalidades do Firmware (ESP8266)
-   **Servidor Web Embarcado:** Expõe os dados dos sensores através de uma API REST simples que retorna JSON.
-   **Leitura de Sensores:** Coleta dados de gás e chama.
-   **Alarme Local:** Aciona um buzzer em caso de detecção de perigo.
-   **Display de Status:** Um display LCD pode ser usado para exibir informações vitais localmente.
-   
## 📱 Telas do Aplicativo

Aqui estão algumas telas que demonstram o funcionamento do aplicativo.
![1](https://github.com/user-attachments/assets/3c8817af-a210-4b9c-951b-571d4e04ceda)

*Figura 1 - Tela principal exibindo os sensores.*

![2](https://github.com/user-attachments/assets/15a131a3-0759-41b2-a8fd-e9c30c8e81c2)

*Figura 2 - Janela para adicionar um novo dispositivo.*

![3](https://github.com/user-attachments/assets/dec99357-5c43-4c63-84aa-b806fc263488)

*Figura 3 - Arrastando para o lado menu de edição e deletar sensor.*

![4](https://github.com/user-attachments/assets/0d58e172-703c-4eb6-9ad5-30aa8b3f1d40)

*Figura 4 - Tela opções onde temos ajuda e sobre o app.*


## 🛠️ Tecnologias Utilizadas

### Firmware (Hardware)
* **Microcontrolador:** ESP8266
* **Sensores:** Sensor de Gás (ex: MQ-2), Sensor de Chama
* **Atuadores:** Buzzer, Display LCD I2C 16x2
* **Linguagem:** C++ (Framework Arduino)

### Aplicativo Cliente
* **Framework:** Flutter
* **Linguagem:** Dart
* **Pacotes Prováveis:** `http` (requisições de rede), `shared_preferences` (armazenamento local)

## 🚀 Como Começar

Siga os passos para configurar o hardware e o aplicativo.

### Parte 1: Configurando o Hardware (ESP8266)

1.  **Montagem do Hardware:** Conecte os componentes ao ESP8266. A pinagem abaixo corresponde exatamente ao código em `firmware.ino`.
    | Componente            | Pino no ESP8266 |
    | --------------------- | --------------- |
    | Sensor de Chama (D0)  | **D0** |
    | Sensor de Gás (A0)    | **A0** |
    | Buzzer (+)            | **D7** |
    | Display LCD I2C (SDA) | **D2** (padrão) |
    | Display LCD I2C (SCL) | **D1** (padrão) |

2.  **Configuração do Firmware:**
    * Navegue até o diretório `firmware/`.
    * Abra o arquivo `firmware.ino` na sua IDE Arduino.
    * Instale a biblioteca `LiquidCrystal_I2C` se necessário.
    * Altere as **credenciais de Wi-Fi** para as da sua rede local.

3.  **Upload:** Faça o upload do código para o seu ESP8266 e **anote o endereço IP** que aparecerá no Monitor Serial ou no display LCD.

### Parte 2: Configurando o Aplicativo (Flutter)

1.  **Pré-requisitos:** Certifique-se de ter o [SDK do Flutter](https://docs.flutter.dev/get-started/install) instalado.

2.  **Instalar Dependências:**
    * Abra um terminal e navegue até o diretório do aplicativo: `cd app`
    * Execute: `flutter pub get`

3.  **Executar o Aplicativo:**
    * Conecte um emulador ou dispositivo físico.
    * Execute o app com o comando: `flutter run`
    * **Não é necessário configurar o IP no código.** Você fará o cadastro pela interface do próprio aplicativo.

## 📲 Uso do Aplicativo

A interface foi projetada para ser simples e direta.

#### Como Adicionar um Sensor
1.  Na tela principal, toque no **botão azul com o ícone `+`** no canto inferior direito.
2.  Preencha o **Nome** que desejar para o sensor e o **endereço IP** que você anotou.
3.  Toque em **"Adicionar"**. O novo sensor aparecerá na lista da tela inicial.

#### Como Visualizar e Remover um Sensor
1.  Na tela principal, **toque no card do sensor** que você deseja visualizar.
2.  Uma tela de detalhes mostrará os dados em tempo real.
3.  Para remover, toque no **ícone de lixeira** no canto superior direito e confirme a ação.

## 🔌 API Endpoint

O ESP8266 responde com os dados dos sensores no seguinte formato JSON.

* **Endpoint:** `GET http://[IP_DO_ESP]/`
* **Resposta JSON:**
    ```json
    {
      "gas": 310,
      "fogo": false,
      "buzzer": false
    }
    ```

## 📄 Licença

Este projeto está sob a licença MIT.
