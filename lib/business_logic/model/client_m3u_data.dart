class ClientM3UData {
  final Map<String, dynamic> client;
  final Map<String, dynamic> groups;

  ClientM3UData({required this.client, required this.groups});

  factory ClientM3UData.fromJson(Map<String, dynamic> json) {
    return ClientM3UData(
      client: Map<String, dynamic>.from(json['client']),
      groups: Map<String, dynamic>.from(json['groups']),
    );
  }

  @override
  String toString() {
    return 'ClientM3UData(client: $client, groups: ${groups.keys.toList()})';
  }
}
