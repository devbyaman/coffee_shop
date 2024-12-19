class CoffeeItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;

  CoffeeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  factory CoffeeItem.fromMap(Map<String, dynamic> map) {
    return CoffeeItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      rating: (map['rating'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
