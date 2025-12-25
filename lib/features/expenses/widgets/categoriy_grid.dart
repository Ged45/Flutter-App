import'package:flutter/material.dart';
import'./box_decoration.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  String _selectedCategory = 'Food';

  final amountCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final storeCtrl = TextEditingController();

  final categories = const [
    ('Food', '🍔'),
    ('Travel', '✈️'),
    ('Entertainment', '🎬'),
    ('Shopping', '🛒'),
    ('Health', '🩺'),
    ('Utility', '💧'),
  ];

  @override
  void dispose() {
    amountCtrl.dispose();
    descriptionCtrl.dispose();
    storeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final (name, emoji) = categories[i];
        final active = name == _selectedCategory;

        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = name),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: boxDecoration(
              active: active,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: active ? Colors.blue : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget categoryGrid() => const CategoryGrid();