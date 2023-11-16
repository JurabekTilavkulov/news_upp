import 'package:flutter/material.dart';




class Pages extends StatelessWidget {




  String imagePath;

  Pages(this.imagePath);
  PageController p_controller=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath),
          Padding(padding: EdgeInsets.only(left: 10),
             child: Text("Lorem Ipsum is simply\ndummy",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),),
          Padding(padding: EdgeInsets.only(left: 10,right: 10),
             child:  Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry."),),

        ],
      )
    );
  }


}
