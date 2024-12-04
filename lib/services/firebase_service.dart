import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveBookToFavorites(Book book) async {
    await _firestore.collection('favorites').doc(book.id).set(book.toMap());
  }

  Future<List<Book>> fetchFavoriteBooks() async {
    final snapshot = await _firestore.collection('favorites').get();
    return snapshot.docs.map((doc) {
      return Book.fromJson({...doc.data(), 'id': doc.id});
    }).toList();
  }
}
