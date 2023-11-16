import 'package:dio/dio.dart';
import '../model/model1.dart';


class NetService{
  Dio dio=Dio();
  Future<ModelNews1> getInformation(String netUrl)async{
    //...top-headlines?country=us&... ? belgisinixam olib tashlash kerak
    Response response=await dio.get(netUrl);
    ModelNews1 modelNews1=ModelNews1();
    modelNews1=ModelNews1.fromJson(response.data);
    return modelNews1;
  }
}