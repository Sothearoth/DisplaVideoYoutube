
class LoginResponse {
  Header? header;
  Body? body;

  LoginResponse({this.header, this.body});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Header {
  int? serverTimestamp;
  bool? result;
  int? statusCode;

  Header({this.serverTimestamp, this.result, this.statusCode});

  Header.fromJson(Map<String, dynamic> json) {
    serverTimestamp = json['serverTimestamp'];
    result = json['result'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serverTimestamp'] = this.serverTimestamp;
    data['result'] = this.result;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Body {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;

  Body(
      {this.accessToken,
        this.tokenType,
        this.refreshToken,
        this.expiresIn,
        this.scope});

  Body.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['tokenType'] = this.tokenType;
    data['refreshToken'] = this.refreshToken;
    data['expiresIn'] = this.expiresIn;
    data['scope'] = this.scope;
    return data;
  }
}
