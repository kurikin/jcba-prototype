class GameResultModel {
  GameResultModel({
    required this.firstTeamId,
    required this.lastTeamId,
    required this.firstTeamName,
    required this.lastTeamName,
    required this.firstRun,
    required this.lastRun,
    required this.leagueId,
    required this.gameDate,
    required this.gameName,
    required this.isCap
  });

  final int firstTeamId;
  final int lastTeamId;
  final String firstTeamName;
  final String lastTeamName;
  final int firstRun;
  final int lastRun;
  final int leagueId;
  final String gameDate;
  final String gameName;
  final int isCap;

  factory GameResultModel.fromMap(Map<String, dynamic> json) => GameResultModel(
        firstTeamId: json["first_team"],
        lastTeamId: json["last_team"],
        firstTeamName: json["first_team_name"],
        lastTeamName: json["last_team_name"],
        firstRun: json["first_run"],
        lastRun: json["last_run"],
        leagueId: json["league_id"],
        gameDate: json["game_date"],
        gameName: json["name"],
        isCap: json['isCap']
      );
}
