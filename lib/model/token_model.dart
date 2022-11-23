class TokenModel {
  Token? access;
  Token? refresh;

  TokenModel({this.access, this.refresh});

  TokenModel.fromJson(Map<String, dynamic> json) {
    access = json['access'] != null ? new Token.fromJson(json['access']) : null;
    refresh =
        json['refresh'] != null ? new Token.fromJson(json['refresh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.access != null) {
      data['access'] = this.access!.toJson();
    }
    if (this.refresh != null) {
      data['refresh'] = this.refresh!.toJson();
    }
    return data;
  }
}

class Token {
  String? token;
  String? expires;

  Token({this.token, this.expires});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    return data;
  }
}
