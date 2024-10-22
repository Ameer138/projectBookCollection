import 'package:flutter/material.dart';
import '../models/book.dart';

class AddEditScreen extends StatefulWidget {
  final Function(Book) onSave;

  AddEditScreen({required this.onSave});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> with SingleTickerProviderStateMixin {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  late AnimationController _buttonAnimationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = _createAnimationController();
    _scaleAnimation = CurvedAnimation(parent: _buttonAnimationController, curve: Curves.bounceOut);
    _buttonAnimationController.forward();
  }

  AnimationController _createAnimationController() => AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void saveBook() {
    final book = Book(
      title: titleController.text,
      author: authorController.text,
      genre: genreController.text,
      id: DateTime.now().millisecondsSinceEpoch,
    );
    widget.onSave(book);
    Navigator.pop(context);
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
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit Book'),
        backgroundColor: Colors.blueGrey,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTextField(label: 'Title', controller: titleController, icon: Icons.book),
                  SizedBox(height: 20),
                  _buildTextField(label: 'Author', controller: authorController, icon: Icons.person),
                  SizedBox(height: 20),
                  _buildTextField(label: 'Genre', controller: genreController, icon: Icons.category),
                  SizedBox(height: 20),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: ElevatedButton.icon(
                      onPressed: saveBook,
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Text('Save Book', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        textStyle: TextStyle(fontSize: 18),
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
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/3rd.png'),
        fit: BoxFit.cover,
      ),
    ),
  );
}
