// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social/components/buttons.dart';
import 'package:social/components/textfield.dart';

class Loginpage extends StatefulWidget {
  final Function()? onTap;
  const Loginpage({super.key, required this.onTap});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
//loading circle
  void signIn() async {
    showDialog(context: context, builder: (context) => const Center(
      child : CircularProgressIndicator(),
    ),);
  



  
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displaymessage(e.code);
    }
  }

  void displaymessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.ac_unit_sharp,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                //text
                Text("Welcome back we missed you!!"),
                const SizedBox(
                  height: 20,
                ),
                //textfield
                Mytextfield(
                    controller: emailTextController,
                    hinttext: 'Enter email',
                    obscuretext: false),

                const SizedBox(
                  height: 10,
                ),
                Mytextfield(
                    controller: passwordTextController,
                    hinttext: 'Enter password',
                    obscuretext: true),
                const SizedBox(
                  height: 15,
                ),
                //sign in button
                Mybutton(
                  onTap: signIn,
                  text: 'Log In',
                ),
                const SizedBox(
                  height: 10,
                ),
                //register tab
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not joined our community yet ?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
