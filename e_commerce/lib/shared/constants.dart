import 'package:flutter/material.dart';

final decorationTextfield = InputDecoration(
  // To delete borders
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: Colors.lightBlue,
    ),
  ),
  // fillColor: Colors.red,
  filled: true,
  contentPadding: const EdgeInsets.all(8),
);
