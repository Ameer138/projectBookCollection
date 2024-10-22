import 'package:flutter/material.dart';
import '../models/book.dart';

class DetailsScreen extends StatelessWidget {
  final Book book;

  DetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(Icons.book, 'Title', book.title),
                  _buildDetailRow(Icons.person, 'Author', book.author),
                  _buildDetailRow(Icons.category, 'Genre', book.genre),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/3rd.png'), // Path to your background image
        fit: BoxFit.cover,
      ),
    ),
  );

  Widget _buildDetailRow(IconData icon, String label, String value) => Row(
    children: [
      Icon(icon, size: 30, color: Colors.white),
      SizedBox(width: 10),
      Text('$label: $value', style: TextStyle(fontSize: 18, color: Colors.white)),
    ],
  );
}
