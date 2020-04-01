import "package:flutter/material.dart";
import "package:CUbook/class/Book.dart";
import "package:CUbook/components/book_detail.dart";
import "package:CUbook/service/user_sevice.dart";
import "package:CUbook/service/book_service.dart";

class Profile extends StatefulWidget {
  String email;

  Profile(String email) {
    this.email = email;
  }

  @override
  _ProfileState createState() => _ProfileState(email);
}

class _ProfileState extends State<Profile> {
  String email;
  List<Book> books = [];
  bool isLoading = false;
  int balance = 0;

  Future<void> getSetting() async {
    setState(() {
      isLoading = !isLoading;
    });
    userBook(email).then((value) {
      setState(() {
        books = value;
      });
      getBalance(email).then((value) {
        print(value);
        setState(() {
          balance = value;
          isLoading = !isLoading;
        });
      });
    });
    return null;
  }

  _ProfileState(String email) {
    this.email = email;
  }

  void initState() {
    getSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Icons.person,
              color: Colors.white,
            ),
            Text(
              "Your Stocks",
              style: TextStyle(color: Colors.white),
            )
          ]),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 17,
                  backgroundColor: Colors.white,
                ),
              )
            : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final item = books[index];
                  bool isLast = 1 + index == books.length;
                  if (index == 0) {
                    return Column(children: [
                      Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.height * 0.2,
                        color: Colors.grey,
                      ),
                      ListTile(
                        title: Text(item.bookName),
                        subtitle: Text(item.author),
                        leading: Icon(Icons.book),
                        trailing: IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {
                              deleteBook(item.bookId)
                                  .then((value) => {getSetting()});cd 
                            }),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BookDetail(item)));
                        },
                      )
                    ]);
                  } else if (!isLast) {
                    return Column(children: [
                      ListTile(
                        title: Text(item.bookName),
                        subtitle: Text(item.author),
                        leading: Icon(Icons.book),
                        trailing: IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {
                              deleteBook(item.bookId)
                                  .then((value) => {getSetting()});
                            }),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BookDetail(item)));
                        },
                      ),
                    ]);
                  } else if (isLast && !books.isEmpty) {
                    return Column(children: [
                      ListTile(
                        title: Text(item.bookName),
                        subtitle: Text(item.author),
                        leading: Icon(Icons.book),
                        trailing: IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {
                              deleteBook(item.bookId)
                                  .then((value) => {getSetting()});
                            }),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BookDetail(item)));
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.all(40),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Your Balance : " +
                                    balance.toString() +
                                    " ฿")
                              ]))
                    ]);
                  }
                }));
  }
}
