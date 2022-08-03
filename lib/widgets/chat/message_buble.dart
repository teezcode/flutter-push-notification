import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {

  final String message;
  final bool isMe;
  final String userName;
  final String userImage;
  //final Key key;

  const MessageBubble({required this.message, required this.isMe, required this.userName, required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: !isMe ?Radius.circular(0) : Radius.circular(12),
                      bottomRight: isMe ?Radius.circular(0) : Radius.circular(12)
                  )
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(
                  //   future : FirebaseFirestore.instance.collection('users').doc(userName).get(),
                  //   builder: (ctx, AsyncSnapshot<dynamic> snapshot){
                  //     if(snapshot.connectionState == ConnectionState.waiting){
                  //       return Text('Loading....');
                  //     }
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Colors.white
                    ),
                  ),
                  Text(
                    message,style: TextStyle(
                    color: isMe ? Colors.black : Colors.white,
                  ),
                    textAlign:isMe ? TextAlign.end : TextAlign.start ,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
            left: isMe ? null : 120,
            right: isMe ? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            )
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
