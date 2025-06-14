import 'package:controle_sensor_de_fogo/models/Sensor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WidgSensor extends StatelessWidget {
  const WidgSensor({
    super.key,
    required this.S1,
    required this.onDelete,
    required this.onEdit,
  });

  final Sensor S1;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(S1.ip),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Deletar',
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: (context) => onEdit(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),

      child: Card(
        color: const Color(0xff1a1a1a),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          S1.isOnline ? Colors.greenAccent : Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          color:
                              S1.isOnline
                                  ? Colors.greenAccent.withAlpha(150)
                                  : Colors.redAccent.withAlpha(150),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    S1.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.drag_handle, color: Colors.white30),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'IP: ${S1.ip}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Nível de Gás: ${S1.gas.toStringAsFixed(2)}%',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Fogo detectado: ${S1.fogo ? "Sim" : "Não"}',
                style: TextStyle(
                  color: S1.fogo ? Colors.orange : Colors.white70,
                  fontWeight: S1.fogo ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
