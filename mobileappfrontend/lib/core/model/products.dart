class Product {
  final String name;
  final String imageUrl;
  final String category;
  final String numberEquivalent;

  const Product(
      {required this.name,
      required this.imageUrl,
      required this.category,
      required this.numberEquivalent});

  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        imageUrl = json['imageUrl'] as String,
        category = json['category'] as String,
        numberEquivalent = json['numberEquivalent'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'category': category,
        'numberEquivalent': numberEquivalent
      };
}

final List<Product> productsItems = [
  const Product(
    name: 'Barong Tagalog',
    imageUrl: 'assets/data/party/jacket1.png',
    category: 'Formal',
    numberEquivalent: '11',
  ),
  const Product(
    name: 'School Uniform Boys',
    imageUrl: 'assets/data/party/jacket2.jpg',
    category: 'Formal',
    numberEquivalent: '12',
  ),
  const Product(
    name: 'School Uniform Girls',
    imageUrl: 'assets/data/party/blazerandpants.jpg',
    category: 'Formal',
    numberEquivalent: '13',
  ),
  const Product(
    name: 'Flower Dress',
    imageUrl: 'assets/data/wedding/wedding1.png',
    category: 'Casual',
    numberEquivalent: '18',
  ),
  const Product(
    name: 'Black Dress',
    imageUrl: 'assets/data/wedding/wedding2.png',
    category: 'Casual',
    numberEquivalent: '19',
  ),
  const Product(
    name: 'Pink Dress',
    imageUrl: 'assets/data/wedding/wedding3.png',
    category: 'Casual',
    numberEquivalent: '20',
  ),
  const Product(
    name: 'Red Dress',
    imageUrl: 'assets/data/business/business1.png',
    category: 'Evening Wear',
    numberEquivalent: '22',
  ),
  const Product(
    name: 'White Dress',
    imageUrl: 'assets/data/business/business2.png',
    category: 'Evening Wear',
    numberEquivalent: '23',
  ),
  const Product(
    name: 'Monochrome Dress',
    imageUrl: 'assets/data/business/business3.png',
    category: 'Evening Wear',
    numberEquivalent: '24',
  ),
  const Product(
    name: 'Karate Uniform',
    imageUrl: 'assets/data/beach/beach1.png',
    category: 'Sports',
    numberEquivalent: '26',
  ),
  const Product(
    name: 'Badminton Uniform',
    imageUrl: 'assets/data/beach/beach2.png',
    category: 'Sports',
    numberEquivalent: '27',
  ),
  const Product(
    name: 'Soccer Uniform',
    imageUrl: 'assets/data/beach/beach3.png',
    category: 'Sports',
    numberEquivalent: '28',
  ),
];
