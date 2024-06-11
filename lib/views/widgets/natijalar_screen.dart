import 'package:dars_54/models/plan.dart';
import 'package:dars_54/view_models/products_viewmodel.dart';
import 'package:flutter/material.dart';


class ResultsScreen extends StatelessWidget {
  final ProductsViewmodel productsViewModel;

  ResultsScreen({super.key, required this.productsViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Natijalar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Plan>>(
        future: productsViewModel.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Reja mavjud emas'));
          }

          final completedPlans =
              snapshot.data!.where((plan) => plan.isDone).length;
          return Center(
            child: Text(
              'Bajarilgan rejalar soni: $completedPlans',
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );
  }
}
