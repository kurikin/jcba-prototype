import 'package:cap_member_app/helpers/util.dart';
import 'package:cap_member_app/widgets/custom_chip.dart';
import 'package:flutter/material.dart';

class PlayerChips extends StatelessWidget {
  PlayerChips({Key? key, required this.teamRole, required this.uniformNumber})
      : super(key: key);

  final String? teamRole;
  final String? uniformNumber;

  final Util util = Util.instance;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        if (!util.nullOrEmpty(teamRole))
          CustomChip(label: teamRole!, color: Colors.green),
        if (!util.nullOrEmpty(uniformNumber))
          CustomChip(label: '#$uniformNumber', color: const Color(0xff228be6)),
      ],
    );
  }
}
