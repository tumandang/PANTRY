class PopularFood {
  final int id;
  final String name;
  final String image;
  final int count;

  PopularFood({
    required this.id,
    required this.name,
    required this.image,
    required this.count,
  });

  factory PopularFood.fromJson(Map<String, dynamic> json) {
    return PopularFood(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      count: int.tryParse(json['count']?.toString() ?? '0') ?? 0,
    );
  }
}
