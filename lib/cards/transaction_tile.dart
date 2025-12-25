import 'package:flutter/material.dart';
import './card_decoration.dart';

class TransactionTile extends StatelessWidget {
  final String title, subtitle, amount, date, emoji;

  const TransactionTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: cardDecoration(),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(emoji),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(date,
                  style:
                      const TextStyle(color: Colors.black45, fontSize: 12)),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.delete_outline, color: Colors.red),
        ],
      ),
    );
  }
}
