import 'package:flutter/material.dart';
class NewsDetailScreen extends StatelessWidget {
  static const routeName = '/news_detail';
  @override
  Widget build(BuildContext context) {
    final newsItem = ModalRoute.of(context).settings.arguments as Map<String,String>;
    // final title = newsItem['title'];
    final author = newsItem['author'];
    final description = newsItem['description'];
    final imageUrl = newsItem['imageUrl'];
    final content = newsItem['content'];
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: <Widget>[
          Icon(Icons.more_vert)
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: FittedBox(
                child: Image.network(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(author,style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,)),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text('description: $description',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,)),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text('Content: $content',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,)),
            ),
          ],
        ),
      )
    );
  }
}