class Data {
  String bio;
  String createdby;
  String firstappearance;
  String imageurl;
  String name;
  String publisher;
  String realname;
  String team;

  Data(
      {this.bio,
      this.createdby,
      this.firstappearance,
      this.imageurl,
      this.name,
      this.publisher,
      this.realname,
      this.team});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      bio: json['bio'],
      createdby: json['createdby'],
      firstappearance: json['firstappearance'],
      imageurl: json['imageurl'],
      name: json['name'],
      publisher: json['publisher'],
      realname: json['realname'],
      team: json['team'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bio'] = this.bio;
    data['createdby'] = this.createdby;
    data['firstappearance'] = this.firstappearance;
    data['imageurl'] = this.imageurl;
    data['name'] = this.name;
    data['publisher'] = this.publisher;
    data['realname'] = this.realname;
    data['team'] = this.team;
    return data;
  }
}
