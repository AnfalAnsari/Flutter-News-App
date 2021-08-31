import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/helper/News.dart';

import 'package:news_app/model/ArticleModel.dart';
import 'package:news_app/views/article_view.dart';

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



  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;

    setState(() {
      loading = false;
    });
  }
  Future<void> refresh() async{
    setState(() {
      getNews();
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
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RefreshIndicator(
              onRefresh: refresh,
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return NewsTile(
                          imageURl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          publishedAt: articles[index].str_publishedAt,
                          url: articles[index].url,);
                    }),
              ),
            ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final imageURl, title, desc, publishedAt,url;
  NewsTile(
      {@required this.imageURl,
      @required this.title,
      @required this.desc,
      @required this.publishedAt,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(url)));
        
       },
        child: Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imageURl,
            ),
          ),
          SizedBox(height:5),
          Align(
            alignment: Alignment.topLeft,

            child: Text(
              title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),


          SizedBox(height: 8),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              publishedAt,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          ),
          Text(
            desc,
            style: TextStyle(
              color: Colors.black45,
            ),
          )
        ],
      ),
    ));
  }
}
