class User {
  /**
   * id
   * name
   * email
   * password
   */

  late int id;
  late String name;
  late String email;
  late String password;

  static const String tableName = "users";

  User();

  //Constructor: Used to read data from DB and convert it to model
  //{"id":1, name: "user-name", email: "user-email@app.com", password:"password"}
  User.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap["id"];
    name = rowMap["name"];
    email = rowMap["email"];
    password = rowMap["password"];
  }

  //Function: Used to save data in database table
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    return map;
  }
}