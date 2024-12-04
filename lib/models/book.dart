class Book {
  final String title;
  final String author;
  final String genre;
  final String id; // Update id to String for Firebase compatibility

  Book({
    required this.title,
    required this.author,
    required this.genre,
    required this.id,
  });

  // Add fromJson for Firebase/Google Books API parsing
  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo']; // Safely handle nested keys
    return Book(
      id: json['id'] ?? '', // Handle missing id gracefully
      title: volumeInfo?['title'] ?? 'No Title',
      author: (volumeInfo?['authors'] ?? ['Unknown Author']).join(', '),
      genre: volumeInfo?['categories']?.join(', ') ?? 'Unknown Genre',
    );
  }

  // Add toMap for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
    };
  }
}

