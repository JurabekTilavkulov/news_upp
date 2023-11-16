import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:news_upp/pages/page_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
   Future.delayed(const Duration(seconds: 2),(){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>PageViewPage()));
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/bosh.png"),
            LoadingAnimationWidget.discreteCircle(color: Colors.red, size: 60),
          ],
        )
      ),
    );
  }
}
