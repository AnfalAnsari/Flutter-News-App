
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/helper/News.dart';
import 'package:news_app/model/ArticleModel.dart';


void main() {
  runApp(Home());
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }
  getNews() async
  {
   News newsclass = News();
   await newsclass.getNews();
   articles = newsclass.news;
   setState(() {
     loading = false;
   });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("News"),
          Text(
            "App",
            style: TextStyle(color: Colors.blue),
          )
        ],
      ),
      elevation: 0.0,
    ),
    body: loading ? Center(
      child: Container(
        child: CircularProgressIndicator(),

      ),
    ):Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
            itemCount: articles.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
            return NewsTile(imageURl: articles[index].urlToImage, title: articles[index].title, desc: articles[index].description);
         }),
      )
    );
  }
}

class NewsTile extends StatelessWidget {
  final imageURl , title, desc;
  NewsTile({@required this.imageURl, @required this.title, @required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imageURl,
          ),
          Text(title, style: TextStyle(
              fontSize: 17,
              fontWeight:
              FontWeight.bold),
          ),
          Text(desc, style: TextStyle(
            color: Colors.black45,
          ),)
        ],
      ),
    );
  }
}





