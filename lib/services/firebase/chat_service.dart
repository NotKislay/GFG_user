import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Message.dart';

class ChatService {
  //fire store instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get all the users
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String serviceName, String senderId,
      String senderName, String content) async {
    final message = {
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
      'sender_mail': senderId,
      'sender_name': senderName,
    };
    log("$message: chatService working fine");
    try {
      await _firestore
          .collection('serviceChats')
          .doc(serviceName)
          .collection('messages')
          .add(message);
    } catch (e) {
      log("Exception in sending message $e");
    }
  }

  //get messages
  Stream<List<Message>> getMessages(String serviceName) {
    try {
      return _firestore
          .collection('serviceChats')
          .doc(serviceName)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Message(
            content: doc['content'],
            timestamp: (doc['timestamp'] as Timestamp).toDate(),
            senderId: doc['sender_mail'],
            senderName: doc['sender_name'],
          );
        }).toList();
      });
    } catch (e) {
      log("Firestore query error: $e");
      rethrow;
    }
  }

  //open and get all messages
  Future<void> openChat(String serviceName, String userId) async {
    await createOrJoinChat(serviceName);
  }

  //create or join chat
  Future<void> createOrJoinChat(String serviceName) async {
    final chatDoc = _firestore.collection('serviceChats').doc(serviceName);
    log("need to open $serviceName");
    try {
      final chatSnapshot = await chatDoc.get();
      if (!chatSnapshot.exists) {
        log("CREATING A CHAT SERVICE WITH $serviceName");
        await chatDoc.set({
          'serviceName': serviceName,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        log("Chat already present!!");
      }
    } catch (e) {
      log('Error creating or joining chat: $e');
    }
  }
}
