import 'package:chat_notification/widgets/chat/messages.dart';
import 'package:chat_notification/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter chat'),
        actions: [
          DropdownButton(
              icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            items: [
              DropdownMenuItem(child:
               Row(
                children: const [
                  Icon(Icons.exit_to_app,color: Colors.black,),
                  SizedBox(width: 8,),
                  Text('Log Out')
                ],
              ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier){
              if(itemIdentifier == 'logout'){
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child:Column(
          children: const [
            Expanded(
                child: Messages()
            ),
            NewMessage()
          ],
        ) ,
      ),
    );
  }
}

