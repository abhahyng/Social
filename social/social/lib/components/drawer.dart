// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:social/components/mylisttitle.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer({super.key, required this.onProfileTap,required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
              size: 75,
            ),
          ),
          MyListTitle(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),
          MyListTitle(icon: Icons.person, 
          text: 'P R O F I L E', 
          onTap: onProfileTap,
          ),
          MyListTitle(icon: Icons.power_settings_new_rounded, 
          text: 'L O G O U T', 
          onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}
