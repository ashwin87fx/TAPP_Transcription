import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/nav_bar.dart';
import '../../../../widgets/footer.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/transcribe_controller.dart';

class TranscribeView extends GetView<TranscribeController> {
  const TranscribeView({Key? key}) : super(key: key);

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
            const SizedBox(height: 60),
            
            Center(
              child: Container(
                width: 750,
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.7),
                  border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05), blurRadius: 40, offset: const Offset(0, 15)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- HERO DROP ZONE (Replaces Professional Dropzone) ---
                    const _HeroDropZone(),

                    const SizedBox(height: 30),

                    // Language Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
                        border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedLanguage.value,
                          dropdownColor: Theme.of(context).cardColor,
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).iconTheme.color),
                          isExpanded: true,
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w500),
                          items: controller.languages.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(entry.key),
                            );
                          }).toList(),
                          onChanged: controller.updateLanguage,
                        ),
                      )),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator(color: Colors.white);
                      }
                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: controller.pickAndUpload,
                          icon: const Icon(Icons.rocket_launch_rounded),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          label: const Text("GENERATE CAPTIONS", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                        ),
                      );
                    }),
                      
                    const SizedBox(height: 40),
                    Divider(color: Colors.white.withOpacity(0.1)),
                    const SizedBox(height: 20),
                    
                    // RESULT AREA (Tabs)
                    Obx(() {
                       // Only show tabs if we have valid content (not initial state or errors)
                       final showTabs = controller.resultText.value.isNotEmpty && 
                                        !controller.resultText.value.startsWith("Upload") && 
                                        !controller.resultText.value.startsWith("Backend") && 
                                        !controller.resultText.value.startsWith("Connection") && 
                                        !controller.resultText.value.startsWith("Transcribing") &&
                                        !controller.resultText.value.startsWith("Demo");
                                        
                       if (!showTabs) {
                          // Show simple text area for status/errors
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("STATUS", style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 12)),
                              const SizedBox(height: 15),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.7),
                                  border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  controller.resultText.value, 
                                  style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8), fontFamily: 'monospace', height: 1.6),
                                ),
                              ),
                            ],
                          );
                       }

                       return Column(
                        children: [
                          // Header Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Transcript", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: controller.showSummaryDialog,
                                    icon: const Icon(Icons.auto_awesome),
                                    tooltip: "AI Summarize",
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: controller.downloadTxt,
                                    icon: const Icon(Icons.download_rounded),
                                    tooltip: "Download TXT",
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // TRANSCRIPT LIST
                          SizedBox(
                            height: 500,
                            child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.7),
                                      border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: controller.segments.isEmpty
                                        ? const Center(child: Text("No transcript segments available."))
                                        : ListView.separated(
                                            padding: const EdgeInsets.all(15),
                                            itemCount: controller.segments.length,
                                            separatorBuilder: (_, __) => const SizedBox(height: 10),
                                            itemBuilder: (context, index) {
                                              final segment = controller.segments[index];
                                              final startTime = segment['start'] as int;
                                              final endTime = segment['end'] as int;
                                              final text = segment['text'] as String;
                                              final speaker = segment['speaker'] as String;

                                              return Obx(() {
                                                // Check if active
                                                final currentSec = controller.currentPosition.value.inSeconds;
                                                final isActive = currentSec >= startTime && currentSec <= endTime;

                                                return InkWell(
                                                  onTap: () => controller.seekTo(startTime),
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: AnimatedContainer(
                                                    duration: const Duration(milliseconds: 300),
                                                    padding: const EdgeInsets.all(15),
                                                    decoration: BoxDecoration(
                                                      color: isActive 
                                                          ? Theme.of(context).primaryColor.withOpacity(0.15) 
                                                          : Colors.transparent,
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(
                                                        color: isActive 
                                                            ? Theme.of(context).primaryColor.withOpacity(0.5) 
                                                            : Colors.transparent
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                         Row(
                                                           children: [
                                                             Text(
                                                               "${_formatDuration(startTime)}",
                                                               style: TextStyle(
                                                                  fontSize: 12, 
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Theme.of(context).primaryColor.withOpacity(0.8)
                                                               ),
                                                             ),
                                                           ],
                                                         ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          text,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
                                                            height: 1.5,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                            },
                                          ),
                                  ),
                            ),
                          ],
                        );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
            const Footer(),
          ],
        ),
      ),
    );
  }
  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class _HeroDropZone extends StatefulWidget {
  const _HeroDropZone();

  @override
  State<_HeroDropZone> createState() => _HeroDropZoneState();
}

