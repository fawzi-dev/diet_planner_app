
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String title,Color color){
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    ),
  );
}