import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/maindrawer.dart';
import './read_later_detail_screen.dart';

class ReadLaterScreen extends StatefulWidget {
  static const routeName = '/readlater';
  @override
  _ReadLaterScreenState createState() => _ReadLaterScreenState();
}

class _ReadLaterScreenState extends State<ReadLaterScreen> {
  List items = [];
  Future<void> _fetchData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final userID = user.uid;
    await Firestore.instance
        .collection('Users')
        .document(userID)
        .collection('News')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        items.add(element);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (items.length == 0) {
            return Center(
              child: Text('No saved news'),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: 
            (context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300], width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        NetworkImage('${items[index]['imageUrl']}'),
                  ),
                  title: Text(
                    items[index]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () => {
                    Navigator.of(context)
                        .pushNamed(ReadLaterDetailScreen.routeName, arguments: {
                      'title': items[index]['title'],
                      'author': items[index]['author'],
                      'description': items[index]['description'],
                      'imageUrl': items[index]['imageUrl'],
                      'content': items[index]['content'],
                    })
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
