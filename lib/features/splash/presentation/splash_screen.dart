import 'package:flutter/material.dart';

// [A], [B], [C], [D], [E];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // [A]
  late AnimationController
      _controller; //ekhane dekliyar kora hoyeche ebong pore inisaliz hbe.
  late Animation<double> _fadeAmination; // ঐ

  /*
  [A] এখানে with ব্যাবহার করছি Mixin এর জন্যে। Mixin এর কাজ 
  হলো  একটি ক্লাস এর নির্দিষ্ট ফিচার অন্য ক্লাস এ যুক্ত করার জন্যে।
  */

  @override // [B]
  void initState() {
    super.initState();
    //[C]
    _controller = AnimationController(
      // [D]
      vsync: this, // [E] //TickerProvider eti required ache.
      duration: const Duration(seconds: 2),
    );
    _fadeAmination = Tween<double>(begin: 0.0, end: 1.0).animate(
        _controller); // Tween duiti man dhape dhape poriborton kore. eti Animation controller er maddhome control korte hbe, eti nije nije pori borton hoy na.
    _controller
        .forward(); // Animation suru korte, thachara repeat().. bebohar korte parai #Comment: na dile amimation suru hbe na.

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  /*
  [B] @override এখানে prant class এর methord override করছে এবং এটি নামের ভুল 
  থাকলে error দেখায়।  #BAD PRATICE: (@override না লিখলেও সমস্যা হয় না।) যদি নামের
   ভুল না থাকে।
   Benefit: @override লিখলে methord এর নাম ভুল থকলে error দেখায়।. 
   #Comment:  (@override না লিখলে আমরা মতে methord এর নাম ভুল করলে override 
   নাও হতে পারে।)
  
  [C] initState(){} - prothome ekbar run hoy, jokhon ekbar State poriborton 
  hoy. *State holo temporary data ja mutable & UI te poriborton ante pare.
   
  [D] AnimationController এখানে ব্যাবহার করছি animation করার জন্যে। 
  Question & Answer:
  Q. Keno "AnimationController ()" likhte hbe? ei namti evabei ba keno likhte 
  hbe?
    A. AnimationController() holo (import 'package:flutter/animation.dart';) 
    ekhan theke eseche. ei package e evabei name dewa ache.
  Q. ekhane to (import 'package:flutter/animation.dart';) package import kora 
  hoyni tahole kaj korche kivabe?
    A. (import 'package:flutter/material.dart';) er moddhe
     (import 'package:flutter/animation.dart';) package royeche..

  [E] vsync - holo "vartical syncronization". vsync bebohar korle frames lek
   kore na. vsync na bebohar korle flutter bujteparbe na kokhon update korte 
   hbe, sob somoy run hbe bettary ebong CPU er bebohar besi hbe.

   Question & Answer:
   Q. vsync: this,  ekhne "this" keno?
   A. "this" holo bortoman class er reference.
   Q. reference ki?
   A. eti kothay ache seti bole dewa.
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
