import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/blog_post.dart';
import '../../../domain/entities/certification.dart';
import '../../../domain/entities/experience.dart';
import '../../../domain/entities/metric.dart';
import '../../../domain/entities/portfolio_profile.dart';
import '../../../domain/entities/project.dart';
import '../../../domain/entities/skill.dart';
import '../controllers/portfolio_controller.dart';

class Brand extends StatelessWidget {
  const Brand({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            profile.initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          profile.shortName,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class NavLink extends StatelessWidget {
  const NavLink({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(
            context,
          ).textTheme.bodyLarge?.color?.withValues(alpha: .72),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class HeroSection extends GetView<PortfolioController> {
  const HeroSection({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;
    final heroText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('Senior Flutter Lead'),
        Text(
          profile.heroTitle,
          style: TextStyle(
            height: .95,
            fontSize: isWide ? 56 : 34,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        TypingRoles(roles: profile.typingRoles),
        const SizedBox(height: 12),
        Text(
          profile.heroSubtitle,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 16,
            height: 1.42,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () =>
                  controller.scrollToSection(PortfolioSection.contact),
              icon: const Icon(Icons.work_outline),
              label: const Text('Hire Me'),
            ),
            OutlinedButton.icon(
              onPressed: controller.openResume,
              icon: const Icon(Icons.download_outlined),
              label: const Text('Download Resume'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: profile.contacts
              .take(3)
              .map(
                (contact) => IconChip(label: contact.label, url: contact.url),
              )
              .toList(),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 24),
      child: AnimatedGradientPanel(
        child: Stack(
          children: [
            const Positioned.fill(child: ParticleField()),
            Positioned(
              right: isWide ? 22 : 12,
              top: 18,
              child: const FloatingFlutterMark(),
            ),
            Padding(
              padding: EdgeInsets.all(isWide ? 24 : 16),
              child: isWide
                  ? Row(
                      children: [
                        Expanded(flex: 7, child: heroText),
                        const SizedBox(width: 22),
                        SizedBox(
                          width: 300,
                          child: ProfilePortrait(profile: profile),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        heroText,
                        const SizedBox(height: 18),
                        ProfilePortrait(profile: profile),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class TypingRoles extends StatefulWidget {
  const TypingRoles({required this.roles, super.key});

  final List<String> roles;

  @override
  State<TypingRoles> createState() => _TypingRolesState();
}

class _TypingRolesState extends State<TypingRoles> {
  int roleIndex = 0;
  int characterCount = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 95), (_) {
      if (!mounted) return;
      setState(() {
        final role = widget.roles[roleIndex];
        if (characterCount < role.length) {
          characterCount++;
        } else {
          roleIndex = (roleIndex + 1) % widget.roles.length;
          characterCount = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.roles[roleIndex];
    return Text(
      '${role.substring(0, characterCount.clamp(0, role.length))}|',
      style: const TextStyle(
        color: AppColors.accent,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class ProfilePortrait extends StatelessWidget {
  const ProfilePortrait({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Surface(
          child: Column(
            children: [
              Container(
                width: 174,
                height: 174,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: .18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.ink.withValues(alpha: .10),
                      blurRadius: 22,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    profile.profileImageAsset,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                profile.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                profile.focusText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.muted, height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'About Me',
      title: profile.aboutTitle,
      child: ResponsiveTwoColumn(
        padding: EdgeInsets.zero,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.aboutBody,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 15,
                height: 1.42,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: profile.aboutHighlights
                  .map((item) => Pill(text: item))
                  .toList(),
            ),
          ],
        ),
        right: TimelineCard(profile: profile),
      ),
    );
  }
}

class TimelineCard extends StatelessWidget {
  const TimelineCard({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    return Surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: profile.timeline.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.accent.withValues(alpha: .14),
                  child: Text(
                    item.year,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({required this.skills, super.key});

  final List<Skill> skills;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Skills',
      title: 'Animated skill strength',
      child: ResponsiveCardGrid(
        children: skills
            .map((skill) => SkillProgressCard(skill: skill))
            .toList(),
      ),
    );
  }
}

class SkillProgressCard extends StatelessWidget {
  const SkillProgressCard({required this.skill, super.key});

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return Surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: skill.level),
                duration: const Duration(milliseconds: 1200),
                builder: (context, value, child) {
                  return SizedBox(
                    width: 54,
                    height: 54,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 6,
                      color: AppColors.accent,
                      backgroundColor: AppColors.line,
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      _stars(skill.level),
                      style: const TextStyle(color: AppColors.gold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            skill.body,
            style: const TextStyle(color: AppColors.muted, height: 1.35),
          ),
        ],
      ),
    );
  }

  String _stars(double level) {
    final filled = (level * 5).round();
    return '$filled/5';
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({required this.projects, super.key});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Projects',
      title: 'Beautiful app case studies',
      child: SizedBox(
        height: 330,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 14),
            itemCount: projects.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final width = MediaQuery.sizeOf(context).width;
              final cardWidth = width >= 900
                  ? 300.0
                  : width >= 560
                  ? 280.0
                  : 250.0;
              return SizedBox(
                width: cardWidth,
                child: ProjectCard(project: projects[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectPreview(project: project),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(project.tag),
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    project.body,
                    style: const TextStyle(
                      color: AppColors.muted,
                      height: 1.3,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    project.techStack.take(3).join(' | '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SmallAction(
                        icon: Icons.code,
                        label: 'GitHub',
                        url: project.githubUrl,
                      ),
                      SmallAction(
                        icon: Icons.shop_outlined,
                        label: 'Store',
                        url: project.playStoreUrl,
                      ),
                      SmallAction(
                        icon: Icons.play_circle_outline,
                        label: 'Demo',
                        url: project.demoVideoUrl,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LiveDemoSection extends StatelessWidget {
  const LiveDemoSection({required this.projects, super.key});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final highlightedProjects = projects
        .where((project) => project.imageAssets.isNotEmpty)
        .take(3)
        .toList();

    return SectionShell(
      eyebrow: 'App Highlights',
      title: 'Published app proof and case-study notes',
      child: ResponsiveCardGrid(
        children: highlightedProjects
            .map(
              (project) => Surface(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              project.imageAssets.first,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              filterQuality: FilterQuality.medium,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    AppColors.ink.withValues(alpha: .55),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Eyebrow(project.tag),
                    Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.features.take(2).join(' • '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.muted,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            Get.find<PortfolioController>().openExternalUrl(
                              project.playStoreUrl,
                              fallbackLabel: project.title,
                            ),
                        icon: const Icon(Icons.shop_outlined, size: 18),
                        label: const Text('Play Store'),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ProjectPreview extends StatelessWidget {
  const ProjectPreview({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final hasImages = project.imageAssets.isNotEmpty;
    return Container(
      height: 112,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        gradient: LinearGradient(colors: [AppColors.ink, ...project.colors]),
      ),
      child: hasImages
          ? ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    project.imageAssets.first,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    filterQuality: FilterQuality.medium,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.ink.withValues(alpha: .78),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 10,
                    child: Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Icon(
                Icons.phone_iphone,
                size: 38,
                color: Colors.white.withValues(alpha: .9),
              ),
            ),
    );
  }
}

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({required this.metrics, super.key});

  final List<Metric> metrics;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Statistics',
      title: 'Delivery impact',
      child: ResponsiveCardGrid(
        children: metrics.map((metric) => StatCard(metric: metric)).toList(),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({required this.metric, super.key});

  final Metric metric;

  @override
  Widget build(BuildContext context) {
    final number =
        int.tryParse(metric.value.replaceAll(RegExp('[^0-9]'), '')) ?? 0;
    final suffix = metric.value.replaceAll(RegExp('[0-9]'), '');
    return Surface(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: number.toDouble()),
        duration: const Duration(milliseconds: 1300),
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${value.round()}$suffix',
              style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
            ),
            Text(
              metric.label,
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({required this.certifications, super.key});

  final List<Certification> certifications;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Certifications',
      title: 'Learning roadmap',
      child: ResponsiveCardGrid(
        children: certifications
            .map(
              (item) => Surface(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.workspace_premium_outlined,
                    color: AppColors.gold,
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(item.status),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({required this.experiences, super.key});

  final List<Experience> experiences;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Experience',
      title: 'Company cards and achievements',
      child: Column(
        children: experiences
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Surface(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.role,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '${item.company} - ${item.duration}',
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: item.technologies
                            .map((tech) => Pill(text: tech))
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Responsibilities',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      ...item.responsibilities.map(
                        (text) => Bullet(text: text),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Achievements',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      ...item.achievements.map((text) => Bullet(text: text)),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ResumeSection extends GetView<PortfolioController> {
  const ResumeSection({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Resume',
      title: 'PDF preview and download',
      child: Surface(
        child: ResponsiveTwoColumn(
          padding: EdgeInsets.zero,
          left: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.picture_as_pdf_outlined,
                size: 58,
                color: AppColors.coral,
              ),
              const SizedBox(height: 10),
              Text(
                profile.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Senior Flutter Lead | Mobile Tech Lead',
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: controller.openResume,
                icon: const Icon(Icons.download_outlined),
                label: const Text('Download Resume'),
              ),
            ],
          ),
          right: Container(
            height: 210,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.paper,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resume Preview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 8),
                Bullet(text: '5+ years Flutter mobile experience'),
                Bullet(
                  text: 'Fintech, healthcare, food-tech, enterprise domains',
                ),
                Bullet(text: 'Architecture ownership and team leadership'),
                Bullet(
                  text: 'Secure APIs, encrypted storage, CI/CD-ready apps',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlogSection extends StatelessWidget {
  const BlogSection({required this.posts, super.key});

  final List<BlogPost> posts;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Blog',
      title: 'Flutter, AI, architecture, and performance',
      child: ResponsiveCardGrid(
        children: posts
            .map(
              (post) => Surface(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Eyebrow(post.category),
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      post.summary,
                      style: const TextStyle(
                        color: AppColors.muted,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AssistantSection extends GetView<PortfolioController> {
  const AssistantSection({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'AI Assistant',
      title: 'Ask about Prathamesh',
      child: Surface(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: profile.assistantQuestions
                  .map(
                    (q) => ActionChip(
                      label: Text(q),
                      onPressed: () => controller.askAssistant(q),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Container(
                height: 180,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.paper,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListView(
                  children: controller.chatMessages
                      .map(
                        (m) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(m),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.chatInputController,
                    decoration: const InputDecoration(
                      hintText:
                          'Ask about experience, projects, skills, remote work...',
                    ),
                    onSubmitted: (_) => controller.askAssistant(),
                  ),
                ),
                IconButton(
                  onPressed: controller.askAssistant,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends GetView<PortfolioController> {
  const ContactSection({required this.profile, super.key});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Contact',
      title: 'Let us build something useful',
      child: ResponsiveTwoColumn(
        padding: EdgeInsets.zero,
        left: Surface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.location,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              Text(
                profile.phone,
                style: const TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 10),
              ...profile.contacts.map(
                (contact) => IconChip(label: contact.label, url: contact.url),
              ),
              const SizedBox(height: 10),
              FilledButton.icon(
                onPressed: () =>
                    Get.find<PortfolioController>().openExternalUrl(
                      'https://wa.me/918805202434',
                      fallbackLabel: 'WhatsApp',
                    ),
                icon: const Icon(Icons.chat_outlined),
                label: const Text('Message on WhatsApp'),
              ),
            ],
          ),
        ),
        right: Surface(
          child: Column(
            children: [
              TextField(
                controller: controller.contactNameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: controller.contactEmailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: controller.contactMessageController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Message'),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: controller.sendContactMessage,
                  child: const Text('Send Message'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSection extends GetView<PortfolioController> {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Settings',
      title: 'Theme controls',
      child: Surface(
        child: Obx(
          () => Column(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Dark Mode'),
                subtitle: const Text(
                  'Switch between light and dark portfolio themes.',
                ),
                value: controller.isDarkMode.value,
                onChanged: controller.toggleTheme,
              ),
              const Divider(),
              Wrap(
                spacing: 10,
                children: [AppColors.accent, AppColors.coral, AppColors.gold]
                    .map(
                      (color) => GestureDetector(
                        onTap: () => controller.changeThemeColor(color),
                        child: CircleAvatar(backgroundColor: color),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeoSection extends StatelessWidget {
  const SeoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionShell(
      eyebrow: 'SEO',
      title: 'Web discoverability checklist',
      child: ResponsiveCardGrid(
        children: [
          Surface(
            child: Text(
              'Meta tags, Open Graph preview, sitemap.xml, robots.txt, structured data, and Google Analytics placeholders are included for web readiness.',
            ),
          ),
          Surface(
            child: Text(
              'Update final production URL, social preview image, and analytics measurement ID before launch.',
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedGradientPanel extends StatelessWidget {
  const AnimatedGradientPanel({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: .18),
            AppColors.gold.withValues(alpha: .14),
            AppColors.coral.withValues(alpha: .16),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.line),
      ),
      child: child,
    );
  }
}

class ParticleField extends StatefulWidget {
  const ParticleField({super.key});

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) =>
          CustomPaint(painter: ParticlePainter(controller.value)),
    );
  }
}

class ParticlePainter extends CustomPainter {
  ParticlePainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: .35);
    for (var i = 0; i < 36; i++) {
      final x = (math.sin(progress * math.pi * 2 + i) * .5 + .5) * size.width;
      final y = ((i * 47 + progress * 140) % size.height);
      canvas.drawCircle(Offset(x, y), 2 + (i % 4), paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

class FloatingFlutterMark extends StatefulWidget {
  const FloatingFlutterMark({super.key});

  @override
  State<FloatingFlutterMark> createState() => _FloatingFlutterMarkState();
}

class _FloatingFlutterMarkState extends State<FloatingFlutterMark>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, math.sin(controller.value * math.pi) * 14),
        child: const Icon(
          Icons.flutter_dash,
          color: AppColors.accent,
          size: 52,
        ),
      ),
    );
  }
}

class SectionShell extends StatelessWidget {
  const SectionShell({
    required this.eyebrow,
    required this.title,
    required this.child,
    super.key,
  });

  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 46,
                margin: const EdgeInsets.only(right: 12, top: 2),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Eyebrow(eyebrow),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        height: 1.08,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class ResponsiveTwoColumn extends StatelessWidget {
  const ResponsiveTwoColumn({
    required this.left,
    required this.right,
    this.padding = const EdgeInsets.symmetric(vertical: 56),
    super.key,
  });

  final Widget left;
  final Widget right;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 820;
    return Padding(
      padding: padding,
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: 24),
                Expanded(child: right),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [left, const SizedBox(height: 12), right],
            ),
    );
  }
}

class ResponsiveCardGrid extends StatelessWidget {
  const ResponsiveCardGrid({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1120
            ? 4
            : constraints.maxWidth >= 760
            ? 3
            : constraints.maxWidth >= 540
            ? 2
            : 1;
        final gap = 12.0;
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }
}

class Surface extends StatelessWidget {
  const Surface({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withValues(alpha: .92),
          border: Border.all(color: AppColors.line.withValues(alpha: .8)),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: .08),
              offset: const Offset(0, 20),
              blurRadius: 28,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class Pill extends StatelessWidget {
  const Pill({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: AppColors.accent.withValues(alpha: .1),
      side: BorderSide.none,
    );
  }
}

class Bullet extends StatelessWidget {
  const Bullet({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('- '),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.muted, height: 1.28),
            ),
          ),
        ],
      ),
    );
  }
}

class IconChip extends StatelessWidget {
  const IconChip({required this.label, required this.url, super.key});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    return ActionChip(
      avatar: const Icon(Icons.open_in_new, size: 16),
      label: Text(label),
      onPressed: () => controller.openExternalUrl(url, fallbackLabel: label),
    );
  }
}

class SmallAction extends StatelessWidget {
  const SmallAction({
    required this.icon,
    required this.label,
    required this.url,
    super.key,
  });

  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    return IconButton(
      tooltip: label,
      onPressed: () => controller.openExternalUrl(url, fallbackLabel: label),
      icon: Icon(icon, size: 18),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 34, height: 30),
    );
  }
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.accent,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 36),
      child: Text(
        'Built with Flutter, GetX, Clean Architecture, and responsive web/mobile UX.',
        style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w700),
      ),
    );
  }
}
