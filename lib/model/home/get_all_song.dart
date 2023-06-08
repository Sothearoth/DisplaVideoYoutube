class GetAllSong {
  String? singerName;
  String? id;
  String? songName;
  String? img;

  GetAllSong({this.singerName, this.id, this.songName, this.img});

  GetAllSong.fromJson(Map<String, dynamic> json) {
    singerName = json['singerName'];
    id = json['id'];
    songName = json['songName'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['singerName'] = this.singerName;
    data['id'] = this.id;
    data['songName'] = this.songName;
    data['img'] = this.img;
    return data;
  }
}