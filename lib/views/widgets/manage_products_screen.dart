import 'package:dars_54/models/plan.dart';
import 'package:dars_54/view_models/products_viewmodel.dart';
import 'package:flutter/material.dart';


class ManageProductsScreen extends StatefulWidget {
  final Plan? product;
  final ProductsViewmodel productsViewModel;
  const ManageProductsScreen({
    super.key,
    this.product,
    required this.productsViewModel,
  });

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final formKey = GlobalKey<FormState>();
  String? title;
  String? sana;
  String? reja;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      title = widget.product!.title;
      reja = widget.product!.reja;
      sana = widget.product!.sana;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Mahsulotlarni qo'shamiz!
      setState(() {
        isLoading = true;
      });
      if (widget.product == null) {
        widget.productsViewModel
            .addProduct(
          title!,
          reja!,
          sana!,
        )
            .then((_) {
          Navigator.pop(context, true);
        });
      } else {
        widget.productsViewModel
            .editProduct(
          widget.product!.id,
          title!,
          reja!,
          sana!,
        )
            .then((_) {
          Navigator.pop(context, true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null ? "Reja qo'shish" : "Rejanini tahrirlash",
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              initialValue: title,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Reja nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos Reja nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: reja,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Reja ",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos Reja  kiriting";
                }
              },
              onSaved: (newValue) {
                reja = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: sana,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "kun-oy-yil ",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Xato kirtildi ";
                }
              },
              onSaved: (newValue) {
                sana = newValue!;
              },
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                : FilledButton.icon(
                    onPressed: submit,
                    label:
                        Text(widget.product == null ? "SAQLASH" : "YANGILASH"),
                    icon: const Icon(Icons.check),
                  ),
          ],
        ),
      ),
    );
  }
}
