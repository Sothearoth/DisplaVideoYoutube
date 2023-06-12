import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../dummy/dummy_data.dart';
import '../widget/sliver_appbar.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  DummyData dummyData = DummyData();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: CustomScrollView(
        slivers: [
          CustomWidget.sliverAppBar(title: "Popular song"),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
            delegate: SliverChildBuilderDelegate((context, index) {
              return InkWell(
                onTap: () {
       /*           Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayVideos(
                        title: dummyData.listMapImg[index].title,
                      ),
                    ),
                  );*/
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: DefaultColor.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        dummyData.listMapImg[index].img,
                        height: 140,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(dummyData.listMapImg[index].title),
                      )
                    ],
                  ),
                ),
              );
            }, childCount: dummyData.listMapImg.length),
          )
        ],
      ),
    ));
  }
}
