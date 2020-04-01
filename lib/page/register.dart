import 'package:CUbook/service/user_sevice.dart';
import "package:flutter/material.dart";
import "package:CUbook/class/User.dart";

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  String fname;
  String lname;
  String email;
  String pwd;
  String address;

  @override
  Widget build(BuildContext context) {
    void _showDialog(String title, String body) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(title),
            content: new Text(body),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(children: [
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                Icon(
                  Icons.note_add,
                  color: Colors.white,
                ),
                Text(
                  "Registrations",
                  style: TextStyle(color: Colors.white),
                )
              ]),
            ),
            body:isLoading
        ? Center(child:CircularProgressIndicator(
            backgroundColor: Colors.white, strokeWidth: 18))
        :  Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.06,
                  right: MediaQuery.of(context).size.height * 0.06),
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.07)),
                TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "Email",
                      hintText: 'Enter your email',
                      icon: new Icon(
                        Icons.email,
                        color: Colors.grey,
                      )),
                  onChanged: (value) => email = value,
                ),
                TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "Password",
                      hintText: 'Enter your password',
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.grey,
                      )),
                  onChanged: (value) => pwd = value,
                ),
                TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "Name",
                      hintText: 'Enter your first name',
                      icon: new Icon(
                        Icons.person,
                        color: Colors.grey,
                      )),
                  onChanged: (value) => fname = value,
                ),
                TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "Surname",
                      hintText: 'Enter your last name',
                      icon: Icon(
                        Icons.people,
                        color: Colors.grey,
                      )),
                  onChanged: (value) => lname = value,
                ),
                TextFormField(
                  maxLines: 3,
                  autofocus: false,
                  decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "Address",
                      hintText: 'Enter your address',
                      icon: new Icon(
                        Icons.place,
                        color: Colors.grey,
                      )),
                  onChanged: (value) => address = value,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: RaisedButton(
                      highlightColor: Colors.pink[300],
                      hoverColor: Colors.pink[100],
                      focusColor: Colors.pink[100],
                      splashColor: Colors.white54,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xFFEB86B1),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        register(User(
                                name: fname,
                                surname: lname,
                                address: address,
                                email: email,
                                balance: 200,
                                password: pwd))
                            .then((value) {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          _showDialog("Success", "Upload Success");
                        });
                      }),
                )
              ]),
            ));
  }
}
