class ClientModel {
  final int id;
  final String username;
  final String password;
  final String name;
  final String model;
  final String sn;
  final String mac;
  final String updatedAt;
  final String expiresAt;

  ClientModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.model,
    required this.sn,
    required this.mac,
    required this.updatedAt,
    required this.expiresAt,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      name: json['name'],
      model: json['model'],
      sn: json['sn'],
      mac: json['mac'],
      updatedAt: json['updated_at'],
      expiresAt: json['expires_at'],
    );
  }
}
