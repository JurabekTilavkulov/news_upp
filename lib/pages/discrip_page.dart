import 'package:flutter/material.dart';
import 'package:news_upp/model/model1.dart';
import 'package:news_upp/pages/single_page.dart';
import 'package:news_upp/service/NetService.dart';

class NewsPage extends StatefulWidget {
   NewsPage({Key? key}) : super(key: key);


  @override
  State<NewsPage> createState() => _NewsPageState();
}
enum NetDataStatus{
  loading,
  loaded,
  error
}

class _NewsPageState extends State<NewsPage> {
  String apple="https://newsapi.org/v2/everything?q=apple&from=2023-11-15&to=2023-11-15&sortBy=popularity&apiKey=57d556b41e0a40169cbecea58e562d76";
  String tesla="https://newsapi.org/v2/everything?q=tesla&from=2023-10-16&sortBy=publishedAt&apiKey=57d556b41e0a40169cbecea58e562d76";
  String business="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=57d556b41e0a40169cbecea58e562d76";
  String wallStreetJ="https://newsapi.org/v2/everything?domains=wsj.com&apiKey=57d556b41e0a40169cbecea58e562d76";

  NetService netService=NetService();  // InternetService dan bject olindi
  ModelNews1 modelApple=ModelNews1();  // ModelClass dan object olindi
  ModelNews1 modelTesla=ModelNews1();  // ModelClass dan object olindi
  ModelNews1 modelBusiness=ModelNews1();  // ModelClass dan object olindi
  ModelNews1 modelwallS=ModelNews1();  // ModelClass dan object olindi

  NetDataStatus status=NetDataStatus.loading;
  int buttomNB=0;



  @override
  void initState() {
    malumotOlish();
    super.initState();
  }

  void malumotOlish()async{
    netService.getInformation(apple).then((value){
      setState(() {
        modelApple=value;

      });


    });
    netService.getInformation(tesla).then((value){
      setState(() {
        modelTesla=value;

      });


    });
    netService.getInformation(business).then((value){
      setState(() {
        modelBusiness=value;

      });

    });
    netService.getInformation(wallStreetJ).then((value){
      setState(() {
        modelwallS=value;
        status=NetDataStatus.loaded;
      });


    });
  }

  @override
  Widget build(BuildContext context) {
    switch(status){
      case NetDataStatus.loading:return Scaffold(body: Center(child: CircularProgressIndicator(),),);
      case NetDataStatus.loaded:return Scaffold(
          body:SafeArea(
              child: Column(
            children: [
              Row(//Tepa birinchi qator
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/bosh.png",height: 60,),
                  Icon(Icons.add_alert_outlined)
                ],
              ),//Tepa birinchi qator
              DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    Container(   //Tabbar qismi ikkinchi qator

                      child: TabBar(

                        labelColor: Colors.blue,
                        isScrollable: true,indicatorSize: TabBarIndicatorSize.tab,

                        onTap: (index){
                          print(index);
                        },
                        tabs: [
                          Tab(text:"Apple"),
                          Tab(text:"Tesla"),
                          Tab(text:"Business headlines"),
                          Tab(text:"Wall Street Journal"),
                        ],
                      ),
                    ),//Tabbar qismi ikkinchi qator
                    Container(      // ListView qismi Uchinchi qator
                      width:MediaQuery.of(context).size.width,
                      height: 550,
                      child: TabBarView(
                        children: [
                          Container(

                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return builtItem(modelApple,index);
                              },
                              itemCount: 10,

                            ),
                          ),  //Apple page//
                          Container(

                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return builtItem(modelTesla,index);
                              },
                              itemCount: 10,

                            ),
                          ),//Tesla page
                          Container(

                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return builtItem(modelBusiness,index);
                              },
                              itemCount: 10,

                            ),
                          ), //Business page
                          Container(

                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return builtItem(modelwallS,index);
                              },
                              itemCount: 10,

                            ),
                          ),//Wall Street Journal page
                        ],
                      ),
                    )  // ListView qismi Uchinchi qator
                  ],
                ),
              )
            ],
          )),
        bottomNavigationBar: BottomNavigationBar(

          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.brown,
          currentIndex: buttomNB,
          onTap: (index){

            setState(() {
              buttomNB=index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.explore),label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: "Bookmark"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          ],
        ),
      );
      case NetDataStatus.error:return Scaffold(body: Center(child:Text("Network is Error")),);
    }

  }
  Widget builtItem(ModelNews1 news1,int index){

    return GestureDetector(
      onTap: (){
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SinglePage(modelNews1: news1,indexItem: index,)));
        });
      },
        child:Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
          Image.network("${news1.articles?[index].urlToImage}",width: 150,fit: BoxFit.cover ,isAntiAlias: true,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              width: 195,
                child:ConstrainedBox(
                  constraints: BoxConstraints(maxWidth:25),
                    child: Text("${news1.articles?[index].title}",
                  )) )
               ,
            Container(
              width: 150,
                child: Expanded(child: Text("${news1.articles?[index].author}",
                    overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold))))
          ],)
        ],
      ),
    ));

  }
}

