import 'package:flutter/material.dart';

class Project {
  const Project({
    required this.title,
    required this.tag,
    required this.body,
    required this.colors,
    required this.techStack,
    required this.features,
    this.imageAssets = const [],
    required this.githubUrl,
    required this.playStoreUrl,
    required this.appStoreUrl,
    required this.demoVideoUrl,
  });

  final String title;
  final String tag;
  final String body;
  final List<Color> colors;
  final List<String> techStack;
  final List<String> features;
  final List<String> imageAssets;
  final String githubUrl;
  final String playStoreUrl;
  final String appStoreUrl;
  final String demoVideoUrl;
}
