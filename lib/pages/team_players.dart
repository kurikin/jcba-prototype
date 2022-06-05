import 'package:auto_size_text/auto_size_text.dart';
import 'package:cap_member_app/models/player_model.dart';
import 'package:cap_member_app/pages/player_detail.dart';
import 'package:cap_member_app/services/cap_service.dart';
import 'package:cap_member_app/helpers/util.dart';
import 'package:cap_member_app/widgets/player_chips.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TeamPlayers extends StatelessWidget {
  TeamPlayers({
    Key? key,
    required this.teamId,
    required this.teamName,
  }) : super(key: key);

  final int teamId;
  final String teamName;

  final CapService capService = CapService();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          teamName,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        flexibleSpace: GestureDetector(
          onTap: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
      ),
      body: FutureBuilder<List<PlayerModel>>(
        future: capService.getTeamPlayers(teamId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PlayerModel> players = snapshot.data!;

            return ListView.separated(
              padding: const EdgeInsets.all(5),
              controller: _scrollController,
              itemCount: players.length,
              itemBuilder: (_, index) => Container(
                padding: const EdgeInsets.all(2),
                child: PlayerTile(
                  player: players[index],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) => Container(
                height: 1,
                color: Colors.grey.withOpacity(0.2),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PlayerTile extends StatelessWidget {
  PlayerTile({Key? key, required this.player}) : super(key: key);

  final Util util = Util.instance;
  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        pushNewScreen(
          context,
          screen: PlayerDetail(
            player: player,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    player.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: PlayerChips(
                      teamRole: player.teamRole,
                      uniformNumber: player.uniformNumber,
                    ),
                  )),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
