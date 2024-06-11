import 'package:dars_54/models/plan.dart';
import 'package:dars_54/view_models/products_viewmodel.dart';
import 'package:dars_54/views/widgets/manage_products_screen.dart';
import 'package:dars_54/views/widgets/product_item.dart';
import 'package:flutter/material.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final productsViewModel = ProductsViewmodel();

  void addProduct() async {
    final response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return ManageProductsScreen(
            productsViewModel: productsViewModel,
          );
        },
      ),
    );
    if (response != null) {
      setState(() {});
    }
  }

  void editProduct(Plan product) async {
    final response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return ManageProductsScreen(
            product: product,
            productsViewModel: productsViewModel,
          );
        },
      ),
    );

    if (response != null) {
      setState(() {});
    }
  }

  void deleteProduct(Plan product) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: Text("Siz ${product.title}'ni o'chirmoqchimisiz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ha, ishonchim komil"),
            ),
          ],
        );
      },
    );

    if (response == true) {
      productsViewModel.deleteProduct(product.id);
      setState(() {});
    }
  }

  void toggleDoneProduct(Plan product) {
    setState(() {
      product.isDone = !product.isDone;
      productsViewModel.updateProduct(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rejalar"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: addProduct,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<Plan>>(
          future: productsViewModel.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Reja mavjud emas"),
              );
            }

            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  onEdit: () {
                    editProduct(product);
                  },
                  onDelete: () {
                    deleteProduct(product);
                  },
                  onToggleDone: () {
                    toggleDoneProduct(product);
                  },
                );
              },
            );
          }),
    );
  }
}
