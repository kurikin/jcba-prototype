import 'package:cap_member_app/models/game_result_model.dart';
import 'package:cap_member_app/models/player_model.dart';
import 'package:cap_member_app/models/team_model.dart';
import 'package:cap_member_app/models/player_detail_model.dart';
import 'package:cap_member_app/repositories/cap_repository.dart';
import 'package:cap_member_app/helpers/util.dart';
import "package:collection/collection.dart";

class CapService {
  final Util util = Util.instance;
  final CapRepository _capRepo = CapRepository();

  Future<List<PlayerModel>> getPlayers() async {
    return await _capRepo.getPlayers();
  }

  Future<List<TeamModel>> getTeams() async {
    final List<TeamModel> teams = await _capRepo.getTeams();
    final List<PlayerModel> players = await _capRepo.getPlayers();

    final groupedPlayers = players.groupListsBy((elt) => elt.teamId);

    for (TeamModel team in teams) {
      team.memberCount = groupedPlayers[team.teamId]?.length ?? 0;
    }

    // 所属人数が0のチームは除外
    teams.removeWhere((elt) => elt.memberCount == 0);

    // 所属人数順でソート（降順）
    teams.sort((a, b) => b.memberCount.compareTo(a.memberCount));
    return teams;
  }

  Future<List<PlayerModel>> getTeamPlayers(int teamId) async {
    List<PlayerModel> players = await _capRepo.getTeamPlayers(teamId);

    // 背番号順でソート（昇順 & 番号がない人は後ろへ）
    players.sort(
      (p1, p2) {
        if (util.nullOrEmpty(p1.uniformNumber) &&
            util.nullOrEmpty(p2.uniformNumber)) {
          return 0;
        } else if (util.nullOrEmpty(p1.uniformNumber)) {
          return 1;
        } else if (util.nullOrEmpty(p2.uniformNumber)) {
          return -1;
        } else {
          return int.parse(p1.uniformNumber!)
              .compareTo(int.parse(p2.uniformNumber!));
        }
      },
    );
    return players;
  }

  Future<PlayerDetailModel> getPlayerDetail(int id) async {
    return await _capRepo.getPlayerDetail(id);
  }

  Future<List<GameResultModel>> getGameResults() async {
    return await _capRepo.getGameResults();
  }
}
