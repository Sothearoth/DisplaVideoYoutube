class GetFavorite {
  String? singerName;
  bool? popular;
  String? id;
  String? songName;
  String? img;

  GetFavorite(
      {this.singerName, this.popular, this.id, this.songName, this.img});

  GetFavorite.fromJson(Map<String, dynamic> json) {
    singerName = json['singerName'];
    popular = json['popular'];
    id = json['id'];
    songName = json['songName'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['singerName'] = this.singerName;
    data['popular'] = this.popular;
    data['id'] = this.id;
    data['songName'] = this.songName;
    data['img'] = this.img;
    return data;
  }
}