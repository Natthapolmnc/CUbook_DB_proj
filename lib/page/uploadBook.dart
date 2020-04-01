import 'package:CUbook/page/Catalog.dart';
import "package:flutter/material.dart";
import "package:CUbook/service/book_service.dart";

class Upload extends StatefulWidget {
  String email;

  Upload(String email) {
    this.email = email;
  }

  @override
  _UploadState createState() => _UploadState(email);
}

class _UploadState extends State<Upload> {
  bool isLoading = false;
  String bookName;
  String author;
  double bookPrice;
  String seller;
  int amount;

  _UploadState(String email) {
    this.seller = email;
  }

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
                      MaterialPageRoute(builder: (context) => Catalog(seller)));
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
              Icons.add_comment,
              color: Colors.white,
            ),
            Text(
              "Book Upload",
              style: TextStyle(color: Colors.white),
            )
          ]),
        ),
        body: isLoading
            ? Center(child:CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 18,
              ))
            : Padding(
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
                      labelText: "Book name",
                      hintText: 'Enter the name of your book',
                    ),
                    onChanged: (value) => bookName = value,
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "author",
                      hintText: 'Enter the author name',
                    ),
                    onChanged: (value) => author = value,
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "Price",
                      hintText: 'Enter your price',
                    ),
                    onChanged: (value) => bookPrice = double.parse(value),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      labelText: "Qualtity",
                      hintText: 'Enter the qualtity of your stocks',
                    ),
                    onChanged: (value) => amount = int.parse(value),
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
                          uploadBook(
                                  bookName, author, bookPrice, seller, amount)
                              .then((value) {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            _showDialog("Success", "Upload success");
                          });
                        }),
                  )
                ]),
              ));
  }
}
