import 'package:CUbook/page/LoginPage.dart';
import 'package:CUbook/page/profile.dart';
import 'package:CUbook/service/book_service.dart';
import 'package:CUbook/page/uploadBook.dart';
import "package:CUbook/page/Cart.dart";
import "package:CUbook/class/Book.dart";
import 'package:CUbook/service/user_sevice.dart';
import "package:flutter/material.dart";
import "package:CUbook/components/book_detail.dart";

class Catalog extends StatefulWidget {
  String email;

  Catalog(String email) {
    this.email = email;
  }

  @override
  _CatalogState createState() => _CatalogState(email);
}

class _CatalogState extends State<Catalog> {
  bool isLoading = false;
  String email;

  _CatalogState(String email) {
    this.email = email;
  }

  List<Book> items=[];
  Set<Book> _saved = Set<Book>();

  Future<void> getAll() {
    setState(() {
      isLoading = true;
    });
     getAllBook().then((value) {
      setState(() {
        items = value;
        isLoading = false;
      });
    });
    return null;
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    _displayDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Fill in the money'),
              content: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "฿฿฿"),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Confirm'),
                  onPressed: () {
                    Navigator.of(context).pop(_textFieldController.text);
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Icon(
                Icons.photo_album,
                color: Colors.white,
              ),
              Text("Catalog", style: TextStyle(color: Colors.white)),
              Expanded(child: Padding(padding: EdgeInsets.only(left: 30))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.person),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Profile(email)));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      getAll();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.file_upload,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Upload(email)));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Cart(_saved, email)));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                ],
              )
            ],
          )),
      body:  isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white, strokeWidth: 16))
                :ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final book = items[index];
            final bool alreadySaved = _saved.contains(book);
            return ListTile(
                    title: Text(book.bookName),
                    subtitle: Text(book.author),
                    leading: Icon(Icons.book),
                    trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart,
                            color:
                                alreadySaved ? Colors.pinkAccent : Colors.grey),
                        onPressed: () {
                          setState(() {
                            if (alreadySaved) {
                              _saved.remove(book);
                            } else {
                              _saved.add(book);
                            }
                          });
                        }),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BookDetail(book)));
                    },
                  );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.attach_money),
          onPressed: () {
            _displayDialog(context).then((value) {
              updateBalance(email, double.parse(value));
            });
          }),
    );
  }
}
