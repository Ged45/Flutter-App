
import 'package:flutter/material.dart';
BoxDecoration cardDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          blurRadius: 12,
          color: Colors.black12,
          offset: Offset(0, 6),
        )
      ],
    );
