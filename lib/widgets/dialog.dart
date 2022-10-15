import 'package:flutter/material.dart';

//Helper dialog class which accepts title and content
//Reusable widget
//NOTE: In future, add more fields via constructor for placeholder of button texts
class Dialog extends StatelessWidget {
  final String title;
  final String content;
  const Dialog({required this.title, required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          child: const Text(
            'Yes',
            style: TextStyle(fontSize: 20),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          child: const Text(
            'No',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
