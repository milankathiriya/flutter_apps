class User{

  int id;
  String name;

  User(this.id, this.name);

  User.fromMap(Map<String, dynamic> map){
      id = map['id'];
      name = map['name'];
  }

}