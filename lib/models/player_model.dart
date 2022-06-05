class PlayerModel {
  PlayerModel({
    required this.id,
    required this.name,
    required this.teamId,
    required this.teamName,
    required this.teamRole,
    required this.uniformNumber,
  });

  int id;
  String name;
  int teamId;
  String teamName;
  String? teamRole;
  String? uniformNumber;

  factory PlayerModel.fromMap(Map<String, dynamic> json) => PlayerModel(
      id: json["id"],
      name: json["name"],
      teamId: json["team_id"] ?? json["teamId"],
      teamName: json["team_name"],
      teamRole: json["team_role"],
      uniformNumber: json["uniform_number"]);
}
