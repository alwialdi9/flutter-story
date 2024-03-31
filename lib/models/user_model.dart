part of 'models.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String password;
  final String? token;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.token});

  @override
  List<Object?> get props => [id, name, email, password, token];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
 
  Map<String, dynamic> toJson() => _$UserToJson(this);

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //       id: json['id'],
  //       name: json['name'],
  //       email: json['email'],
  //       password: json['password'] ?? '',
  //       token: json['token'] ?? '');
  // }
}
