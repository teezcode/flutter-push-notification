import 'dart:io';

import 'package:chat_notification/widgets/ImagePicker/imagePicker.dart';
import 'package:flutter/material.dart';


class AuthForm extends StatefulWidget {

  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
      String email,
      String userName,
      String password,
      File image,
      bool isLogin,
      BuildContext ctx
      )
  submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image){
    _userImageFile = image;
  }

  void _trySubmit(){
   final isValid = _formKey.currentState!.validate();
   FocusScope.of(context).unfocus();

   if(_userImageFile == null && !_isLogin){
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an image')));
     return;
   }

   if(isValid){
     _formKey.currentState!.save();
     widget.submitFn(
       _userEmail.trim(),
       _userName.trim(),
       _userPassword.trim(),
       _userImageFile!,
       _isLogin,
       context
     );
   }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)
                  UserImagePicker(imagePickFn: _pickedImage,),
                  TextFormField(
                    key: ValueKey('email'),
                    validator:(value){
                      if(value!.isEmpty || !value.contains('@')){
                        return 'Please enter a valid email address';
                      }
                      return null ;
                    } ,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value){
                      _userEmail = value!;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value){
                      if (value!.isEmpty || value.length < 4){
                        return 'please enter at least 4 characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Username'
                    ),
                    onSaved: (value){
                      _userName = value!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value){
                      if(value!.isEmpty || value.length < 7 ){
                        return 'Password too short';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Password'
                    ),
                    obscureText: true,
                    onSaved: (value){
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(height: 12,),
                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                  ElevatedButton(
                      onPressed:_trySubmit,
                      child: Text(_isLogin ? 'Login' : 'SignUp')),
                  if(!widget.isLoading)
                  TextButton(
                      onPressed: (){
                        setState((){
                          _isLogin = !_isLogin;
                        });
                      },
                      child:  Text( _isLogin ? 'Create New Account' : 'Already have an account')
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
