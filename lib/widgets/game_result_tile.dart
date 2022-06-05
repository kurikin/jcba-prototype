import 'package:auto_size_text/auto_size_text.dart';
import 'package:cap_member_app/helpers/util.dart';
import 'package:cap_member_app/models/game_result_model.dart';
import 'package:flutter/material.dart';

class GameResultTile extends StatelessWidget {
  GameResultTile({Key? key, required this.gameResult, required this.index})
      : super(key: key);

  final GameResultModel gameResult;
  final int index;
  final Util util = Util.instance;

  @override
  Widget build(BuildContext context) {
    bool isFirstWinner = gameResult.firstRun > gameResult.lastRun;

    return Card(
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              gameResult.gameName,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 5),
            Text(
              gameResult.gameDate,
              style: const TextStyle(color: Colors.black54, fontSize: 15),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTeamRow(
                  gameResult.firstTeamName,
                  gameResult.firstRun,
                  isFirstWinner,
                  (index * 2) % 6,
                ),
                const SizedBox(height: 20),
                _buildTeamRow(
                  gameResult.lastTeamName,
                  gameResult.lastRun,
                  !isFirstWinner,
                  (index * 2 + 1) % 6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamRow(String teamName, int score, bool isWin, int imgNum) {
    return Row(
      children: [
        Image.asset(util.unifromFilePath(imgNum), width: 18, height: 18),
        const SizedBox(width: 12),
        Expanded(
          child: AutoSizeText(
            teamName,
            maxLines: 1,
            style: TextStyle(
                fontWeight: isWin ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16),
          ),
        ),
        const SizedBox(width: 3),
        Text(
          score.toString(),
          style: TextStyle(
            fontWeight: isWin ? FontWeight.w600 : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 5),
        isWin
            ? const Icon(Icons.arrow_left, size: 30)
            : const SizedBox(width: 30),
        const SizedBox(width: 10),
      ],
    );
  }
}
