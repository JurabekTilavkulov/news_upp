import 'package:flutter/material.dart';
import 'package:news_upp/pages/discrip_page.dart';
import 'package:news_upp/pages/pagelar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewPage extends StatefulWidget {
   PageViewPage({Key? key}) : super(key: key);


  @override
  State<PageViewPage> createState() => _PageViewState();
}



class _PageViewState extends State<PageViewPage> {

  PageController pageController=PageController();


  int currentPasition=0;

    List<Widget>_paglar=<Widget>[
    new Pages("assets/kubik.png"),
    new Pages("assets/archa.png"),
    new Pages("assets/bonka.png"),

  ];

  @override
  Widget build(BuildContext context) {
    print(currentPasition);
    return Scaffold(
      body:Column(
        children: [
          Container(
            height: 650,
            child:  PageView(

              children: _paglar,
              controller: pageController,
              onPageChanged: (numPage){
                setState(() {
                  currentPasition=numPage;
                });


              },
            ),

          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left:20),
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: JumpingDotEffect(
                          activeDotColor: Colors.blue,
                          dotHeight: 10,
                          dotWidth: 10,
                          dotColor: Colors.tealAccent,
                          verticalOffset: 20
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: GestureDetector(
                    onTap: (){
                      pageController.animateToPage(currentPasition-1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text("Back"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:10),
                  child: GestureDetector(
                    onTap: (){
                      pageController.animateToPage(currentPasition+1, duration: Duration(milliseconds: 3000), curve:Curves.easeIn);
                      setState(() {
                        if(currentPasition==2) Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));
                      });
                    },
                    child: Container(
                      width:90,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue

                      ),
                      child: Center(child: currentPasition==2?Text("Get Started",style: TextStyle(color: Colors.white)):Text("Next",style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )


    );
  }
}
