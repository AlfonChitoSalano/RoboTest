import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:mobileappfrontend/core/model/products.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';
import 'package:mobileappfrontend/core/utils/colors.dart';
import 'package:share/share.dart';

class CarouselWidget extends StatefulWidget {
  final List<Product> products;
  final int selectedIndex;

  const CarouselWidget({
    super.key,
    required this.products,
    this.selectedIndex = -1,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final ProductRepository _productRepository =
      GetIt.instance<ProductRepository>();
  final CarouselController _carouselController = CarouselController();

  int _currentIndex = 0;
  int _selectedIndex = -1;

  void _setIndex(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _shareImage(String imageUrl) {
    Share.share('Check out this product: $imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30.0),
          Text(
            widget.products[_currentIndex].name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 30.0),
          GestureDetector(
            onTap: () async {
              setState(() {
                _selectedIndex = _currentIndex;
              });

              var selectedProduct = widget.products[_currentIndex];
              await _productRepository
                  .sendSelectedProductAsync(selectedProduct.name);

              Fluttertoast.showToast(
                msg: 'You selected ${selectedProduct.name}',
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: AppColors.primaryColor,
              );
            },
            child: CarouselSlider.builder(
              itemCount: widget.products.length,
              carouselController: _carouselController,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.products[index].imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(
                            color:
                                _selectedIndex == index && _currentIndex != -1
                                    ? Colors.blue
                                    : Colors.transparent,
                            width: 4.0,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black.withOpacity(0.04),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.share, color: Colors.white),
                        onPressed: () =>
                            _shareImage(widget.products[index].imageUrl),
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 410,
                enlargeCenterPage: true,
                onPageChanged: _setIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
