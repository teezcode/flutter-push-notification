import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  const UserImagePicker({Key? key, required this.imagePickFn}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  void _pickImage() async{
    final pickedImageFile = await _picker.pickImage(source:ImageSource.gallery,
      imageQuality:50,
      maxHeight: 150,

    );
    setState((){
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:_pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Upload Image'),
        ),
      ],
    );
  }
}
