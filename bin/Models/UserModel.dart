// ignore_for_file: file_names

class UserModel{
  final int? id;
  final String name;
  final String email; 
  final String username;
  final String phone;
  final String idAuth;


  UserModel({this.id,required this.name,required this.email,required this.username,required this.phone,required this.idAuth});

  factory UserModel.fromJson({required Map json}){
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      username: json["username"],
      phone: json["phone"],
      idAuth: json["id_auth"],
    );
  }

  toMap(){
    final jsonMap = {
      "name": name,
      "email": email,
      "username": username,
      "phone": phone,
      "id_auth": idAuth,
    };

    if(id == null){
      return jsonMap;
    }

    return {"id": id, ...jsonMap};
  }

}