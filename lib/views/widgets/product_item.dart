import 'package:dars_54/models/plan.dart';
import 'package:flutter/material.dart';


class ProductItem extends StatelessWidget {
  final Plan product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleDone;

  const ProductItem({
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: product.isDone ? Colors.green : Colors.black,
              ),
            ),
            Text(product.reja),
            const Spacer(),
            if (product.isDone)
              const Text(
                'Bajarilgan',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                Checkbox(
                  value: product.isDone,
                  onChanged: (value) {
                    onToggleDone();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
