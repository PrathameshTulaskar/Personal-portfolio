class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.duration,
    required this.technologies,
    required this.responsibilities,
    required this.achievements,
  });

  final String role;
  final String company;
  final String duration;
  final List<String> technologies;
  final List<String> responsibilities;
  final List<String> achievements;
}
