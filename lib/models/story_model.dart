part of 'models.dart';

@JsonSerializable()
class Story extends Equatable {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double? lat;
  final double? lon;

  Story(
      {required this.id,
      required this.name,
      required this.description,
      required this.photoUrl,
      required this.createdAt,
      required this.lat,
      required this.lon});
  @override
  List<Object?> get props =>
      [id, name, description, photoUrl, createdAt, lat, lon];

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
 
  Map<String, dynamic> toJson() => _$StoryToJson(this);
  // factory Story.fromJson(Map<String, dynamic> json) {
  //   return Story(
  //       id: json['id'],
  //       name: json['name'],
  //       description: json['description'],
  //       photoUrl: json['photoUrl'],
  //       lat: (json['lat'] != null && json['lat'].runtimeType != double ? double.parse(json['lat']) : json['lat']),
  //       lon: (json['lon'] != null && json['lon'].runtimeType != double ? double.parse(json['lon']) : json['lon']),
  //       createdAt: json['createdAt'] ?? '');
  // }
}
