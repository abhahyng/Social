// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/auth/loginorregister.dart';
import 'package:social/pages/homepage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context, snapshot){
        if(snapshot.hasData){
          return Homepage();
        }
        else{
          return const Loginorregister();
        }
       },
       ),
    );
  }
}