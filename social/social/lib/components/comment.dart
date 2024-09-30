// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment(
      {super.key, required this.text, required this.time, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(text),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(user),
              Text(" . "),
              Text(time),
            ],
          ),
        ],
      ),
    );
  }
}
