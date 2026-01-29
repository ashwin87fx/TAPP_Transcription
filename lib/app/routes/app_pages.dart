import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/transcribe/bindings/transcribe_binding.dart';
import '../modules/transcribe/views/transcribe_view.dart';
import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/summarize/bindings/summarize_binding.dart';
import '../modules/summarize/views/summarize_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TRANSCRIBE,
      page: () => const TranscribeView(),
      binding: TranscribeBinding(),
    ),
    GetPage(
      name: Routes.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: Routes.SUMMARIZE,
      page: () => const SummarizeView(),
      binding: SummarizeBinding(),
    ),
  ];
}
