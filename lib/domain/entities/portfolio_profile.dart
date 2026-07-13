import 'blog_post.dart';
import 'certification.dart';
import 'contact_link.dart';
import 'demo_item.dart';
import 'experience.dart';
import 'metric.dart';
import 'project.dart';
import 'skill.dart';
import 'timeline_item.dart';

class PortfolioProfile {
  const PortfolioProfile({
    required this.name,
    required this.shortName,
    required this.initials,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.typingRoles,
    required this.profileImageAsset,
    required this.resumeAsset,
    required this.focusText,
    required this.aboutTitle,
    required this.aboutBody,
    required this.aboutHighlights,
    required this.timeline,
    required this.metrics,
    required this.skills,
    required this.projects,
    required this.demos,
    required this.certifications,
    required this.experiences,
    required this.blogPosts,
    required this.assistantQuestions,
    required this.contacts,
    required this.location,
    required this.phone,
  });

  final String name;
  final String shortName;
  final String initials;
  final String heroTitle;
  final String heroSubtitle;
  final List<String> typingRoles;
  final String profileImageAsset;
  final String resumeAsset;
  final String focusText;
  final String aboutTitle;
  final String aboutBody;
  final List<String> aboutHighlights;
  final List<TimelineItem> timeline;
  final List<Metric> metrics;
  final List<Skill> skills;
  final List<Project> projects;
  final List<DemoItem> demos;
  final List<Certification> certifications;
  final List<Experience> experiences;
  final List<BlogPost> blogPosts;
  final List<String> assistantQuestions;
  final List<ContactLink> contacts;
  final String location;
  final String phone;
}
