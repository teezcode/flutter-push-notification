import 'package:chat_notification/widgets/chat/message_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userdata = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
        //future: userdata,
        builder: (ctx, futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
      return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final chatDocs = chatSnapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatSnapshot.data!.docs.length,
                  itemBuilder: (ctx,  index) =>
                      MessageBubble(
                          message: chatDocs[index]['text'],
                          userName: chatDocs[index]['username'],
                          userImage: chatDocs[index]['userImage'],
                          isMe: chatDocs[index]['userId'] == userdata!.uid,
                        //key: ValueKey(chatDocs[index].id),
                        //key: ValueKey(chatDocs[index].documentID),
                      ),
                );
              });
        }
    );
  }
}
