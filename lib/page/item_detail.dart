import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/detail/item_detail.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ItemDetail extends StatefulWidget {

  final String title;
  final String id;

  const ItemDetail({Key? key, required this.title, required this.id}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {

  late Future<ItemDetailResponse> futureDetail;
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    futureDetail = getItemDetail(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: FutureBuilder<ItemDetailResponse>(
        future: futureDetail,
        builder: (context, detail){

          if(detail.data?.songName != null){
            controller = YoutubePlayerController(
              initialVideoId: (detail.data?.content)!,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: true,
                isLive: true
              ),
            );
          }

          if(detail.hasData){
            return YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player){
                return Column(
                  children: [
                    player,
                  ],
                );
              },
            );
          }
          if(detail.hasError){
            return const Text('Error');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<ItemDetailResponse> getItemDetail(String id) async {
    final response   = await http.get(Uri.parse('http://192.168.100.11/get/song/view/$id'));
    if(response.statusCode == 200){
      print(response.body);
      return ItemDetailResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fail to load to server!');
    }
  }

}
