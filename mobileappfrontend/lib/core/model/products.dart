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
    imageUrl: 'assets/data/formal/barongtagalog.png',
    category: 'Formal',
    numberEquivalent: '11',
  ),
  const Product(
    name: 'White Tuxedo',
    imageUrl: 'assets/data/formal/tuxedo.png',
    category: 'Formal',
    numberEquivalent: '12',
  ),
  const Product(
    name: 'Philippine Long Dress',
    imageUrl: 'assets/data/formal/longdress.png',
    category: 'Formal',
    numberEquivalent: '13',
  ),
  const Product(
    name: 'Flower Dress',
    imageUrl: 'assets/data/casual/flowerdress.png',
    category: 'Casual',
    numberEquivalent: '18',
  ),
  const Product(
    name: 'Leather Jacket',
    imageUrl: 'assets/data/casual/leather.png',
    category: 'Casual',
    numberEquivalent: '19',
  ),
  const Product(
    name: 'Raffle Shirt with Black Pants',
    imageUrl: 'assets/data/casual/raffle.png',
    category: 'Casual',
    numberEquivalent: '20',
  ),
  const Product(
    name: 'Red Dress',
    imageUrl: 'assets/data/eve/reddress.png',
    category: 'Evening Wear',
    numberEquivalent: '22',
  ),
  const Product(
    name: 'Suit',
    imageUrl: 'assets/data/eve/suit.png',
    category: 'Evening Wear',
    numberEquivalent: '23',
  ),
  const Product(
    name: 'Long Gown',
    imageUrl: 'assets/data/eve/gown.png',
    category: 'Evening Wear',
    numberEquivalent: '24',
  ),
  const Product(
    name: 'Karate Uniform',
    imageUrl: 'assets/data/sports/karate.png',
    category: 'Sports',
    numberEquivalent: '26',
  ),
  const Product(
    name: 'Badminton',
    imageUrl: 'assets/data/sports/badminton.png',
    category: 'Sports',
    numberEquivalent: '27',
  ),
  const Product(
    name: 'Soccer',
    imageUrl: 'assets/data/sports/soccer.png',
    category: 'Sports',
    numberEquivalent: '28',
  ),
];
