import 'package:flutter/material.dart';

Widget inputFile(
    {label,
    obscureText = false,
    function,
    keyboardInput = TextInputType.emailAddress}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        keyboardType: keyboardInput,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
            borderRadius: BorderRadius.circular(14),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
          ),
        ),
        onChanged: function,
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
