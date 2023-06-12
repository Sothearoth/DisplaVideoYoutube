class ItemDetailResponse {

  String? id;
  String? content;
  String? songName;

  ItemDetailResponse({this.id, this.content, this.songName});

  ItemDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    songName = json['songName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['songName'] = this.songName;
    return data;
  }
}