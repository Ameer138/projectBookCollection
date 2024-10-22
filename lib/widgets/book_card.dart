import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  BookCard({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.book), // Add icon to the leading side of ListTile
        title: Text(book.title),
        subtitle: Text(book.author),
        onTap: onTap,
      ),
    );
  }
}
