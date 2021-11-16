import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lost_found_pet_prototype/router.dart';
import 'package:lost_found_pet_prototype/view_model/navigation_model.dart';
import 'package:provider/provider.dart';

class NewPostFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<User>(context);
    final _navigatorKey = Provider.of<GlobalNavigation>(context).value;

    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        (_currentUser == null)
            ? _navigatorKey.currentState.pushNamed(Routers.userLogin)
            : _navigatorKey.currentState.pushNamed(Routers.postCreate);
      },
      child: Icon(LineIcons.plus),
    );
  }
}
