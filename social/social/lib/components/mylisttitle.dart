import 'package:flutter/material.dart';

class MyListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MyListTitle({super.key, required this.icon, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ),
        onTap: onTap,

        title: Text(
          text,
          style: TextStyle(color: Colors.grey[900]),
        ),
      ),
    );
  }
}
