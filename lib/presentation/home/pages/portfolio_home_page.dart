import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/portfolio_profile.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/portfolio_sections.dart';

class PortfolioHomePage extends GetView<PortfolioController> {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.scrollToSection(PortfolioSection.assistant),
        icon: const Icon(Icons.smart_toy_outlined),
        label: const Text('Ask AI'),
      ),
      body: Obx(() {
        final profile = controller.profile.value;
        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: ScrollConfiguration(
            behavior: const PortfolioScrollBehavior(),
            child: CustomScrollView(
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                _PortfolioAppBar(profile: profile),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1240),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            HeroSection(profile: profile),
                            _SectionAnchor(
                              section: PortfolioSection.about,
                              child: AboutSection(profile: profile),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.skills,
                              child: SkillsSection(skills: profile.skills),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.projects,
                              child: ProjectsSection(
                                projects: profile.projects,
                              ),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.demos,
                              child: LiveDemoSection(demos: profile.demos),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.stats,
                              child: StatisticsSection(
                                metrics: profile.metrics,
                              ),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.certifications,
                              child: CertificationsSection(
                                certifications: profile.certifications,
                              ),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.experience,
                              child: ExperienceSection(
                                experiences: profile.experiences,
                              ),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.resume,
                              child: ResumeSection(profile: profile),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.blog,
                              child: BlogSection(posts: profile.blogPosts),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.assistant,
                              child: AssistantSection(profile: profile),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.contact,
                              child: ContactSection(profile: profile),
                            ),
                            _SectionAnchor(
                              section: PortfolioSection.settings,
                              child: const SettingsSection(),
                            ),
                            const SeoSection(),
                            const PortfolioFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PortfolioScrollBehavior extends MaterialScrollBehavior {
  const PortfolioScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      controller: details.controller,
      interactive: true,
      child: child,
    );
  }
}

class _SectionAnchor extends GetView<PortfolioController> {
  const _SectionAnchor({required this.section, required this.child});

  final PortfolioSection section;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: controller.sectionKeys[section], child: child);
  }
}

class _PortfolioAppBar extends GetView<PortfolioController> {
  const _PortfolioAppBar({required this.profile});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    final showLinks = MediaQuery.sizeOf(context).width >= 900;

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor.withValues(alpha: 0.94),
      title: Brand(profile: profile),
      actions: showLinks
          ? [
              NavLink(
                label: 'About',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.about),
              ),
              NavLink(
                label: 'Skills',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.skills),
              ),
              NavLink(
                label: 'Projects',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.projects),
              ),
              NavLink(
                label: 'Experience',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.experience),
              ),
              NavLink(
                label: 'Resume',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.resume),
              ),
              NavLink(
                label: 'Contact',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.contact),
              ),
              const SizedBox(width: 16),
            ]
          : [
              IconButton(
                tooltip: 'Settings',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.settings),
                icon: const Icon(Icons.tune),
              ),
              IconButton(
                tooltip: 'Contact',
                onPressed: () =>
                    controller.scrollToSection(PortfolioSection.contact),
                icon: const Icon(Icons.mail_outline),
              ),
              const SizedBox(width: 10),
            ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.line.withValues(alpha: .5),
        ),
      ),
    );
  }
}
