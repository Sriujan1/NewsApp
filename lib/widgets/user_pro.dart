import 'package:flutter/material.dart';
import 'dart:io';
class UserProfileImage extends StatelessWidget {
  final String userImage;
  final Key key;
  UserProfileImage(this.userImage,{this.key});
  @override
  
  Widget build(BuildContext context) {
    //File image;
    return Stack(
          children: [
             Column(
        children: <Widget>[
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(userImage),
          ),
          
        ],
      ),
          ]
    );
  }
}