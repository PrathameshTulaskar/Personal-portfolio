import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/portfolio_profile.dart';
import '../../../domain/usecases/get_portfolio_profile.dart';

enum PortfolioSection {
  about,
  skills,
  projects,
  demos,
  stats,
  certifications,
  experience,
  resume,
  blog,
  assistant,
  contact,
  settings,
}

class PortfolioController extends GetxController {
  PortfolioController(this._getPortfolioProfile);

  final GetPortfolioProfile _getPortfolioProfile;

  final profile = Rxn<PortfolioProfile>();
  final isDarkMode = false.obs;
  final selectedThemeColor = const Color(0xFF007A78).obs;
  final chatMessages = <String>[].obs;
  final chatInputController = TextEditingController();
  final contactNameController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactMessageController = TextEditingController();
  final scrollController = ScrollController();
  final sectionKeys = {
    PortfolioSection.about: GlobalKey(),
    PortfolioSection.skills: GlobalKey(),
    PortfolioSection.projects: GlobalKey(),
    PortfolioSection.demos: GlobalKey(),
    PortfolioSection.stats: GlobalKey(),
    PortfolioSection.certifications: GlobalKey(),
    PortfolioSection.experience: GlobalKey(),
    PortfolioSection.resume: GlobalKey(),
    PortfolioSection.blog: GlobalKey(),
    PortfolioSection.assistant: GlobalKey(),
    PortfolioSection.contact: GlobalKey(),
    PortfolioSection.settings: GlobalKey(),
  };

  @override
  void onInit() {
    super.onInit();
    profile.value = _getPortfolioProfile();
    chatMessages.add(
      'Hi, I am Prathamesh portfolio assistant. Ask me about experience, projects, technologies, or remote work.',
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    chatInputController.dispose();
    contactNameController.dispose();
    contactEmailController.dispose();
    contactMessageController.dispose();
    super.onClose();
  }

  void scrollToSection(PortfolioSection section) {
    final context = sectionKeys[section]?.currentContext;
    if (context == null) {
      Get.snackbar(
        'Section loading',
        'Please try again in a moment.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Scrollable.ensureVisible(
      context,
      alignment: .04,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    _applyTheme();
  }

  void changeThemeColor(Color color) {
    selectedThemeColor.value = color;
    _applyTheme();
  }

  void _applyTheme() {
    final isDark = isDarkMode.value;
    Get.changeTheme(
      ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: selectedThemeColor.value,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
        scaffoldBackgroundColor: isDark
            ? const Color(0xFF0E1518)
            : const Color(0xFFF7F8F4),
        fontFamily: 'Arial',
        textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme
            .apply(
              bodyColor: isDark ? Colors.white : const Color(0xFF101820),
              displayColor: isDark ? Colors.white : const Color(0xFF101820),
            ),
        useMaterial3: true,
      ),
    );
  }

  Future<void> openResume() async {
    final resumeUri = Uri.parse(
      'assets/assets/documents/Prathamesh_J_Tulaskar_Resume.pdf',
    );
    final opened = await launchUrl(
      resumeUri,
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      Get.snackbar(
        'Resume ready',
        'Resume PDF is bundled in assets/documents/Prathamesh_J_Tulaskar_Resume.pdf.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> openExternalUrl(
    String url, {
    String fallbackLabel = 'Link',
  }) async {
    if (url.trim().isEmpty || url == '#') {
      Get.snackbar(
        '$fallbackLabel coming soon',
        'Add the final URL in portfolio_local_data_source.dart.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      Get.snackbar(
        'Could not open $fallbackLabel',
        url,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sendContactMessage() {
    final name = contactNameController.text.trim();
    final email = contactEmailController.text.trim();
    final message = contactMessageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      Get.snackbar(
        'Complete the form',
        'Please add your name, email, and message.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final encodedSubject = Uri.encodeComponent('Portfolio enquiry from $name');
    final encodedBody = Uri.encodeComponent('$message\n\nFrom: $name <$email>');
    openExternalUrl(
      'mailto:prathameshtulaskar37@gmail.com?subject=$encodedSubject&body=$encodedBody',
      fallbackLabel: 'Email',
    );
  }

  void askAssistant([String? prompt]) {
    final query = (prompt ?? chatInputController.text).trim();
    if (query.isEmpty) return;

    chatMessages.add('You: $query');
    chatMessages.add('Assistant: ${_answerFor(query)}');
    chatInputController.clear();
  }

  String _answerFor(String query) {
    final data = profile.value;
    if (data == null) return 'Portfolio data is loading.';

    final lower = query.toLowerCase();
    if (lower.contains('project')) {
      return 'Prathamesh has worked on fintech, Hydropure, ArogyNxt healthcare, Siparggo Coffeez, Raidesh Charitable Trust, YBites, inventory, school, and AI app concepts.';
    }
    if (lower.contains('technolog') || lower.contains('skill')) {
      return 'Core skills include Flutter, Dart, REST APIs, Firebase, BLoC, Riverpod, Git, CI/CD, Clean Architecture, MVVM, JWT, and encrypted local storage.';
    }
    if (lower.contains('remote')) {
      return 'Yes. His resume shows direct client collaboration, Saudi and UK client work, requirement analysis, and remote-friendly delivery ownership.';
    }
    if (lower.contains('experience') || lower.contains('about')) {
      return '${data.name} is a Senior Flutter Lead from ${data.location} with 5+ years of mobile experience across fintech, healthcare, food-tech, service management, and enterprise apps.';
    }

    return 'Prathamesh is a Senior Flutter Lead focused on scalable Flutter apps, clean architecture, secure APIs, team handling, and end-to-end product delivery.';
  }
}
