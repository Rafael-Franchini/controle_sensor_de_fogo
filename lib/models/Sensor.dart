class Sensor {
  String ip;
  String name;
  double gas;
  bool fogo;
  bool isOnline = false;

  Sensor({
    required this.ip,
    required this.name,
    required this.gas,
    required this.fogo,
    required this.isOnline,
  });

  Sensor copyWith({
    String? name,
    String? ip,
    double? gas,
    bool? fogo,
    bool? isOnline,
  }) {
    return Sensor(
      ip: ip ?? this.ip,
      name: name ?? this.name,
      gas: gas ?? this.gas,
      fogo: fogo ?? this.fogo,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      ip: json['ip'],
      name: json['name'],
      gas: json['gas'],
      fogo: json['fogo'],
      isOnline: json['isOnline'] ?? false, // Adiciona o campo isOnline
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'name': name,
      'gas': gas,
      'fogo': fogo,
      'isOnline': isOnline,
    };
  }
}
