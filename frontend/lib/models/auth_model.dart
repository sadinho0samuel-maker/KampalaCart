class AuthModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? token;
  final String? role;

  AuthModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.token,
    this.role,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      token: json['token'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'token': token,
        'role': role,
      };
}
