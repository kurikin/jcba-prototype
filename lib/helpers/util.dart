import 'package:cap_member_app/constants.dart';

class Util {
  Util._();

  static final instance = Util._();

  bool nullOrEmpty(String? str) {
    return str?.isEmpty ?? true;
  }

  Map<String, dynamic> extractBattingResult(List<dynamic> results) {
    Map<String, dynamic> merged = {};

    if (results.isEmpty) {
      return merged;
    }
    final scores = results
        .where(
            (item) => item["is_practice"] != null && item["season_id"] == null)
        .toList()[0];
    final stds = results
        .where(
            (item) => item["is_practice"] == null && item["season_id"] == null)
        .toList()[0];

    merged
      ..addAll({
        "average": scores["average"],
        "ops": scores["ops"],
        "obp": scores["obp"],
        "slg": scores["slg"],
      })
      ..addAll({
        "std_average": stds["std_average"],
        "std_ops": stds["std_ops"],
        "std_obp": stds["std_obp"],
        "std_slg": stds["std_slg"]
      });
    return merged;
  }

  Map<String, dynamic> extractPitchingResult(List<dynamic> results) {
    Map<String, dynamic> merged = {};

    if (results.isEmpty) {
      return merged;
    }

    final scores = results
        .where(
            (item) => item["is_practice"] != null && item["season_id"] == null)
        .toList()[0];
    final stds = results
        .where(
            (item) => item["is_practice"] == null && item["season_id"] == null)
        .toList()[0];

    merged
      ..addAll({
        "era": scores["era"],
        "win_avg": scores["win_avg"],
        "strike_avg": scores["strike_avg"],
        "whip": scores["whip"],
      })
      ..addAll({
        "std_era": stds["std_era"],
        "std_win_avg": stds["std_win_avg"],
        "std_strike": stds["std_strike"],
        "std_whip": stds["std_whip"],
      });
    return merged;
  }

  // String teamLogoFilePath(int teamId) {
  //   return existImageIds.contains(teamId)
  //       ? 'assets/images/teams/$teamId.jpg'
  //       : 'assets/images/cap.png';
  // }

  String unifromFilePath(int num) {
    return 'assets/images/uniforms/$num.png';
  }
}
