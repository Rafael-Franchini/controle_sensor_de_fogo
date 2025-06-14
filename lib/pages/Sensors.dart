import 'dart:async';
import 'dart:convert';

import 'package:controle_sensor_de_fogo/models/Sensor.dart';
import 'package:controle_sensor_de_fogo/requests/Repositorio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Certifique-se de que o caminho está correto
import '../Widgets/WidgSens.dart';

class Sensors extends StatefulWidget {
  const Sensors({super.key});

  @override
  State<Sensors> createState() => _SensorsState();
}

class _SensorsState extends State<Sensors> {
  List<Sensor> sensoresList = [];
  final TextEditingController nameControler = TextEditingController();
  final TextEditingController ipController = TextEditingController();
  Timer? _timer;

  // CORREÇÃO: Adicionando a GlobalKey para o RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _carregaSensoresCache();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _atualizarDadosDosSensores();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    nameControler.dispose();
    ipController.dispose();
    super.dispose();
  }

  // CORREÇÃO: Usando o ID único para deletar
  void deleteSensor(String sensorId) {
    setState(() {
      sensoresList.removeWhere((s) => s.ip == sensorId);
    });
    SensorCache.saveSensors(sensoresList);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sensor removido com sucesso."),
        backgroundColor: Colors.red,
      ),
    );
  }

  void editSensor(Sensor sensor) {
    final TextEditingController editNameController = TextEditingController(
      text: sensor.name,
    );
    final TextEditingController editIpController = TextEditingController(
      text: sensor.ip,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1a1a1a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Editar Sensor',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editNameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nome do Sensor',
                  labelStyle: TextStyle(color: Colors.green),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: editIpController,
                style: const TextStyle(color: Colors.white),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'IP do Sensor',
                  labelStyle: TextStyle(color: Colors.green),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                final newName = editNameController.text;
                final newIp = editIpController.text;
                if (newName.isNotEmpty && newIp.isNotEmpty) {
                  // CORREÇÃO: Usando o ID para encontrar o índice
                  final index = sensoresList.indexWhere(
                    (s) => s.ip == sensor.ip,
                  );
                  if (index != -1) {
                    setState(() {
                      sensoresList[index] = sensor.copyWith(
                        name: newName,
                        ip: newIp,
                      );
                    });
                  }
                  Navigator.of(context).pop();
                  _refreshIndicatorKey.currentState?.show();
                }
              },
              child: const Text(
                'Salvar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _carregaSensoresCache() async {
    try {
      final cachedSensors = await SensorCache.loadSensors();
      if (cachedSensors.isNotEmpty) {
        setState(() {
          sensoresList = cachedSensors;
        });
      }
    } catch (e) {
      print("Erro ao carregar sensores do cache: $e");
    }
  }

  // CORREÇÃO: Usando a versão otimizada da função de atualização
  Future<void> _atualizarDadosDosSensores() async {
    if (sensoresList.isEmpty) return;
    print("--- Iniciando atualização dos sensores... ---");

    // Cria uma lista de "tarefas futuras" para cada sensor
    List<Future<Sensor>> updateFutures =
        sensoresList.map((sensor) => _fetchSensorData(sensor)).toList();

    // Espera todas as tarefas terminarem
    final List<Sensor> novaLista = await Future.wait(updateFutures);

    if (mounted) {
      setState(() {
        sensoresList = novaLista;
      });
    }
  }

  // Função auxiliar para buscar dados de um único sensor
  Future<Sensor> _fetchSensorData(Sensor sensor) async {
    try {
      final jsonString = await buscarJsonDoIp(ip: sensor.ip);
      final dados = jsonDecode(jsonString) as Map<String, dynamic>;
      // Retorna uma cópia do sensor com os dados atualizados
      return sensor.copyWith(
        gas: dados['gas']?.toDouble() ?? 0.0,
        fogo: dados['fogo'] ?? false,
        isOnline: true,
      );
    } catch (e) {
      print("Falha ao atualizar sensor '${sensor.name}' (${sensor.ip}): $e");
      // Retorna uma cópia do sensor marcando-o como offline
      return sensor.copyWith(isOnline: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      body: RefreshIndicator(
        // CORREÇÃO: Adicionando o widget RefreshIndicator
        key: _refreshIndicatorKey,
        onRefresh: _atualizarDadosDosSensores,
        backgroundColor: const Color(0xff1a1a1a),
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              sensoresList.isEmpty
                  ? const Center(
                    // Simplificado para usar o Center diretamente
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nenhum sensor encontrado',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Adicione um sensor para começar',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    // CORREÇÃO: Usando ListView.builder para melhor performance
                    itemCount: sensoresList.length,
                    itemBuilder: (context, index) {
                      final sensor = sensoresList[index];
                      return WidgSensor(
                        // CORREÇÃO: Adicionando a Key
                        key: ValueKey(sensor.ip),
                        S1: sensor,
                        // CORREÇÃO: Chamando os nomes corretos das funções
                        onDelete: () => deleteSensor(sensor.ip),
                        onEdit: () => editSensor(sensor),
                      );
                    },
                  ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _addSensorDialog, // CORREÇÃO: Renomeado para seguir o padrão
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _addSensorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1a1a1a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Adicionar Sensor',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameControler,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Nome do Sensor',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: ipController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'IP do Sensor',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                final name = nameControler.text;
                final ip = ipController.text;
                if (name.isNotEmpty && ip.isNotEmpty) {
                  // CORREÇÃO: Criando o sensor com um ID único
                  final newSensor = Sensor(
                    ip: ip,
                    name: name,
                    gas: 0,
                    fogo: false,
                    isOnline: false,
                  );
                  setState(() => sensoresList.add(newSensor));
                  SensorCache.saveSensors(sensoresList);
                  nameControler.clear();
                  ipController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Sensor adicionado com sucesso."),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.of(context).pop();
                  _refreshIndicatorKey.currentState?.show();
                }
              },
              child: const Text(
                'Adicionar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> buscarJsonDoIp({
    required String ip,
    int timeoutSeconds = 5,
  }) async {
    final url = Uri.parse('http://$ip');
    try {
      final response = await http
          .get(url)
          .timeout(Duration(seconds: timeoutSeconds));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(
          'Falha ao carregar dados. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Não foi possível se conectar ao dispositivo: $e');
    }
  }
}