class _HeroDropZoneState extends State<_HeroDropZone> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          // "Paper/Sand" Tint: Dark Warm Grey vs Off-White Paper
          color: isDark 
              ? const Color(0xFF1E1E1E).withOpacity(0.6) 
              : const Color(0xFFFDFCF8).withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered 
                ? Theme.of(context).primaryColor 
                : (isDark ? Colors.white12 : Colors.black12),
            width: isHovered ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered 
                  ? Theme.of(context).primaryColor.withOpacity(0.2) 
                  : Colors.transparent,
              blurRadius: 20,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isHovered ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.cloud_upload_rounded, 
                size: 64, 
                color: isHovered ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color?.withOpacity(0.5)
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Drag & drop audio files",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "MP3, WAV, M4A",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                 color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmartInsightsPanel extends StatelessWidget {
  final TranscribeController controller;
  const _SmartInsightsPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 20, color: Theme.of(context).primaryColor),
              const SizedBox(width: 10),
              Text("AI Smart Insights", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          
          // Keywords
          Text("Topics Detected", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          Obx(() => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: controller.keywords.map((k) => Chip(
              label: Text(k), 
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              side: BorderSide.none,
              labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
            )).toList(),
          )),
          
          const SizedBox(height: 20),
          
          // Sentiment
          Text("Tone Analysis", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Neutral", style: TextStyle(fontSize: 10, color: Theme.of(context).disabledColor)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Obx(() => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: controller.sentimentScore.value,
                      minHeight: 8,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                  )),
                ),
              ),
              Text("Positive", style: TextStyle(fontSize: 10, color: Theme.of(context).disabledColor)),
            ],
          ),

          const SizedBox(height: 20),
          
          // Speakers
          Text("Speakers", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          Obx(() => Column(
            children: controller.speakers.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  CircleAvatar(radius: 4, backgroundColor: Theme.of(context).primaryColor),
                  const SizedBox(width: 10),
                  Text(s, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            )).toList(),
          )),
        ],
      ),
    );
  }
}

class _KineticTypewriter extends StatefulWidget {
  final String text;
  final TextStyle? style;
  const _KineticTypewriter({required this.text, this.style});

  @override
  State<_KineticTypewriter> createState() => _KineticTypewriterState();
}

class _KineticTypewriterState extends State<_KineticTypewriter> {
  String displayedText = "";
  
  @override
  void didUpdateWidget(_KineticTypewriter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
        setState(() => displayedText = "");
        _animateText(widget.text);
    }
  }

  void _animateText(String fullText) async {
    // If text is "Loading..." or error, show immediately
    if (fullText.startsWith("Upload") || fullText.startsWith("Backend") || fullText.startsWith("Connection") || fullText.startsWith("Transcribing")) {
       if (mounted) setState(() => displayedText = fullText);
       return;
    }

    // Adaptive speed: faster for longer text
    int speed = 20;
    if (fullText.length > 500) speed = 5;
    if (fullText.length > 1000) speed = 1;

    for (int i = 0; i < fullText.length; i++) {
        await Future.delayed(Duration(milliseconds: speed));
        if (mounted) {
           setState(() => displayedText += fullText[i]);
        }
    }
  }

  @override
  void initState() {
    super.initState();
    _animateText(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText(
       displayedText, 
       style: widget.style,
    );
  }
}
