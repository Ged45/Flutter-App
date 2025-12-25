import'package:flutter/material.dart';

  BoxDecoration boxDecoration({bool active = false}) => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: active
            ? Border.all(color: Colors.blue, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      );