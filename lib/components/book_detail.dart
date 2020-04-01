import "package:flutter/material.dart";
import "package:CUbook/class/Book.dart";


class BookDetail extends StatelessWidget {
  Book book;

  BookDetail(Book book){
    this.book=book;
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
              Icons.library_books,
              color: Colors.white,
            ),
            Text(
              book.bookName,
              style: TextStyle(color: Colors.white),
            )
          ]),
        ),
        body: Center(child:Column(children: <Widget>[
          Padding(
          child: Icon(
            Icons.book,
            size: MediaQuery.of(context).size.height * 0.2,
            color: Colors.grey,
          ),
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              bottom: MediaQuery.of(context).size.height * 0.01),
        ),
        Text("Book name : "+book.bookName,style: TextStyle(fontSize:17),),
        Text("Author : "+book.author,style: TextStyle(fontSize:17) ),
        Text("Price : "+book.bookPrice.toString(),style: TextStyle(fontSize:17)),
        Text("Seller : "+book.seller,style: TextStyle(fontSize:17)),
        Text(book.amount.toString()+" in stocks",style: TextStyle(fontSize:17))

        ],crossAxisAlignment:CrossAxisAlignment.start),
    ));
  }
}