import 'package:flutter/material.dart';
import 'package:news_upp/model/model1.dart';
import 'package:url_launcher/url_launcher.dart';

class SinglePage extends StatelessWidget {
   SinglePage({required this.modelNews1, required this.indexItem});
  ModelNews1 modelNews1;
  int indexItem;


  @override
  Widget build(BuildContext context) {
    Uri uri=Uri.parse('${modelNews1.articles?[indexItem].url}');
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                },
                  icon: Icon(Icons.reset_tv),),
              ],
            ),
          ),//tepa birinchi qator
          Container(
            height:80,
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${modelNews1.articles?[indexItem].source?.name}",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("${modelNews1.articles?[indexItem].publishedAt?.substring(0,10)}"),
                  ],
                ),
                MaterialButton(
                  onPressed: ()async{
                    await launchUrl(uri);
                  },
                  color: Colors.blue,
                  clipBehavior: Clip.antiAlias,
                  child: Text("Following"),
                )
              ],
            ),
          ),// ikkinchi qator
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 5, right: 5),
            height:500,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color:Colors.blue,
                  ),
                    child: Image.network("${modelNews1.articles?[indexItem].urlToImage}",fit: BoxFit.fill,)),
                Text("${modelNews1.articles?[indexItem].title}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text("${modelNews1.articles?[indexItem].description}"),
              ],
            ),
          )
        ],
      ),)

    );
  }
}
