import 'package:cap_member_app/models/game_result_model.dart';
import 'package:cap_member_app/models/player_model.dart';
import 'package:cap_member_app/models/player_detail_model.dart';
import 'package:cap_member_app/models/team_model.dart';
import 'package:cap_member_app/helpers/util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CapRepository {
  final Util util = Util.instance;

  Future<List<PlayerModel>> getPlayers() async {
    final response = await http
        .get(Uri.parse('https://jcbl-score.com/api/v2/player/list/3'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed['players']
          .map<PlayerModel>((json) => PlayerModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<TeamModel>> getTeams() async {
    final response = await http
        .get(Uri.parse('https://jcbl-score.com/api/v2/player/list/3'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed['teams']
          .map<TeamModel>((json) => TeamModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<PlayerModel>> getTeamPlayers(int teamId) async {
    final response = await http
        .get(Uri.parse('https://jcbl-score.com/api/v2/team/show/$teamId'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed['team_members']
          .map<PlayerModel>((json) => PlayerModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<PlayerDetailModel> getPlayerDetail(int id) async {
    final response = await http
        .get(Uri.parse('https://jcbl-score.com/api/v2/player/show/$id'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      Map<String, dynamic> merged = {}
        ..addAll({"team": parsed["team"], "team_id": parsed["teamId"]})
        ..addAll(util.extractBattingResult(parsed["playerBattingResultList"]))
        ..addAll(
            util.extractPitchingResult(parsed["personalPitchingResultList"]));

      return PlayerDetailModel.fromMap(merged);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<GameResultModel>> getGameResults() async {
    final response = await http
        .get(Uri.parse('https://jcbl-score.com/scoresheet/api/v1/game'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed
          .map<GameResultModel>((json) => GameResultModel.fromMap(json))
          .where((GameResultModel elm) => elm.isCap == 1)
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
