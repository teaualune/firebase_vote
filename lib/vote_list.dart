import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model.dart';

class VoteListPage extends StatelessWidget {
  const VoteListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add_circle_outline),
            tooltip: "Add Voting option",
            onPressed: () {
              Navigator.of(context).pushNamed("/add");
            },
            alignment: Alignment.centerRight,
          ),
        ],
      ),
      body: new StreamBuilder(
          stream: Model().getVoteOptions(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) return const Text('Loading...');

            return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemExtent: 55.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return _buildListItem(context, ds);
              }
            );
          }),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new ListTile(
      key: new ValueKey(document.documentID),

      title: new Container(

        decoration: new BoxDecoration(
          border: new Border.all(color: const Color(0x80000000)),
          borderRadius: new BorderRadius.circular(5.0),
        ),

        padding: const EdgeInsets.all(10.0),

        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(document['name']),
            ),
            new Text(document['votes'].toString()),
          ],
        ),
      ),

      onTap: () {
        Model().upvote(document);
      },
    );
  }
}
