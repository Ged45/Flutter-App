import 'package:flutter/material.dart';
import'./box_decoration.dart';
  Widget textField({
    required TextEditingController controller,
    required String hint,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: boxDecoration(),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
        ),
      );