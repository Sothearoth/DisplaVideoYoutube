import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../dummy/dummy_data.dart';
import '../model/model.dart';
import '../widget/sliver_appbar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen();

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  DummyData dummyData = DummyData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: CustomScrollView(
          slivers: [
            // App Bar
            CustomWidget.sliverAppBar(title: "Favorite"),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: dummyData.listMapImg.length,
              (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 100,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: DefaultColor.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // display image
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            width: 100,
                            child:
                                Image.network(dummyData.listMapImg[index].img),
                          ),
                          // display title

                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  dummyData.listMapImg[index].title,
                                  style: TextStyle(
                                      color: DefaultColor.primaryColor),
                                ),
                                Text(
                                  dummyData.listMapImg[index].singerName,
                                  style: TextStyle(
                                      color: DefaultColor.primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 10, top: 10),
                          child: Icon(
                            Icons.favorite,
                            color: DefaultColor.primaryColor,
                          )),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
