import 'package:flutter/material.dart';
import 'package:mobileappfrontend/core/views/product_list_page.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter IoT Arduino',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      // Product Chat Page is a page with a chat text field
      // home: const ProductChatPage(),
      // Product List Page is a page with a list of products and without a chat text field
      //design is base from here https://www.freepik.com/free-vector/charity-app-interface-concept_9427821.htm#fromView=search&page=1&position=16&uuid=d565096e-b140-4e91-9750-71f7c4e75f17
      home: const ProductListPage(),
      // PubSubPage is send-message
      // home: const PubSubPage(),
    );
  }
}
