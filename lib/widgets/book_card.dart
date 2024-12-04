// //book_card.dart
// import 'package:flutter/material.dart';
// import '../models/book.dart';
//
// class BookCard extends StatelessWidget {
//    Book book;
//   VoidCallback onTap;
//
//   BookCard({required this.book, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: Icon(Icons.book), // Add icon to the leading side of ListTile
//         title: Text(book.title),
//         subtitle: Text(book.author),
//         onTap: onTap,
//       ),
//     );
//   }
// }
//
//
//book_card.dart
import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onFavorite;

  BookCard({required this.book, this.onFavorite, required Future Function() onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: onFavorite,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: book,
          );
        },
      ),
    );
  }
}
