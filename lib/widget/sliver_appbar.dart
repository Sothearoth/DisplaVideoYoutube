import 'package:flutter/material.dart';

import '../utils/color.dart';

class CustomWidget {
  static sliverAppBar({required String title}) {
    return SliverAppBar(
      expandedHeight: 70,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 0, bottom: 10),
        centerTitle: false,
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: DefaultColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
