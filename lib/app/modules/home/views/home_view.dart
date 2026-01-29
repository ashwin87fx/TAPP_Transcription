import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/nav_bar.dart';
import '../../../../widgets/footer.dart';
import '../../../../widgets/animations.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

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
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 80),
                  
                  // --- HERO SECTION ---
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            FadeInUp(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "Turn Audio into ", style: Theme.of(context).textTheme.displayLarge),
                                    TextSpan(text: "Actionable Text.", style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      shadows: [
                                        Shadow(color: Theme.of(context).primaryColor.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 0))
                                      ]
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeInUp(
                              delay: 0.2,
                              child: Text(
                                "Fast, accurate, and secure transcription for everyone.\nPowered by advanced AI models.",
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 40),
                            FadeInUp(
                              delay: 0.3,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                                      blurRadius: 30,
                                      spreadRadius: -5,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () => Get.toNamed('/transcribe'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text("LAUNCH STUDIO", style: TextStyle(letterSpacing: 1.2)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 120),

                  // --- HOW IT WORKS (Horizontal Steps) ---
                  FadeInUp(
                    delay: 0.4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.black.withOpacity(0.3) 
                            : Colors.white.withOpacity(0.3),
                        border: Border.symmetric(horizontal: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.05)
                        )),
                      ),
                      child: Column(
                        children: [
                          Text("HOW IT WORKS", style: TextStyle(
                            color: Theme.of(context).primaryColor, 
                            fontWeight: FontWeight.bold, 
                            letterSpacing: 2.0
                          )),
                          const SizedBox(height: 60),
                          Wrap(
                            spacing: 80,
                            runSpacing: 40,
                            alignment: WrapAlignment.center,
                            children: [
                              _StepItem("1", "Upload Audio", "MP3, WAV, M4A", Icons.upload_file_rounded),
                              Icon(Icons.arrow_right_alt_rounded, 
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.black12, 
                                size: 50
                              ),
                              _StepItem("2", "AI Processing", "99% Accuracy", Icons.auto_awesome_rounded),
                              Icon(Icons.arrow_right_alt_rounded, 
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.black12, 
                                size: 50
                              ),
                              _StepItem("3", "Download", "TXT or SRT", Icons.download_rounded),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 120),
                  
                  // --- USE CASES (Compact Grid) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Text("Perfect For", style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 40),
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 850),
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.center,
                              children: [
                                _UseCaseCard(Icons.mic_external_on_rounded, "Podcasters", "Get show notes and captions instantly."),
                                _UseCaseCard(Icons.school_rounded, "Students", "Transcribe lectures and study faster."),
                                _UseCaseCard(Icons.business_center_rounded, "Meetings", "Never miss a detail in your minutes."),
                                _UseCaseCard(Icons.movie_creation_rounded, "Creators", "Auto-generate subtitles for video."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

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

class _StepItem extends StatelessWidget {
  final String step;
  final String title;
  final String desc;
  final IconData icon;
  const _StepItem(this.step, this.title, this.desc, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70, height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ]
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 30),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        Text(title, style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground, 
          fontWeight: FontWeight.bold, 
          fontSize: 16
        )),
        const SizedBox(height: 5),
        Text(desc, style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white54, 
          fontSize: 13
        )),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _UseCaseCard(this.icon, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5)),
        ]
      ),
      child: Row(
        children: [
          Container(
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
               color: Colors.white.withOpacity(0.03),
               borderRadius: BorderRadius.circular(12),
             ),
             child: Icon(icon, color: Theme.of(context).primaryColor, size: 28)
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(desc, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white54, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

