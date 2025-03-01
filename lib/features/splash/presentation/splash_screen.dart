import 'package:flutter/material.dart';

// [A], [B], [C], [D];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // [A]
  late AnimationController _controller;
  late Animation<double> _fadeAmination;

  /*
  [A] এখানে with ব্যাবহার করছি Mixin এর জন্যে। Mixin এর কাজ 
  হলো  একটি ক্লাস এর নির্দিষ্ট ফিচার অন্য ক্লাস এ যুক্ত করার জন্যে।
  */

  @override // [B]
  void initState() {
    //[C]
    _controller = AnimationController(
      // [D]
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAmination = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/home");
    });

    super.initState();
  }

  /*
  [B] @override ekhane prant class er methord override koreche ebong namer vul thakle error dekhay.  #BAD PRATICE(@override na likleo somossa hoy na)
   Benefit: @override likhle methord name vul thakle error dekhay. @override na likhle amar mote methord er name vul korle override nao hte pare.
  
  [C] initState(){} - prothome ekbar run hoy, jokhon ekbar State poriborton hoy. *State holo temporary data ja mutable & UI te poriborton ante pare.
   
  [D] AnimationController bebohar korchi animation korar jonne. 
  Q. Keno "AnimationController ()" likhte hbe? ei namti evabei ba keno likhte hbe?
  A. AnimationController() holo (import 'package:flutter/animation.dart';) ekhan theke eseche.
  Q. ekhane to (import 'package:flutter/animation.dart';) package import kora hoyni tahole kaj korche kivabe?
  A. (import 'package:flutter/material.dart';) er moddhe (import 'package:flutter/animation.dart';) package royeche..
   */

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAmination,
          child: Text(
            "Lets Start Drawing.. ",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
