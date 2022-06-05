class UserModel {
  final String uid;
  final String email;
  final String name;
  final String teamName;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.teamName,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      teamName: data['teamName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "teamName": teamName
      };
}
