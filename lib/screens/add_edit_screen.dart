import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class AddEditScreen extends StatefulWidget {
  final Function(Book) onSave;
  final Book? existingBook;

  AddEditScreen({required this.onSave, this.existingBook});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> with SingleTickerProviderStateMixin {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  late AnimationController _buttonAnimationController;
  late Animation<double> _scaleAnimation;

  bool _isLoading = false;
  List<Book> _searchResults = [];

  final BookService _bookService = BookService();

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = _createAnimationController();
    _scaleAnimation = CurvedAnimation(parent: _buttonAnimationController, curve: Curves.bounceOut);
    _buttonAnimationController.forward();

    if (widget.existingBook != null) {
      titleController.text = widget.existingBook!.title;
      authorController.text = widget.existingBook!.author;
      genreController.text = widget.existingBook!.genre;
    }
  }

  AnimationController _createAnimationController() => AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void saveBook() async {
    final book = Book(
      id: widget.existingBook?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      author: authorController.text,
      genre: genreController.text,
    );

    // Save to Firestore
    try {
      await FirebaseFirestore.instance.collection('books').doc(book.id).set(book.toMap());
      widget.onSave(book);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving book: $e')),
      );
    }
  }

  Future<void> _searchBooks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _bookService.fetchBooks(searchController.text);
      setState(() {
        _searchResults = books;
      });
    } catch (e) {
      print("Error fetching books: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching books: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: "Search Books",
          labelStyle: const TextStyle(color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _searchBooks,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Book'),
        backgroundColor: Colors.blueGrey,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : _searchResults.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final book = _searchResults[index];
                        return ListTile(
                          title: Text(
                            book.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            book.author,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              titleController.text = book.title;
                              authorController.text = book.author;
                              genreController.text = book.genre;
                            });
                          },
                        );
                      },
                    ),
                  )
                      : const SizedBox(),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Title', controller: titleController, icon: Icons.book),
                  const SizedBox(height: 20),
                  _buildTextField(label: 'Author', controller: authorController, icon: Icons.person),
                  const SizedBox(height: 20),
                  _buildTextField(label: 'Genre', controller: genreController, icon: Icons.category),
                  const SizedBox(height: 20),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: ElevatedButton.icon(
                      onPressed: saveBook,
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text('Save Book', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() => Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/3rd.png'),
        fit: BoxFit.cover,
      ),
    ),
  );
}
