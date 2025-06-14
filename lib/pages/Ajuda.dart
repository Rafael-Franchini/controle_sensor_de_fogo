import 'package:flutter/material.dart';

class Ajuda extends StatelessWidget {
  const Ajuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(
          'Ajuda',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff252525),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Text(
                    'O que são os Sensores de Fogo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Os sensores de fogo são dispositivos conectados que monitoram a temperatura, gás, umidade e presença de chamas em tempo real. Eles aparecem na tela inicial do app quando cadastrados corretamente.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Como adicionar um sensor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '1 - Na tela principal, toque no botão azul com o ícone "+" no canto inferior direito. \n 2 - Uma janela chamada "Adicionar Sensor" será exibida. \n 3 - Preencha os seguintes campos:\n  - Nome do Sensor: Escolha um nome para identificá-lo. \n - IP do Sensor: Insira o IP de rede do sensor (por exemplo: 192.168.0.100). \n4 - Toque em "Adicionar" para salvar.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Como remover um sensor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '1 - Na tela principal, toque no sensor que deseja remover. \n 2 - Na tela de detalhes do sensor, toque no ícone de lixeira no canto superior direito. \n 3 - Confirme a remoção tocando em "Remover".',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Como acessar as configurações',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '1 - Na tela principal, toque no ícone de menu no canto inferior direito. \n 2 - Selecione "Configurações" para acessar as opções do aplicativo.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Os sensores ficam salvos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sim, os sensores adicionados permanecem salvos mesmo após fechar o aplicativo. Você pode acessá-los novamente na tela principal.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
