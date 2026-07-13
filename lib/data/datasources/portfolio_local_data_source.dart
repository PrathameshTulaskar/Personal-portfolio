import '../../core/constants/app_colors.dart';
import '../../domain/entities/blog_post.dart';
import '../../domain/entities/certification.dart';
import '../../domain/entities/contact_link.dart';
import '../../domain/entities/demo_item.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/metric.dart';
import '../../domain/entities/portfolio_profile.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';
import '../../domain/entities/timeline_item.dart';

abstract interface class PortfolioLocalDataSource {
  PortfolioProfile getProfile();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  PortfolioProfile getProfile() {
    return const PortfolioProfile(
      name: 'Prathamesh J. Tulaskar',
      shortName: 'Prathamesh',
      initials: 'PT',
      heroTitle: 'Senior Flutter Lead building scalable mobile products.',
      heroSubtitle:
          '5+ years delivering secure, user-centric Flutter apps across fintech, healthcare, food-tech, service management, and enterprise domains.',
      typingRoles: ['Flutter Developer', 'Mobile Architect', 'AI Enthusiast'],
      profileImageAsset: 'assets/images/profile.png',
      resumeAsset: 'assets/documents/Prathamesh_J_Tulaskar_Resume.pdf',
      focusText:
          'Architecture ownership, end-to-end delivery, team leadership, and direct client collaboration.',
      aboutTitle:
          'Mobile tech lead with strong ownership across architecture, delivery, and client communication.',
      aboutBody:
          'Senior Flutter Lead from Mumbai with experience building production applications from scratch, mentoring Flutter developers, and translating business requirements into scalable mobile solutions. Strong in Clean Architecture, MVVM, secure APIs, encrypted storage, performance optimization, and CI/CD-ready Flutter projects.',
      aboutHighlights: [
        '5+ Years Experience',
        'Android',
        'iOS',
        'Web',
        'Team Handling',
        'API Integration',
        'Clean Architecture',
        'State Management',
      ],
      timeline: [
        TimelineItem(year: '2021', title: 'Junior Flutter Developer'),
        TimelineItem(year: '2023', title: 'Flutter Developer'),
        TimelineItem(year: '2025', title: 'Senior Flutter Developer'),
        TimelineItem(year: '2026', title: 'Technical Lead Goal'),
      ],
      metrics: [
        Metric(value: '5+', label: 'Years Experience'),
        Metric(value: '12+', label: 'Applications'),
        Metric(value: '100K+', label: 'Downloads'),
        Metric(value: '20+', label: 'Clients'),
      ],
      skills: [
        Skill(
          number: '01',
          title: 'Flutter',
          body: 'Cross-platform app delivery for Android, iOS, and Web.',
          level: 1,
        ),
        Skill(
          number: '02',
          title: 'Dart',
          body: 'Strong async, isolates, models, and modular app code.',
          level: 1,
        ),
        Skill(
          number: '03',
          title: 'Firebase',
          body: 'Auth, notifications, analytics, and app services.',
          level: .82,
        ),
        Skill(
          number: '04',
          title: 'REST API',
          body: 'Secure integration, JWT flows, caching, and error handling.',
          level: 1,
        ),
        Skill(
          number: '05',
          title: 'BLoC',
          body: 'Predictable state management for complex screens.',
          level: 1,
        ),
        Skill(
          number: '06',
          title: 'Riverpod',
          body: 'Modern provider-driven state management and dependency flow.',
          level: .82,
        ),
        Skill(
          number: '07',
          title: 'Git',
          body: 'Branching, review workflows, and release collaboration.',
          level: 1,
        ),
        Skill(
          number: '08',
          title: 'CI/CD',
          body: 'Environment-based builds and release-ready project setup.',
          level: .82,
        ),
      ],
      projects: [
        Project(
          title: 'AlphaCapital',
          tag: 'Fintech',
          colors: [AppColors.gold, AppColors.accent],
          body:
              'Funds and investment mobile application for a Saudi-based client with secure transaction workflows.',
          techStack: [
            'Flutter',
            'Dart',
            'REST API',
            'JWT',
            'Encrypted Storage',
          ],
          features: [
            'Built from scratch',
            '95% transaction workflow accuracy',
            'Secure financial data handling',
            'Client requirement ownership',
          ],
          imageAssets: [
            'assets/images/projects/alphacapital_1.png',
            'assets/images/projects/alphacapital_2.png',
            'assets/images/projects/alphacapital_3.png',
          ],
          githubUrl: '#',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.alphaInvest.alpha_capital&pcampaignid=web_share',
          appStoreUrl: '#',
          demoVideoUrl: '#',
        ),
        Project(
          title: 'Hydropure',
          tag: 'Service Management',
          colors: [AppColors.accent, AppColors.coral],
          body:
              'Service and project management app for water treatment solutions.',
          techStack: ['Flutter', 'API Integration', 'Clean Architecture'],
          features: [
            'Service tracking',
            'Project workflows',
            'Role-focused UX',
          ],
          imageAssets: [
            'assets/images/projects/hydropure_1.png',
            'assets/images/projects/hydropure_2.png',
            'assets/images/projects/hydropure_3.png',
          ],
          githubUrl: '#',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.hydropure.hydropure_systems&pcampaignid=web_share',
          appStoreUrl: '#',
          demoVideoUrl: '#',
        ),
        Project(
          title: 'Raidesh Trust',
          tag: 'Community',
          colors: [AppColors.gold, AppColors.coral],
          body:
              'Android community application supporting charitable initiatives and trust communication.',
          techStack: ['Flutter', 'Dart', 'REST API'],
          features: [
            'Community updates',
            'Trust communication',
            'Production Play Store release',
          ],
          imageAssets: [
            'assets/images/projects/raidesh_1.png',
            'assets/images/projects/raidesh_2.png',
            'assets/images/projects/raidesh_3.png',
          ],
          githubUrl: '#',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.raidesh.community_app&pcampaignid=web_share',
          appStoreUrl: '#',
          demoVideoUrl: '#',
        ),
        Project(
          title: 'ArogyNxt Health App',
          tag: 'Healthcare',
          colors: [AppColors.coral, AppColors.gold],
          body:
              'Healthcare platform supporting consultations and appointment booking.',
          techStack: ['Flutter', 'Firebase', 'REST API'],
          features: [
            'Appointment booking',
            'Consultation flows',
            'Patient-friendly interface',
          ],
          githubUrl: '#',
          playStoreUrl: '#',
          appStoreUrl: '#',
          demoVideoUrl: '#',
        ),
        Project(
          title: 'Inventory App',
          tag: 'Enterprise',
          colors: [AppColors.gold, AppColors.coral],
          body:
              'Operational inventory app concept for tracking stock, requests, and movement.',
          techStack: ['Flutter', 'REST API', 'Local Storage'],
          features: ['Stock tracking', 'Reports', 'Offline-ready flows'],
          githubUrl: '#',
          playStoreUrl: '#',
          appStoreUrl: '#',
          demoVideoUrl: '#',
        ),
        Project(
          title: 'School App',
          tag: 'Education',
          colors: [AppColors.accent, AppColors.gold],
          body:
              'School app concept for attendance, notices, homework, and parent communication.',
          techStack: ['Flutter', 'Firebase', 'Push Notifications'],
          features: ['Attendance', 'Notice board', 'Parent updates'],
          githubUrl: '#',
          playStoreUrl: '#',
          appStoreUrl: '#',
          demoVideoUrl: '#',
        ),
        Project(
          title: 'AI App',
          tag: 'AI',
          colors: [AppColors.coral, AppColors.accent],
          body:
              'AI-powered app concept for intelligent answers, automation, and user assistance.',
          techStack: ['Flutter', 'AI API', 'GetX'],
          features: ['Chat assistant', 'Context answers', 'Smart workflows'],
          githubUrl: '#',
          playStoreUrl: '#',
          appStoreUrl: '#',
          demoVideoUrl: '#',
        ),
      ],
      demos: [
        DemoItem(
          title: 'Play Store screenshots',
          description:
              'Published app screenshots are used as compact visual proof until demo videos are recorded.',
        ),
        DemoItem(
          title: 'App case studies',
          description:
              'Each project highlights domain, architecture, tech stack, and store availability.',
        ),
        DemoItem(
          title: 'More demos soon',
          description:
              'Short feature walkthroughs can be added later from screen recordings.',
        ),
      ],
      certifications: [
        Certification(
          name: 'Trainee Mobile App Developer',
          status: 'Weblozee IT Solution - May 2021',
        ),
        Certification(name: 'Google', status: 'Planned'),
        Certification(name: 'Flutter', status: 'Planned'),
        Certification(name: 'PMP', status: 'Future'),
        Certification(name: 'Firebase', status: 'Planned'),
        Certification(name: 'Apple Developer', status: 'Planned'),
      ],
      experiences: [
        Experience(
          role: 'Senior Mobile Application Developer',
          company: 'Alphacentrix Services Pvt. Ltd.',
          duration: 'Jan 2024 - Present',
          technologies: [
            'Flutter',
            'Dart',
            'Clean Architecture',
            'REST API',
            'Encrypted Storage',
          ],
          responsibilities: [
            'Leading development of a funds and investment mobile application for a Saudi-based client.',
            'Handled 85% of architecture and core development while building the product from scratch.',
            'Led and mentored 3 Flutter developers with coding standards and reviews.',
            'Managed 70% of client communication, requirement analysis, and solution design.',
          ],
          achievements: [
            'Ensured 95% accuracy in financial transaction workflows.',
            'Implemented secure encrypted handling for sensitive financial information.',
          ],
        ),
        Experience(
          role: 'Mid-Level Flutter Mobile Application Developer',
          company: 'Bhangale Software OPC Pvt. Ltd.',
          duration: 'Jan 2023 - Jan 2024',
          technologies: [
            'Flutter',
            'Dart',
            'API Integration',
            'Client Communication',
          ],
          responsibilities: [
            'Handled 70% of requirement gathering and client discussions.',
            'Converted business requirements into scalable Flutter solutions.',
          ],
          achievements: [
            'Ensured 90% feature alignment with client expectations.',
          ],
        ),
        Experience(
          role: 'Flutter Mobile Application Developer',
          company: 'Enigmasoft Technologies',
          duration: 'Jul 2021 - Jan 2023',
          technologies: [
            'Flutter',
            'Android',
            'iOS',
            'Flutter Web',
            'Microservices',
          ],
          responsibilities: [
            'Developed a feature-rich Flutter application for a UK-based client.',
            'Delivered modern UI/UX across Android and iOS platforms.',
            'Worked on Flutter Web applications and microservices-based backend integration.',
          ],
          achievements: [
            'Built reliable cross-platform features for production apps.',
          ],
        ),
        Experience(
          role: 'Trainee App Developer',
          company: 'Weblozee IT Solution',
          duration: 'Dec 2020 - Jun 2021',
          technologies: ['Flutter', 'UI', 'APIs', 'Performance Tuning'],
          responsibilities: [
            'Contributed to architecture, UI, APIs, and performance tuning.',
          ],
          achievements: ['Delivered 4 production-grade Flutter applications.'],
        ),
      ],
      blogPosts: [
        BlogPost(
          title: 'Flutter Tips for Production Apps',
          category: 'Flutter Tips',
          summary:
              'Practical patterns for structure, navigation, state, and release readiness.',
        ),
        BlogPost(
          title: 'Clean Architecture in Flutter',
          category: 'Architecture',
          summary:
              'How presentation, domain, and data layers keep apps maintainable.',
        ),
        BlogPost(
          title: 'Performance Wins with Caching and Isolates',
          category: 'Performance',
          summary: 'Small decisions that make large Flutter apps feel faster.',
        ),
        BlogPost(
          title: 'AI in Mobile Apps',
          category: 'AI',
          summary:
              'Ways to add useful AI assistants and workflow automation to mobile products.',
        ),
      ],
      assistantQuestions: [
        'Tell me about Prathamesh',
        'Which projects has he worked on?',
        'What technologies does he know?',
        'Can he work remotely?',
      ],
      contacts: [
        ContactLink(
          label: 'Email',
          url: 'mailto:prathameshtulaskar37@gmail.com',
        ),
        ContactLink(
          label: 'LinkedIn',
          url: 'https://www.linkedin.com/in/prathamesh-tulaskar/',
        ),
        ContactLink(
          label: 'GitHub',
          url: 'https://github.com/prathameshtulaskar',
        ),
        ContactLink(label: 'WhatsApp', url: 'https://wa.me/918805202434'),
      ],
      location: 'Mumbai, India',
      phone: '+91 8805202434',
    );
  }
}
