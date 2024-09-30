// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool obscuretext;
  const Mytextfield(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscuretext,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
    );
  }
}
