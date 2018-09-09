import 'package:flutter/material.dart';
import 'model.dart';

class AddVoteOptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return new Padding(
    //   padding: EdgeInsets.all(16.0),
    //   child: new AddVoteOptionForm(),
    // );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Option"),
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new AddVoteOptionForm(),
      ),
    );
  }
}

class AddVoteOptionForm extends StatefulWidget {
  @override
  AddVoteOptionFormState createState() {
    return new AddVoteOptionFormState();
  }
}

class AddVoteOptionFormState extends State<AddVoteOptionForm> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("Option Name"),
          new Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: new TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the option name';
                }
              },
              controller: _nameController,
            ),
          ),
          new RaisedButton(
            child: new Text("Add"),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(
                  new SnackBar(
                    content: new Text("Added"),
                  ),
                );
                await Model().addOption(_nameController.text);
                Navigator.of(context).pop();
              }
            }
          )
        ],
      ),
    );
  }
}
