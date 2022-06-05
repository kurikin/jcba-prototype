class PlayerDetailModel {
  PlayerDetailModel({
    required this.teamId,
    required this.teamName,
    required this.avg,
    required this.ops,
    required this.obp,
    required this.slg,
    required this.era,
    required this.winAvg,
    required this.strikeAvg,
    required this.whip,
    required this.stdAvg,
    required this.stdOps,
    required this.stdObp,
    required this.stdSlg,
    required this.stdEra,
    required this.stdWinAvg,
    required this.stdStrikeAvg,
    required this.stdWhip,
  });

  int teamId;
  String teamName;
  double avg;
  double ops;
  double obp;
  double slg;
  double era;
  double winAvg;
  double strikeAvg;
  double whip;
  double stdAvg;
  double stdOps;
  double stdObp;
  double stdSlg;
  double stdEra;
  double stdWinAvg;
  double stdStrikeAvg;
  double stdWhip;

  factory PlayerDetailModel.fromMap(Map<String, dynamic> json) {
    final player = PlayerDetailModel(
      teamId: json["team_id"],
      teamName: json["team"],
      avg: json["average"]?.toDouble() ?? -1,
      ops: json["ops"]?.toDouble() ?? -1,
      obp: json["obp"]?.toDouble() ?? -1,
      slg: json["slg"]?.toDouble() ?? -1,
      era: json["era"]?.toDouble() ?? -1,
      winAvg: json["win_avg"]?.toDouble() ?? -1,
      strikeAvg: json["strike_avg"]?.toDouble() ?? -1,
      whip: json["whip"]?.toDouble() ?? -1,
      stdAvg: json["std_average"]?.toDouble() ?? 0,
      stdOps: json["std_ops"]?.toDouble() ?? 0,
      stdObp: json["std_obp"]?.toDouble() ?? 0,
      stdSlg: json["std_slg"]?.toDouble() ?? 0,
      stdEra: json["std_era"]?.toDouble() ?? 0,
      stdWinAvg: json["std_win_avg"]?.toDouble() ?? 0,
      stdStrikeAvg: json["std_strike"]?.toDouble() ?? 0,
      stdWhip: json["std_whip"]?.toDouble() ?? 0,
    );
    return player;
  }
}
