import 'package:flutter/cupertino.dart';

import '../data/data.dart';
import '../model/my_header.dart';
import '../model/product_category.dart';

// 2:07

class SliverScrollController {
  late List<ProductCategory> listCategory;

  List<double> listOffsetItemHeader = [];

  final headerNotifier = ValueNotifier<MyHeader?>(null);

  final globalOffsetValue = ValueNotifier<double>(0);

  final goingDown = ValueNotifier<bool>(false);

  final valueScroll = ValueNotifier<double>(0);

  late ScrollController scrollControllerItemHeader;

  late ScrollController scrollControllerGlobally;

  void loadDataRandom() {
    final productsTwo = [...products];
    final productsThree = [...products];
    final productsFour = [...products];

    productsTwo.shuffle();
    productsThree.shuffle();
    productsFour.shuffle();

    listCategory = [
      ProductCategory(
        category: 'Order Again',
        products: products,
      ),
      ProductCategory(
        category: 'Picked For You',
        products: products,
      ),
      ProductCategory(
        category: 'Startes',
        products: products,
      ),
      ProductCategory(
        category: 'Gimpud Sushi',
        products: products,
      )
    ];
  }

  void init() {
    // loadDataRandom()
    listOffsetItemHeader = List.generate(
      listCategory.length,
      (index) => index.toDouble(),
    );
    scrollControllerGlobally = ScrollController();
    scrollControllerItemHeader = ScrollController();
  }

  void dispose() {
    scrollControllerGlobally.dispose();
    scrollControllerItemHeader.dispose();
  }

  void refreshHeader(
    int index,
    bool visible, {
    int? lastIndex,
  }) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.index ?? index;
    final headerVisible = headerValue?.visibile ?? false;

    if (headerTitle != index || lastIndex != null || headerVisible) {
      Future.microtask(() {
        if (!visible && lastIndex != null) {
          headerNotifier.value = MyHeader(
            visibile: true,
            index: lastIndex,
          );
        } else {
          headerNotifier.value = MyHeader(
            visibile: visible,
            index: index,
          );
        }
      });
    }
  }
}
