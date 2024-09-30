import 'package:flutter/material.dart';
import 'package:social/pages/LoginPage.dart';
import 'package:social/pages/registerPage.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  bool showloginpage = true;

  void togglepages(){
    setState(() {
      showloginpage = !showloginpage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showloginpage){
      return Loginpage(onTap: togglepages);
    }
    else{
      return Registerpage(onTap: togglepages);
    }
  }
}