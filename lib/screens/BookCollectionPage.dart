import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter/services.dart';

class BookCollectionPage extends StatefulWidget {
  @override
  _BookCollectionPageState createState() => _BookCollectionPageState();
}

class _BookCollectionPageState extends State<BookCollectionPage> {
  double _scale = 1.0; // Current scale
  double _previousScale = 1.0;
  Offset _offset = Offset.zero; // Current position
  Offset _previousOffset = Offset.zero;

  String _gestureStatus = "Idle"; // Tracks gesture actions

  // Method to scale the image to half of its original size
  void _setScaleSmall() {
    setState(() {
      _scale = 0.5; // Scale to half the original size
      _gestureStatus = "Scaled to Small Size (50%)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Collection',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.cloud_queue), onPressed: () {}),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        children: [
          _buildGestureStatusBar(), // Status bar for gestures
          Expanded(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  /// Gesture Status Bar with InkWell and InkResponse
  Widget _buildGestureStatusBar() {
    return Container(
      color: Colors.blue.shade100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _setScaleSmall(); // Scale to half when tapped
            },
            child: Row(
              children: const [
                Icon(Icons.touch_app, color: Colors.blue),
                SizedBox(width: 5),
                Text(
                  "Tap Here",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          InkResponse(
            onTap: () {
              _setScaleSmall(); // Scale to half when tapped
            },
            child: Row(
              children: const [
                Icon(Icons.gesture, color: Colors.green),
                SizedBox(width: 5),
                Text(
                  "Hover/Tap",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            _gestureStatus,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildInteractiveImage(), // Updated interactive image
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildBookEntry(),
                  const Divider(),
                  _buildBookWeather(),
                  const Divider(),
                  _buildBookFooterImages(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Interactive Image with GestureDetector
  Widget _buildInteractiveImage() {
    return GestureDetector(
      onScaleStart: (details) {
        setState(() {
          _previousScale = _scale;
          _previousOffset = details.focalPoint - _offset;
          _gestureStatus = "Scaling Started";
        });
      },
      onScaleUpdate: (details) {
        setState(() {
          _scale = (_previousScale * details.scale).clamp(0.5, 4.0); // Scaling limit
          _offset = details.focalPoint - _previousOffset; // Update position
          _gestureStatus = "Scaling Updated";
        });
      },
      onDoubleTap: () {
        setState(() {
          _scale = 1.0; // Reset scale
          _offset = Offset.zero; // Reset position
          _gestureStatus = "Double Tap: Reset";
        });
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Transform(
            transform: Matrix4.identity()
              ..translate(_offset.dx, _offset.dy) // Apply offset
              ..scale(_scale), // Apply scale
            child: Image.asset(
              'assets/images/Book1.jpg', // Replace with your image asset
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'My Favorite Books',
          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        Divider(),
        Text(
          'Here are some of my favorite books that I enjoy reading and collecting.',
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildBookWeather() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Icon(Icons.wb_sunny, color: Colors.orange),
          ],
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '81° Clear',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '4500 Saddar Road, Rawalpindi, Pakistan',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildBookFooterImages(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/do.jpeg'),
              radius: 40.0,
            ),
            const SizedBox(height: 4.0),
            const Text('ListView'),
            ElevatedButton(
              onPressed: () => _navigateToHomeScreen(context, 0),
              child: const Text('Go to ListView'),
            ),
          ],
        ),
        Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/gr.png'),
              radius: 40.0,
            ),
            const SizedBox(height: 4.0),
            const Text('GridView'),
            ElevatedButton(
              onPressed: () => _navigateToHomeScreen(context, 1),
              child: const Text('Go to GridView'),
            ),
          ],
        ),
        Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/sc.png'),
              radius: 40.0,
            ),
            const SizedBox(height: 4.0),
            const Text('ScrollView'),
            ElevatedButton(
              onPressed: () => _navigateToHomeScreen(context, 2),
              child: const Text('Go to ScrollView'),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToHomeScreen(BuildContext context, int tabIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(initialTabIndex: tabIndex),
      ),
    );
  }
}
