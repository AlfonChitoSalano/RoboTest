import 'package:mobileappfrontend/core/model/products.dart';

class Category {
  final String name;
  final String numberEquivalent;
  final List<Product> products;

  const Category({
    required this.name,
    required this.numberEquivalent,
    required this.products,
  });

  Category.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        numberEquivalent = json['numberEquivalent'] as String,
        products = (json['products'] as List<dynamic>?)
                ?.map((product) => Product.fromJson(product))
                .toList() ??
            [];

  Map<String, dynamic> toJson() => {
        'name': name,
        'numberEquivalent': numberEquivalent,
        'products': products.map((product) => product.toJson()).toList(),
      };
}

final List<Category> categoriesItems = [
  const Category(
    name: 'Formal',
    numberEquivalent: '1',
    products: [],
  ),
  const Category(
    name: 'Casual',
    numberEquivalent: '2',
    products: [],
  ),
  const Category(
    name: 'Evening Wear',
    numberEquivalent: '3',
    products: [],
  ),
  const Category(
    name: 'Sports',
    numberEquivalent: '4',
    products: [],
  ),
  const Category(
    name: 'Wedding',
    numberEquivalent: '5',
    products: [],
  ),
];
