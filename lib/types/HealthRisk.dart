class HealthRisk {
  final int id;
  final String name;

  HealthRisk({this.name, this.id});

  factory HealthRisk.fromJson(Map<String, dynamic> json) {
    return HealthRisk(
      id: int.parse(json['code']),
      name: json['displayName'],
    );
  }
}