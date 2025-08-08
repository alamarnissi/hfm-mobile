class Channel {
  final String name;
  final String logo;
  final String url;

  Channel({
    required this.name,
    required this.logo,
    required this.url,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      name: json['name'],
      logo: json['logo'],
      url: json['url'],
    );
  }
}
