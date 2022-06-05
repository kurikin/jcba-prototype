import 'package:auto_size_text/auto_size_text.dart';
import 'package:cap_member_app/constants.dart';
import 'package:cap_member_app/helpers/util.dart';
import 'package:cap_member_app/models/player_detail_model.dart';
import 'package:cap_member_app/models/player_model.dart';
import 'package:cap_member_app/services/cap_service.dart';
import 'package:cap_member_app/widgets/custom_card.dart';
import 'package:cap_member_app/widgets/player_chips.dart';
import 'package:cap_member_app/widgets/radar_chart.dart';
import 'package:flutter/material.dart';

class PlayerDetail extends StatelessWidget {
  PlayerDetail({Key? key, required this.player}) : super(key: key);

  final PlayerModel player;
  final CapService capService = CapService();
  final Util util = Util.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<PlayerDetailModel>(
      future: capService.getPlayerDetail(player.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final PlayerDetailModel playerDetail = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              _buildHeader(context, playerDetail),
              const SizedBox(height: 25),
              _buildRadarChart(context, playerDetail),
              const SizedBox(height: 12),
              ScoresTable(playerDetail: playerDetail),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildHeader(BuildContext context, PlayerDetailModel playerDetail) {
    //final imagePath = util.teamLogoFilePath(playerDetail.teamId);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    player.name,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                playerDetail.teamName,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.caption!.fontSize),
              ),
              const SizedBox(height: 7),
              PlayerChips(
                  teamRole: player.teamRole,
                  uniformNumber: player.uniformNumber)
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
                'https://cap-baseball.com/images/${player.teamId}.jpg',
                height: 60,
                width: 60, errorBuilder: (BuildContext context,
                    Object exception, StackTrace? stackTrace) {
              return Image.network(
                'https://cap-baseball.com/images/undefined.jpg',
                height: 60,
                width: 60,
              );
            }),
          ),
        ],
      ),
    );
  }

  List<List<num>> _createRadarData(PlayerDetailModel playerDetail) {
    return [
      [50, 50, 50, 50, 50, 50, 50, 50],
      [
        playerDetail.stdAvg,
        playerDetail.stdOps,
        playerDetail.stdObp,
        playerDetail.stdSlg,
        playerDetail.stdEra,
        playerDetail.stdWinAvg,
        playerDetail.stdStrikeAvg,
        playerDetail.stdWhip,
      ]
    ];
  }

  Widget _buildRadarChart(
      BuildContext context, PlayerDetailModel playerDetail) {
    final data = _createRadarData(playerDetail);
    return CustomCard(
      title: "偏差値",
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.60,
          child: RadarChart.light(
            ticks: ticks,
            features: features,
            data: data,
            useSides: true,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
              ),
              height: 18,
              width: 40,
            ),
            const SizedBox(width: 5),
            const Text(
              'リーグ平均',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 18),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.6),
                border: Border.all(color: Colors.green, width: 3),
              ),
              height: 18,
              width: 40,
            ),
            const SizedBox(width: 5),
            Text(
              player.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ],
        ),
        const SizedBox(height: 3),
      ],
    );
  }
}

class ScoresTable extends StatelessWidget {
  const ScoresTable({Key? key, required this.playerDetail}) : super(key: key);

  final PlayerDetailModel playerDetail;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "累計の成績",
      children: [
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow("打撃", playerDetail.avg, playerDetail.stdAvg, 3),
                  const SizedBox(height: 10),
                  _buildRow("出塁率", playerDetail.obp, playerDetail.stdObp, 3),
                  const SizedBox(height: 10),
                  _buildRow("長打率", playerDetail.slg, playerDetail.stdAvg, 3),
                  const SizedBox(height: 10),
                  _buildRow("OPS", playerDetail.ops, playerDetail.stdAvg, 3),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                height: 213,
                child: VerticalDivider(
                  width: 1.0,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow("防御率", playerDetail.era, playerDetail.stdEra, 2),
                  const SizedBox(height: 10),
                  _buildRow(
                      "勝率", playerDetail.winAvg, playerDetail.stdWinAvg, 3),
                  const SizedBox(height: 10),
                  _buildRow("奪三振率", playerDetail.strikeAvg,
                      playerDetail.stdStrikeAvg, 2),
                  const SizedBox(height: 10),
                  _buildRow("WHIP", playerDetail.whip, playerDetail.stdWhip, 2),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildRow(String label, double score, double std, int fixNum) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          label,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 0.5),
        (() {
          if (score == -1) {
            return const Text(
              "ー",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                score.toStringAsFixed(fixNum),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _playerRank(std),
                style: TextStyle(
                    fontSize: 16,
                    color: _rankColor(std).withOpacity(0.9),
                    fontWeight: FontWeight.w500),
              ),
            ],
          );
        })(),
      ],
    );
  }

  String _playerRank(double std) {
    if (std >= 65) {
      return "S";
    } else if (std >= 60) {
      return "A";
    } else if (std >= 55) {
      return "B";
    } else if (std >= 50) {
      return "C";
    } else if (std >= 45) {
      return "D";
    } else if (std >= 40) {
      return "E";
    } else {
      return "F";
    }
  }

  Color _rankColor(double std) {
    if (std >= 65) {
      return Colors.orangeAccent;
    } else if (std >= 60) {
      return Colors.red;
    } else if (std >= 55) {
      return Colors.green;
    } else if (std >= 50) {
      return Colors.purple;
    } else if (std >= 45) {
      return Colors.teal;
    } else if (std >= 40) {
      return Colors.orange;
    } else {
      return Colors.blue;
    }
  }
}
