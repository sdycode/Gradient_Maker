
import 'package:flutter/material.dart';

class LightBorderElevatedButton extends StatelessWidget {
  final String buttonName;
  final Function onTap;

  const LightBorderElevatedButton({
    Key? key,
    required this.buttonName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(color: Colors.blue.shade100))),
        ),
        onPressed: () {
          onTap();
        },
        child: Text(
         buttonName,
          style: TextStyle(color: Colors.white),
        ));
  }
}
