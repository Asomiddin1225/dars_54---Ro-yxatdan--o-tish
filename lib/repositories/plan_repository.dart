
import 'package:dars_54/models/plan.dart';
import 'package:dars_54/services/plan_http_services.dart';



class PlansRepository {
  final PlansHttpServices = ProductsHttpServices();
  

  Future<List<Plan>> getPlans() async {
    
    return PlansHttpServices.getProducts();
    
  }

  Future<Plan?> addPlan(
    String title,
    String reja,
    String sana,
  ) async {
    return PlansHttpServices.addProduct(
      title,
      reja,
      sana,
      
    );
  }

  Future<void> editPlan(
    String id,
    String newTitle,
    String newReja,
    String newSana,
  ) async {
    return PlansHttpServices.editProduct(
      id,
      newTitle,
      newReja,
      newSana,
    );
  }

  Future<void> deletePlan(String id) async {
    return PlansHttpServices.deleteProduct(id);
  }
}