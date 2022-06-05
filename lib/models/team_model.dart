class TeamModel {
  TeamModel({
    required this.teamId,
    required this.teamName,
    required this.shortName,
    required this.prefCode,
    required this.status,
  });

  int teamId;
  String teamName;
  String shortName;
  int prefCode;
  String? status;
  int memberCount = 0;

  factory TeamModel.fromMap(Map<String, dynamic> json) => TeamModel(
        teamId: json["team_id"],
        teamName: json["team_name"],
        shortName: json["short_name"],
        prefCode: json["pref_code"],
        status: json["status"],
      );
}
