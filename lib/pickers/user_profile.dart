import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/widgets/user_pro.dart';
class UserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx, futureSnapshot) { 
                    if(futureSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text('No Image')
                      );
                    }
                  return  StreamBuilder(
      stream: Firestore.instance.collection('userDetails').snapshots(),
      builder: (ctx, dataSnapshot) {
        if(dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('No image')
          );
        }
        final dataDocs = dataSnapshot.data.documents;
        return ListView.builder(
            reverse: true,
            itemCount: dataDocs.length,
            itemBuilder: (ctx, index) => UserProfileImage(
              dataDocs[index]['user_image'],
            
            key: ValueKey(dataDocs[index].documentID),
            )
            );
                  }       
        ); 
      }
    );
  }
}