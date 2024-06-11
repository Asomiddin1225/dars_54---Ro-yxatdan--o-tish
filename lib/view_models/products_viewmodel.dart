
import 'package:dars_54/models/plan.dart';
import 'package:dars_54/repositories/plan_repository.dart';

class ProductsViewmodel {
  final productsRepository = PlansRepository();
  List<Plan> _list = [
    Plan(
      id: "1",
      title: "Reja",
      reja: "Maktab",
      sana: "12.25.2005"
    ),
  ];

  Future<List<Plan>> get list async {
    _list = await productsRepository.getPlans();
    return [..._list];
  }

  Future<void> addProduct(
    String title,
    String reja,
    String sana,
  ) async {
    final newProduct = await productsRepository.addPlan(
      title,
      reja,
      sana,
    );
    if (newProduct != null) {
      _list.add(newProduct);
    }
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    String newReja,
    String newSana,
  ) async {
    await productsRepository.editPlan(id, newTitle, newReja,newSana);
    final index = _list.indexWhere((product) {
      return product.id == id;
    });
    _list[index].title = newTitle;
    _list[index].reja = newReja;
    _list[index].sana = newSana;
  }

  void deleteProduct(String id) async {
    _list.removeWhere((product) {
      return product.id == id;
    });
    productsRepository.deletePlan(id);
  }

  void updateProduct(Plan product) {}
}
