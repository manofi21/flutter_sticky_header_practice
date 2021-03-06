import 'package:flutter/material.dart';
import 'package:flutter_sticky_header_practice/model/models.dart';
import 'package:flutter_sticky_header_practice/src/get_box_offset.dart';

import '../controller/sliver_scroll_controller.dart';

class ListItemHeaderSliver extends StatelessWidget {
  const ListItemHeaderSliver({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final SliverScrollController bloc;

  @override
  Widget build(BuildContext context) {
    // for scroll troubleshooting, disable physics, and add padding in SingleChildScrollView with right 500.
    final itemsOffset = bloc.listOffsetItemHeader;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: NotificationListener(
        onNotification: (_) => true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            right: size.width -
                (((itemsOffset[itemsOffset.length - 1]) -
                    itemsOffset[itemsOffset.length - 2])),
          ),
          controller: bloc.scrollControllerItemHeader,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: ValueListenableBuilder(
            valueListenable: bloc.headerNotifier,
            builder: (_, MyHeader? snapshot, __) {
              return Row(
                children: List.generate(bloc.listCategory.length, (index) {
                  return GetBoxOffset(
                    offset: ((offset) => itemsOffset[index] = offset.dx),
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        right: 8,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: index == snapshot!.index ? Colors.white : null,
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        bloc.listCategory[index].category,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: index == snapshot.index
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
