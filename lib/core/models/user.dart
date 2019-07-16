class User {
  int id;
  String name;
  String username;
  User({this.id, this.name, this.username});

  int getId(){
    return  id??0;
  }

  String getName(){
    return name??"";
  }

  String getUsername(){
    return username??"";
  }

  User.initial()
      : id = 0,
        name = '',
        username = '';

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}
