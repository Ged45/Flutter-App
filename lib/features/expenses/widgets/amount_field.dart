import'package:flutter/material.dart';
import'./box_decoration.dart';


 String selectedCategory = 'Food';

  final amountCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final storeCtrl = TextEditingController();

  Widget amountField({required TextEditingController controller}) => Container(
  
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: boxDecoration(),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'ETB  0.00',
            hintStyle: TextStyle(color: Colors.black38),
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // increment and decrement arrows can be added here in future
                
                
              ],
            ),
          ),
        ),
      );