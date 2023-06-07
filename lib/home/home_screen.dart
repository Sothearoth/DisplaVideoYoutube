import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import '../dummy/dummy_data.dart';
import 'package:http/http.dart' as http;
import '../widget/sliver_appbar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List arrayFav = [];
  DummyData dummyData = DummyData();

  @override
  void initState() {
    super.initState();
  //  trackingFind(5);
    getAll(5);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: CustomScrollView(
          slivers: [
            // App Bar
            CustomWidget.sliverAppBar(title: "Home"),

            // scroll horizental Row
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dummyData.listMapImg
                      .map((e) => Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: 120,
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: DefaultColor.primaryColor),
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                  e.img,
                                  height: 160,
                                ),
                                Text(e.title)
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),

            // title pupular
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pupular Song",
                      style: TextStyle(
                          color: DefaultColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const Text(
                      "view alll",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: dummyData.listMapImg.length,
              (context, index) {
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    print(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: DefaultColor.primaryColor),
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
                              padding: const EdgeInsets.all(8),
                              width: 100,
                              child: Image.network(
                                  dummyData.listMapImg[index].img),
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
                        InkWell(
                          onTap: () {
                            final isExist = arrayFav.contains(index);
                            setState(() {
                              !isExist
                                  ? arrayFav.add(index)
                                  : arrayFav.remove(index);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            child: arrayFav.contains(index)
                                ? Icon(
                                    Icons.favorite,
                                    color: DefaultColor.primaryColor,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color: DefaultColor.primaryColor,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  void getAll(int count) async {

    final response = await http.get(Uri.parse('http://192.168.100.11/get/songs/all'),);
    if (response.statusCode == 200) {
      log('Tracking Find Response : ${response.body}' );
    //  return TrackingFindIDResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load to server!!');
    }
  }





}
