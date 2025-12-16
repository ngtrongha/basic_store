import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../logging/talker.dart';

@RoutePage()
class TalkerLogsScreen extends StatelessWidget {
  const TalkerLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(talker: talker);
  }
}
