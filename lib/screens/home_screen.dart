//home_screen.dart
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../screens/details_screen.dart';
import '../screens/add_edit_screen.dart';
import '../widgets/book_card.dart';

class HomeScreen extends StatefulWidget {
  final int initialTabIndex;

  HomeScreen({this.initialTabIndex = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Book> books = [];

  late AnimationController _firstAnimationController, _secondAnimationController;
  late Animation<double> _firstAnimation, _secondAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _firstAnimationController = _createAnimationController();
    _secondAnimationController = _createAnimationController();

    _firstAnimation = _createAnimation(_firstAnimationController);
    _secondAnimation = _createAnimation(_secondAnimationController);

    _firstAnimationController.forward(); // Start the first animation
  }

  AnimationController _createAnimationController() => AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );

  Animation<double> _createAnimation(AnimationController controller) =>
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      );

  void addBook(Book book) {
    setState(() {
      books.add(book);
      _secondAnimationController.forward(); // Animate second button when a book is added
    });
  }

  @override
  void dispose() {
    _firstAnimationController.dispose();
    _secondAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Tab(icon: Icon(Icons.list), text: "List View"),
      Tab(icon: Icon(Icons.grid_on), text: "Grid View"),
      Tab(icon: Icon(Icons.view_day), text: "Custom Scroll"),
    ];

    List<Widget> tabViews = [
      books.isEmpty ? _buildEmptyState(context) : _buildBookListView(),
      books.isEmpty ? _buildEmptyState(context) : _buildBookGridView(),
      books.isEmpty ? _buildEmptyState(context) : _buildBookCustomScrollView(),
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: 1, // Show only one tab
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Book Collection'),
          backgroundColor: Colors.blueGrey,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [tabs[widget.initialTabIndex]], // Show only the selected tab
          ),
        ),
        body: Stack(
          children: [
            _buildBackgroundImage(), // Add the background image here
            TabBarView(
              children: [tabViews[widget.initialTabIndex]], // Show only the selected tab's content
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/book.png'), // Replace with your image path
        fit: BoxFit.cover,
      ),
    ),
  );

  Widget _buildEmptyState(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildEmptyMessage(),
        SizedBox(height: 5),
        _buildAddBookButton(context, _firstAnimation, 'Add New Book'),
      ],
    ),
  );

  Widget _buildEmptyMessage() => Container(
    padding: EdgeInsets.all(20),
    decoration: _boxDecoration(),
    child: Column(
      children: [
        Icon(Icons.book_outlined, size: 80, color: Colors.black),
        SizedBox(height: 20),
        Text(
          'No books added yet!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ],
    ),
  );

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  );

  Widget _buildBookListView() => Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.all(8.0),
            child: BookCard(
              book: books[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(book: books[index]),
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
          child: _buildAddBookButton(context, _secondAnimation, 'Add Book'),
        ),
      ),
    ],
  );

  Widget _buildBookGridView() => Column(
    children: [
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            childAspectRatio: 3,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.all(1.0),
            child: BookCard(
              book: books[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(book: books[index]),
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Center(
          child: _buildAddBookButton(context, _secondAnimation, 'Add Book'),
        ),
      ),
    ],
  );

  Widget _buildBookCustomScrollView() => CustomScrollView(
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
            margin: EdgeInsets.all(8.0),
            child: BookCard(
              book: books[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(book: books[index]),
                ),
              ),
            ),
          ),
          childCount: books.length,
        ),
      ),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          childAspectRatio: 3,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
            margin: EdgeInsets.all(4.0),
            child: BookCard(
              book: books[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(book: books[index]),
                ),
              ),
            ),
          ),
          childCount: books.length,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Center(
            child: _buildAddBookButton(context, _secondAnimation, 'Add Book'),
          ),
        ),
      ),
    ],
  );

  Widget _buildAddBookButton(
      BuildContext context, Animation<double> animation, String label) =>
      ScaleTransition(
        scale: animation,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditScreen(onSave: addBook),
            ),
          ),
          icon: Icon(Icons.add),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      );
}
