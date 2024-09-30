// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/buttons.dart';
import 'package:social/components/textfield.dart';

class Registerpage extends StatefulWidget {
  final Function()? onTap;
  const Registerpage({super.key, required this.onTap});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordconfirmTextController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordTextController.text != passwordconfirmTextController.text) {
      Navigator.pop(context);
      displaymessage("Passwords don't match!");
      return;
    }
    try {
      //creating user

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);

          //creating document in firebase to store user data
          FirebaseFirestore.instance.collection('Users')
          .doc(userCredential.user!.email)
          .set({
            'username' : emailTextController.text.split('@')[0],
            'Bio' : 'Empty bio...'
          });

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
      backgroundColor:  Theme.of(context).colorScheme.surface,
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
                Text("Let's create a path for your new journey!!"),
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
                  height: 10,
                ),
                Mytextfield(
                    controller: passwordconfirmTextController,
                    hinttext: 'Confirm Pasword',
                    obscuretext: true),
                const SizedBox(
                  height: 15,
                ),
                //sign in button
                Mybutton(
                  onTap: signUp,
                  text: 'Sign In',
                ),
                const SizedBox(
                  height: 10,
                ),
                //register tab
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a part of community ?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login Now',
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
