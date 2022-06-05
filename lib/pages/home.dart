import 'package:cap_member_app/models/game_result_model.dart';
import 'package:cap_member_app/pages/game_results.dart';
import 'package:cap_member_app/services/cap_service.dart';
import 'package:cap_member_app/widgets/game_result_tile.dart';
import 'package:cap_member_app/widgets/label_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final capService = CapService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Image.asset(
            'assets/images/jcba_logo.png',
            height: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder<List<GameResultModel>>(
          future: capService.getGameResults(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<GameResultModel> gameResults = snapshot.data!;

              return ListView(
                children: [
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text(
                      '結果速報',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (_, index) => GameResultTile(
                      gameResult: gameResults[index],
                      index: index,
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                  ),
                  const SizedBox(height: 2),
                  Center(
                    child: LabelButton(
                      labelText: 'さらに見る',
                      onPressed: () {
                        pushNewScreen(context, screen: GameResults());
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
