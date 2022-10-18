import 'package:flutter/widgets.dart';
import 'package:lettutor/themes/main_theme.dart';

import '../../model/user.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MainTheme(
        context: context,
        child: const Center(
          child: Text('Profile'),
        ));
  }
}
