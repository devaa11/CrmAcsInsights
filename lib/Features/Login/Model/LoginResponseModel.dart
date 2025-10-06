



class LoginResponseModel {
  String accessToken;
  String? tokenType;
  User? user;
  String? apiUrl;
  String? message;

  LoginResponseModel({
    required this.accessToken,
    this.tokenType,
    this.user,
    this.apiUrl,
    this.message
  });

  LoginResponseModel copyWith({
    String? accessToken,
    String? tokenType,
    User? user,
    String? apiUrl,
  }) =>
      LoginResponseModel(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        user: user ?? this.user,
        apiUrl: apiUrl ?? this.apiUrl,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    accessToken: json["access_token"]??"",
    tokenType: json["token_type"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    apiUrl: json["api_url"]??"",
    message: json["message"]??"",
  );
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNo;
  String? imageUrl;
  int? employeeCount;
  String? role;
  DateTime? lastLoginAt;
  DateTime? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.imageUrl,
    this.employeeCount,
    this.role,
    this.lastLoginAt,
    this.createdAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNo,
    String? imageUrl,
    int? employeeCount,
    String? role,
    DateTime? lastLoginAt,
    DateTime? createdAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        imageUrl: imageUrl ?? this.imageUrl,
        employeeCount: employeeCount ?? this.employeeCount,
        role: role ?? this.role,
        lastLoginAt: lastLoginAt ?? this.lastLoginAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    imageUrl: json["image_url"],
    employeeCount: json["employee_count"],
    role: json["role"],
    lastLoginAt: json["last_login_at"] == null ? null : DateTime.parse(json["last_login_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

}
