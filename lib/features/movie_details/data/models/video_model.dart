class VideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;

  VideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      site: json['site'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
