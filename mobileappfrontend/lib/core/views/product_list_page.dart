import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mobileappfrontend/core/model/category.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';
import 'package:mobileappfrontend/core/utils/colors.dart';
import 'package:mobileappfrontend/core/views/product_without_chat_page.dart';
import 'package:mobileappfrontend/main.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with WidgetsBindingObserver {
  final ProductRepository _productRepository =
      GetIt.instance<ProductRepository>();
  final List<Color> _categoriesColors = [
    const Color(0xff01c5ff),
    const Color(0xffffd829),
    const Color(0xffff5152),
    const Color(0xff00bd64),
    const Color(0xff5b28b1),
    const Color(0xffffa500),
  ];
  final List<String> _categoriesIcons = [
    'assets/icons/party.png',
    'assets/icons/wedding.png',
    'assets/icons/business.png',
    'assets/icons/sports.png',
    'assets/icons/beach.png',
    'assets/icons/users.png',
  ];
  final String _appLifeCycleStart = 'Start';
  final String _appLifeCycleStop = 'Stop';

  String _selectedCategory = '';
  bool _isLoading = true;
  List<Category> _productCategories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _productRepository.sendAppLifeCycleStateAsync(_appLifeCycleStart);
    _productRepository.getProductCategoriesAsync().then((categories) {
      setState(() {
        _productCategories = categories;
        _productCategories.add(
          const Category(
            name: 'Globe',
            numberEquivalent: '6',
            products: [],
          ),
        );
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      await _productRepository.sendAppLifeCycleStateAsync(_appLifeCycleStart);
      return;
    }

    if (state == AppLifecycleState.paused) {
      await _productRepository.sendAppLifeCycleStateAsync(_appLifeCycleStop);
    }
  }

  Future<void> _sendSelectedCategoryAsync(String selectedCategory) async {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (ctx) =>
                ProductWithoutChatPage(selectedCategory: selectedCategory)))
        .then((value) async {
      if (value.toString().toLowerCase() == _appLifeCycleStart.toLowerCase()) {
        await _productRepository.sendAppLifeCycleStateAsync(_appLifeCycleStart);
      }
    });

    await _productRepository.sendSelectedCategoryAsync(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: connectivityNotifier,
      builder: (context, isConnected, child) {
        if (isConnected) {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ));
        }

        return Scaffold(
          appBar: !isConnected
              ? AppBar(
                  backgroundColor: const Color(0xFFF04233),
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'No internet connection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
          body: SafeArea(
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: isConnected ? 40.0 : 20.0,
                            bottom: 20.0,
                          ),
                          child: Text(
                            'Select categories',
                            style: TextStyle(
                              fontSize: isConnected ? 20.0 : 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              left: 14.0,
                              right: 14.0,
                              bottom: 14.0,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14.0,
                              mainAxisSpacing: 14.0,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: _productCategories.length,
                            itemBuilder: (context, index) {
                              var category = _productCategories[index];

                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  if (category.name == 'Globe') {
                                    return;
                                  }

                                  setState(() {
                                    _selectedCategory = category.name;
                                  });

                                  await _sendSelectedCategoryAsync(
                                      _selectedCategory);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _categoriesColors[
                                        index % _categoriesColors.length],
                                    border: Border.all(
                                      color: _selectedCategory == category.name
                                          ? Colors.blue
                                          : Colors.transparent,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: category.name == 'Globe'
                                            ? Alignment.center
                                            : Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Image.asset(
                                            _categoriesIcons[index %
                                                _categoriesIcons.length],
                                            width: category.name == 'Globe'
                                                ? 90.0
                                                : 30.0,
                                            height: category.name == 'Globe'
                                                ? 90.0
                                                : 30.0,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: category.name != 'Globe',
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Text(
                                              category.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
