import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class UserImagePicker extends StatefulWidget {
   final void Function(File pickedImage) imagePickfn;
  UserImagePicker(this.imagePickfn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future _openGallery(BuildContext context) async {
    var pickedImageFile = await picker.getImage(
     source: ImageSource.gallery,
     imageQuality: 70,
     maxWidth: 150,
     );
   setState(() {
     _image = File(pickedImageFile.path);
   });
   Navigator.of(context).pop();
   widget.imagePickfn(_image);
  }


  Future _openCamera(BuildContext context) async {
    var pickedImageFile = await picker.getImage(
     source: ImageSource.camera,
     imageQuality: 70,
     maxWidth: 150,
     );
   setState(() {
     _image = File(pickedImageFile.path);
   });
   Navigator.of(context).pop();
   widget.imagePickfn(_image);
  }


  Future<void> _showChoiceDialog(BuildContext context) async {
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Make a choice!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  _openGallery(context);
                }
              ),
              Padding(padding: EdgeInsets.all(6)),
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  _openCamera(context);
                }
              )
      ],),
      ),
      );
    });
  } 
  // Future<void> _pickedImage() async {
  //  final pickedImageFile = await picker.getImage(
  //    source: ImageSource.camera,
  //    imageQuality: 70,
  //    maxWidth: 150,
  //    );
  //  setState(() {
  //    _image = File(pickedImageFile.path);
  //  });
  //  widget.imagePickfn(_image);
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         CircleAvatar(
           radius: 45,
           backgroundColor: Colors.grey,
           backgroundImage: _image != null ? FileImage(_image) :  null,
           ),
                  FlatButton.icon(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    icon: Icon(Icons.image),
                    label: Text('Add an image'),
                    textColor: Theme.of(context).accentColor,
                    ),
      ],
    );
  }
}