import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/nav_bar.dart';
import '../../../../widgets/footer.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/summarize_controller.dart';

class SummarizeView extends GetView<SummarizeController> {
  const SummarizeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getBackgroundGradient(context),
        ),
        child: Column(
          children: [
            const NavBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 40),
                  // Header
                  Center(
                    child: Text(
                      "AI Summarizer",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Paste your transcript or text below to get an instant AI summary.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Input Area
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Colors.white.withOpacity(0.05) 
                              : Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).brightness == Brightness.dark 
                                ? Colors.white12 
                                : Colors.black12
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: controller.textController,
                              maxLines: 10,
                              style: TextStyle(
                                fontSize: 16, 
                                height: 1.5,
                                color: Theme.of(context).colorScheme.onBackground
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter text here...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Theme.of(context).cardColor,
                                contentPadding: const EdgeInsets.all(20),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: controller.clear,
                                  child: const Text("Clear"),
                                ),
                                const SizedBox(width: 15),
                                Obx(() => ElevatedButton.icon(
                                  onPressed: controller.isLoading.value ? null : controller.summarizeText,
                                  icon: controller.isLoading.value 
                                      ? Container(width: 20, height: 20, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                      : const Icon(Icons.auto_awesome),
                                  label: Text(controller.isLoading.value ? "Processing..." : "Summarize"),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                                  ),
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // RESULT AREA
                  Obx(() {
                    if (controller.resultSummary.value.isEmpty) return const SizedBox.shrink();

                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark 
                                ? Colors.black.withOpacity(0.3) 
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).primaryColor.withOpacity(0.3)
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.summarize, color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 10),
                                  Text("Analysis Result", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const Divider(height: 30),
                              SelectableText(
                                controller.resultSummary.value,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.6,
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  
                  const SizedBox(height: 100),
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
