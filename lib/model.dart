import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Model {

  static final Model _singleton = Model._init();

  bool _loading = false;

  factory Model() {
    return _singleton;
  }

  Model._init();

  Stream<QuerySnapshot> getVoteOptions() {
    return Firestore.instance.collection('vote_options').snapshots();
  }

  void upvote(DocumentSnapshot document) async {
    if (this._loading) return;
    this._loading = true;
    await Future.delayed(Duration(milliseconds: 300));
    await Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(document.reference);
      await transaction.update(freshSnap.reference, {
        'votes': freshSnap['votes'] + 1
      });
      this._loading = false;
    });
  }

  Future<dynamic> addOption(String name) {
    if (this._loading) return Future.value(null);
    this._loading = true;
    return Firestore.instance.collection('vote_options').add({
      "name": name,
      "votes": 0,
    }).then((_) {
      this._loading = false;
    });
  }
}