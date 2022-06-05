import 'package:auto_size_text/auto_size_text.dart';
import 'package:cap_member_app/helpers/util.dart';
import 'package:cap_member_app/models/team_model.dart';
import 'package:cap_member_app/pages/team_players.dart';
import 'package:cap_member_app/services/cap_service.dart';
import 'package:cap_member_app/widgets/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:cap_member_app/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Teams extends StatelessWidget {
  Teams({Key? key}) : super(key: key);

  final CapService capService = CapService();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '選手一覧',
        ),
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
      body: FutureBuilder<List<TeamModel>>(
        future: capService.getTeams(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TeamModel> teams = snapshot.data!;

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(9),
              itemCount: teams.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: TeamTile(team: teams[index]),
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

class TeamTile extends StatelessWidget {
  TeamTile({Key? key, required this.team}) : super(key: key);

  final TeamModel team;
  final Util util = Util.instance;

  @override
  Widget build(BuildContext context) {
    //final imagePath = util.teamLogoFilePath(team.teamId);

    return GestureDetector(
      onTap: () => {
        pushNewScreen(
          context,
          screen: TeamPlayers(
            teamId: team.teamId,
            teamName: team.teamName,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        'https://cap-baseball.com/images/${team.teamId}.jpg',
                        width: 35,
                        height: 35,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.network(
                              'https://cap-baseball.com/images/undefined.jpg',
                              width: 35,
                              height: 35);
                        },
                      )),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          team.teamName,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '${team.memberCount}人',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .fontSize,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (team.prefCode != 0)
                              CustomChip(
                                label: prefectures[team.prefCode - 1],
                                color: Color(colorCodes[team.prefCode - 1]),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
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
