import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _authentication = FirebaseAuth.instance;
  // 페이지가 만들어지는 시점에 loggeduser가 업데이트가 되기를 원함(한번만)
  User? loggedUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        // null이 아니라면 loggedUser에 user를 넣어보자
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  //Navigator.pop(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                //chat에 해당하는 컬렉션이 변경되는걸 주시, 시간순으로 정렬하지 않으면 id순으로 정렬되므로 시간순으로
                  stream: FirebaseFirestore.instance.collection('chat').orderBy('timestamp').snapshots(),
                  builder: (context,snapshot) {
                    //스냅샷이 받아오는걸 기다리는중이면
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context,index) {
                          return ChatElement(
                            isMe: docs[index]['uid'] == _authentication.currentUser!.uid,
                            userName: docs[index]['userName'],
                            text: docs[index]['text'],
                          );
                        }
                    );
                  }
              ),
            ),
            NewMessage(),
          ],
        )
    );
  }
}


class ChatElement extends StatelessWidget {
  const ChatElement({super.key, this.isMe, this.userName, this.text});

  final bool? isMe;
  final String? userName;
  final String? text;

  @override
  Widget build(BuildContext context) {
    if (isMe!) {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ChatBubble(
          clipper: ChatBubbleClipper6(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 20),
          backGroundColor: Colors.blue,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userName!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text!,
                  style: TextStyle(
                    color: Colors.white,),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: ChatBubble(
          clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
          backGroundColor: Color(0xffE7E7ED),
          margin: EdgeInsets.only(top: 20),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text!,
                  style: TextStyle(
                    color: Colors.black,),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}



class NewMessage extends StatefulWidget {
  const NewMessage({super.key});
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String newMessage = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'New Message',
            ),
            onChanged: (value) {
              setState(() {
                newMessage = value;
              });
            },
          ),
        )),
        IconButton(
            color: Colors.deepPurple, 
            // 입력 칸에 공백아닌 문자가 입력된 상태여야 버튼이 활성화
            onPressed: newMessage.trim().isEmpty ? null : () async {
              final currentUser = FirebaseAuth.instance.currentUser;
              final currentUserInfo = await FirebaseFirestore.instance.collection('user').doc(currentUser!.uid).get();
              FirebaseFirestore.instance.collection('chat').add({
                'text' : newMessage,
                // 현재 유저 정보를 읽고, 읽은 데이터에서 userName을 추출
                'userName' : currentUserInfo.data()!['userName'],
                'timestamp' : Timestamp.now(),
                'uid' : currentUser.uid,
              });
              _controller.clear();
            }, 
            icon: Icon(Icons.send))
      ],
    );
  }
}
