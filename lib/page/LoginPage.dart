import "package:flutter/material.dart";
import 'package:CUbook/service/user_sevice.dart';
import "Catalog.dart";
import "register.dart";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String _password = "";
  String _email = "";

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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Catalog(_email)));
                },
              ),
            ],
          );
        },
      );
    }

    void _showDialogFailed(String title, String body) {
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
          title: Text(
            "BookStore",
            style: TextStyle(fontSize: 23, color: Colors.white),
          )),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.white, strokeWidth: 16),
            )
          : Column(children: [
              Padding(
                child: Icon(
                  Icons.person,
                  size: MediaQuery.of(context).size.height * 0.2,
                  color: Colors.grey,
                ),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.01),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, right: 50, left: 50),
                child: Column(children: [
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    decoration: new InputDecoration(
                        labelStyle: TextStyle(fontSize: 16),
                        labelText: "Email",
                        hintText: 'Enter your email',
                        icon: new Icon(
                          Icons.mail,
                          color: Colors.grey,
                        )),
                    onChanged: (value) => _email = value,
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    obscureText: true,
                    autocorrect: false,
                    decoration: new InputDecoration(
                        labelStyle: TextStyle(fontSize: 16),
                        labelText: "Password",
                        hintText: 'Enter your password',
                        icon: new Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )),
                    onChanged: (value) => _password = value,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                highlightColor: Colors.pink[300],
                                hoverColor: Colors.pink[100],
                                focusColor: Colors.pink[100],
                                splashColor: Colors.white54,
                                color: Color(0xFFEB86B1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isLoading = !isLoading;
                                  });
                                  print(isLoading);
                                  login(_email, _password).then((value) {
                                    print(value);
                                    if (value == 200) {
                                      _showDialog("Login Success", "success");
                                      setState(() {
                                        isLoading = !isLoading;
                                      });
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Catalog(_email)));
                                    } else {
                                      _showDialogFailed("Login falied",
                                          "invalid email/password");
                                    }
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                  });
                                  // print(isLoading);
                                }),
                            Padding(
                              padding: EdgeInsets.only(left: 19),
                            ),
                            RaisedButton(
                                highlightColor: Colors.pink[300],
                                hoverColor: Colors.pink[100],
                                focusColor: Colors.pink[100],
                                splashColor: Colors.white54,
                                child: Text(
                                  "Register",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Color(0xFFEB86B1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                })
                          ]))
                ]),
              )
            ]),
    );
  }
}
