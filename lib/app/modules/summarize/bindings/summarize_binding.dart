import 'package:get/get.dart';
import '../controllers/summarize_controller.dart';

class SummarizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummarizeController>(
      () => SummarizeController(),
    );
  }
}
