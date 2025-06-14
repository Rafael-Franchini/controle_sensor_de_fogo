import 'package:controle_sensor_de_fogo/pages/Config.dart';
import 'package:controle_sensor_de_fogo/pages/Sensors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //lista de telas
  final List<Widget> _telas = [const Sensors(), const Configuracao()];
  int _currentIndex = 0; // índice da tela atual

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff252525),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Sensores de Fogo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xff1a1a1a),
        ),
        body: _telas[_currentIndex], // exibe a tela atual
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // atualiza a tela ao tocar
            });
          },
          backgroundColor: Color(0xff1a1a1a),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: 'Sensores',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Opções'),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
