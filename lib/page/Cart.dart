import "package:flutter/material.dart";
import "package:CUbook/class/Book.dart";
import "package:CUbook/page/Catalog.dart";
import "package:CUbook/service/order_service.dart";
@immutable
class Cart extends StatefulWidget {
  Set<Book> books;
  String buyer;

  Cart(Set<Book> items, String user) {
    this.books = items;
    this.buyer = user;
  }

  @override
  _CartState createState() => _CartState(books, buyer);
}

class _CartState extends State<Cart> {
  Set<Book> items;
  String buyer;
  bool isLoading = false;

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
                    MaterialPageRoute(builder: (context) => Catalog(buyer)));
              },
            ),
          ],
        );
      },
    );
  }

  _CartState(Set<Book> books, String user) {
    this.items = books;
    this.buyer = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Row(children: [
                Icon(
                  Icons.add_comment,
                  color: Colors.white,
                ),
                Text(
                  "Payment",
                  style: TextStyle(color: Colors.white),
                )
              ]),
            ),
            body:  isLoading
        ? Center(child:CircularProgressIndicator(
            backgroundColor: Colors.white, strokeWidth: 16))
        :ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final book = items.elementAt(index);
                  bool isLast = 1 + index == items.length;
                  if (!isLast) {
                    return ListTile(
                      title: Text(book.bookName),
                      subtitle: Text(book.bookPrice.toString() + " baht"),
                      leading: Icon(Icons.book),
                    );
                  } else {
                    return Column(children: [
                      ListTile(
                        title: Text(book.bookName),
                        subtitle: Text(book.bookPrice.toString() + " baht"),
                        leading: Icon(Icons.book),
                      ),
                      Padding(
                          padding: EdgeInsets.all(40),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Payment method : ",
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 16),
                                ),
                                Padding(padding: EdgeInsets.only(left: 20)),
                                RaisedButton(
                                  color: Color(0xFFEB86B1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.attach_money,
                                        color: Colors.white,
                                        size: 17,
                                      ),
                                      Text(
                                        "Cash",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    List<Book> books = [];
                                    for (Book i in items) {
                                      books.add(i);
                                    }
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                    order(books, buyer, 1).then((value) {
                                      setState(() {
                                        isLoading = !isLoading;
                                      });
                                      _showDialog("Payment Success",
                                          "Payment has been been paid\n Thank you for your support");
                                    });
                                  },
                                ),
                                Padding(padding: EdgeInsets.only(left: 20)),
                                RaisedButton(
                                  color: Color(0xFFEB86B1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.credit_card,
                                        color: Colors.white,
                                        size: 17,
                                      ),
                                      Text(
                                        "Credit",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    List<Book> books = [];
                                    for (Book i in items) {
                                      books.add(i);
                                    }
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                    order(books, buyer, 2).then((value) {
                                      setState(() {
                                        isLoading = !isLoading;
                                      });
                                      _showDialog("Payment Success",
                                          "Payment has been been paid\n Thank you for your support");
                                    });

                                  },
                                ),
                              ]))
                    ]);
                  }
                }),
          );
  }
}
