//book_service
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookService {
  final String _baseUrl = "https://www.googleapis.com/books/v1/volumes";
  final String _apiKey = "AIzaSyAgVU4tAcY0Xi1mkU3WgZ6Ahyrzp3QbSw8";

  Future<List<Book>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl?q=$query&key=$_apiKey"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List<dynamic>? ?? [];
      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception("Failed to fetch books");
    }
  }
}
