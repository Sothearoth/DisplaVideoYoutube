import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/home/get_all_song.dart';
import 'package:flutter_application_1/model/home/get_favorite.dart';

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

  List<GetAllSong> listAllSong = [];
  List<GetFavorite> listFavorite = [];

  late Future<List<GetFavorite>> futureFavorite;

  @override
  void initState() {
    super.initState();
    getAllSongData();
  //  getFavoriteData();

    futureFavorite = getFavorite();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar
            CustomWidget.sliverAppBar(title: "Home"),

            // scroll horizental Row
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: listAllSong
                          .map(
                            (e) =>
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                width: 120,
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: DefaultColor.primaryColor),
                                ),
                                child: Image.network(e.img!)),
                      )
                          .toList()),
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
              delegate: SliverChildListDelegate([
                  FutureBuilder<List<GetFavorite>>(
                      future: futureFavorite,
                      builder: (context, dataResponse){
                        if(dataResponse.hasData){
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dataResponse.data?.length,
                              itemBuilder: (BuildContext context, int index){
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
                                                  (dataResponse.data?[index].img)!),
                                            ),
                                            // display title

                                            Container(
                                              margin: const EdgeInsets.only(top: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    (dataResponse.data?[index].songName)!,
                                                    style: TextStyle(
                                                        color: DefaultColor.primaryColor),
                                                  ),
                                                  Text(
                                                    (dataResponse.data?[index].singerName)!,
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

                              });
                        }
                        if(dataResponse.hasError){
                          return Text('Error');
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                  })

                ],
              ),
            ),

/*            SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: listFavorite.length,
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
                                      (listFavorite[index].img)!),
                                ),
                                // display title

                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        (listFavorite[index].songName)!,
                                        style: TextStyle(
                                            color: DefaultColor.primaryColor),
                                      ),
                                      Text(
                                        (listFavorite[index].singerName)!,
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
                ))*/
          ],
        ),
      ),
    );
  }

  Future<void> getAllSongData() async {
    var data = await getAllSong();
    setState(() {
      listAllSong.addAll(data);
    });
  }

  Future<List<GetAllSong>> getAllSong() async {
    final response = await http.get(Uri.parse('http://192.168.100.11/get/songs/all'));

    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => GetAllSong.fromJson(data)).toList();
    }else{
      throw Exception('Fail to load to server');
    }

  }

  Future<void> getFavoriteData() async {
    var data = await getFavorite();
    setState(() {
      listFavorite.addAll(data);
    });
  }

  Future<List<GetFavorite>> getFavorite() async {
    final response = await http.get(Uri.parse('http://192.168.100.11/get/popularSongs'));
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => GetFavorite.fromJson(data)).toList();
    }else{
      throw Exception('Fail to load to server');
    }
  }

}