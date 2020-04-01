import 'dart:convert';

User postFromJson(String str){
  final jsonData=json.decode(str);
  return User.fromJson(jsonData);
}

String postToJson(User data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class User {
 String name;
 String surname;
 String address;
 int balance;
 String password;
 String email;

 User({
   this.name,
   this.surname,
   this.address,
   this.balance,
   this.email,
   this.password
 });

 factory User.fromJson(Map<String, dynamic> json)=>new User(
   name: json["custFName"],
   surname: json["custLName"],
   address: json["address"],
   balance: json["balance"],
   email: json["username"],
   password: json["pwd"]
 );

 Map<String, dynamic> toJson()=>{
  "fName":this.name,
  "lName" :this.surname,
  "address" :this.address,
  "balance" : this.balance,
  "pwd" :this.password,
  "username" :this.email
 };

}
