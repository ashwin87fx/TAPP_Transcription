import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/nav_bar.dart';
import '../../../../widgets/footer.dart';
import '../../../../widgets/animations.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getBackgroundGradient(context),
        ),
        child: ListView(
          children: [
            const NavBar(),
            const SizedBox(height: 80),
            
            Center(
              child: FadeInUp(
                child: Text("About.", style: Theme.of(context).textTheme.displayLarge),
              ),
            ),
            
            const SizedBox(height: 80),

            Center(
              child: Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: [
                  _InfoCard(
                    title: "Mission",
                    content: "To democratize audio intelligence through minimal, efficient design and powerful AI models.",
                  ),
                   _InfoCard(
                    title: "Stack",
                    content: "Frontend: Flutter Web 3.0\nBackend: FastAPI + Uvicorn\nAI: Faster-Whisper (Int8)",
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 150),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const _InfoCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: 0.2,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
             BoxShadow(color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
            const SizedBox(height: 20),
            Text(content, style: TextStyle(fontSize: 16, height: 1.6, color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8) ?? Colors.white70)),
          ],
        ),
      ),
    );
  }
}
