import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

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

  final visibleHeader = ValueNotifier(false);

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
    loadDataRandom();
    listOffsetItemHeader = List.generate(
      listCategory.length,
      (index) => index.toDouble(),
    );
    scrollControllerGlobally = ScrollController();
    scrollControllerItemHeader = ScrollController();
    scrollControllerGlobally.addListener(_listenToScollChange);
    headerNotifier.addListener(_listenHeaderNeotifier);
    visibleHeader.addListener(_listendVisibleHeader);
  }

  void _listendVisibleHeader() {
    if (visibleHeader.value) {
      headerNotifier.value = const MyHeader(visibile: false, index: 0);
    }
  }

  void _listenHeaderNeotifier() {
    // Would be error if if condition disable. Try It.
    if (visibleHeader.value) {
      for (var i = 0; i < listCategory.length; i++) {
        scrollAnimationHorizontal(index: i);
      }
    }
  }

  void scrollAnimationHorizontal({required int index}) {
    if (headerNotifier.value?.index == index &&
        headerNotifier.value!.visibile) {
      scrollControllerItemHeader.animateTo(
          listOffsetItemHeader[headerNotifier.value!.index] - 16,
          duration: const Duration(milliseconds: 500),
          curve: goingDown.value ? Curves.bounceOut : Curves.fastOutSlowIn);
    }
  }

  void dispose() {
    scrollControllerGlobally.dispose();
    scrollControllerItemHeader.dispose();
  }

  void _listenToScollChange() {
    globalOffsetValue.value = scrollControllerGlobally.offset;
    if (scrollControllerGlobally.position.userScrollDirection ==
        ScrollDirection.reverse) {
      goingDown.value = true;
    } else {
      goingDown.value = false;
    }
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
