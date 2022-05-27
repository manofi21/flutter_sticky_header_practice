import 'package:flutter/material.dart';

import '../controller/sliver_scroll_controller.dart';

class ListItemHeaderSliver extends StatelessWidget {
  const ListItemHeaderSliver({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final SliverScrollController bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(bloc.listCategory.length, (index) {
            return Container(
              margin: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: index == 0 ? Colors.white : null,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                bloc.listCategory[index].category,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: index == 0 ? Colors.black : Colors.white,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
