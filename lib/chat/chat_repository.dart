import 'package:asistencia_v2/chat/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final ChatProvider _chatProvider = ChatProvider();

  ChatRepository();

  void test(bool isError) {
    this._chatProvider.test(isError);
  }

  Stream<List<ChatModel>> getChats(String userId) {
    final resultsStream = Firestore.instance
        .collection("chat")
        .where("sender", isEqualTo: userId)
        .orderBy("date")
        .snapshots();

    final chatModelStream = resultsStream.map((QuerySnapshot query) {
      return query.documents.map((document) {
        print("doc $document");
        return ChatModel(
            document.documentID,
            (document['date'] as Timestamp).toDate().toIso8601String(),
            document['receiver'],
            document['sender'],
            // (await Firestore.instance
            //             .collection("chat")
            //             .document(document.documentID)
            //             .collection("messages")
            //             .orderBy("date")
            //             .limit(1)
            //             .getDocuments())
            //         .documents
            //         .first ??
            "",);
      }).toList();
    });

    // final chats = results.map((QuerySnapshot chat) {
    //   return ChatModel(
    //       chat.documentID,
    //       (chat['date'] as Timestamp).toDate().toIso8601String(),
    //       chat['receiver'],
    //       chat['sender'],
    //       (await Firestore.instance
    //                   .collection("chat")
    //                   .document(chat.documentID)
    //                   .collection("messages")
    //                   .orderBy("date")
    //                   .limit(1)
    //                   .getDocuments())
    //               .documents
    //               .first ??
    //           "");
    // }).toList();
    return chatModelStream;
  }
}
