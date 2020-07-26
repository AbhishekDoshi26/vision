import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Help extends StatelessWidget {
  const Help({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        IconButton(
          alignment: Alignment.topRight,
          icon: Icon(FontAwesomeIcons.timesCircle),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.greenAccent,
      elevation: 60.0,
      title: Container(
        height: 200.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Instruction of use:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Click on the above button.',
                style: TextStyle(fontSize: 17.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Camera will open.',
                style: TextStyle(fontSize: 17.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Once the respected image is in the frame, tap on the screen',
                style: TextStyle(fontSize: 17.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Thank You for using!!',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
