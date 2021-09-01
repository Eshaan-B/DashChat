import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const routeName="chatScreen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/LezNXeWSqv9tJnZE6uhU/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          final documents = snapshotData.data!.documents;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(documents[index]['text']),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sticky_note_2),
        onPressed: () {
          print('adding...');
          Firestore.instance
              .collection('chats/LezNXeWSqv9tJnZE6uhU/messages')
              .add({'text': 'New data biatch'});
        },
      ),
    );
  }
}
