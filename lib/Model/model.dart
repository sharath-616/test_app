
class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
  });
}


class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String category;
  final double? rating;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    this.rating,
  });
}