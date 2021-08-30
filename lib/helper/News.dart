import 'package:news_app/model/ArticleModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=292225ed31f64de8af900b2372d5c93b';
    var response = await http.get(Uri.parse(url));
    var jsonData =  jsonDecode(response.body);
    if(jsonData['status']=="ok")
      {
        jsonData["articles"].forEach((element){
          if(element['urlToImage']!=null && element["description"]!=null)
            {
              var str = element['publishedAt'];
              var newStr = str.substring(0,10) + ' ' + str.substring(11,23);
              DateTime dt = DateTime.parse(newStr);

              ArticleModel articleModel = ArticleModel(title: element['title'], author: element['author'], description: element['description'], url: element['url'], urlToImage: element['urlToImage'], content: element['content'], publishedAt: dt);
              news.add(articleModel);
            }
        });
      }

    news.sort((a,b)=> a.publishedAt.compareTo(b.publishedAt));


  }

}