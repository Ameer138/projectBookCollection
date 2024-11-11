import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter/services.dart';

class BookCollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Collection',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.cloud_queue), onPressed: () {}),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildBookHeaderImage(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildBookEntry(),
                  Divider(),
                  _buildBookWeather(),
                  Divider(),
                  _buildBookTags(),
                  Divider(),
                  _buildBookFooterImages(context),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated method to add rounded corners and shadow
  Widget _buildBookHeaderImage() {
    return Container(
      margin: EdgeInsets.all(16.0), // Add margin to separate it from other elements
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 10.0, // Spread of the shadow
            offset: Offset(0, 5), // Offset for positioning
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0), // Same radius as the container
        child: Image.asset(
          'assets/images/Book1.jpg', // Replace with your image asset
          fit: BoxFit.cover, // Ensures the image covers the container properly
          width: double.infinity, // Makes the image take the full width of its parent
          height: 200.0, // Set height as needed
        ),
      ),
    );
  }

  Widget _buildBookEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          children: <Widget>[
            Icon(Icons.wb_sunny, color: Colors.orange),
          ],
        ),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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

  Widget _buildBookTags() {
    return Wrap(
      spacing: 8.0,
      children: List.generate(7, (int index) {
        return Chip(
          label: Text(
            'Tag ${index + 1}',
            style: TextStyle(fontSize: 10.0),
          ),
          avatar: Icon(Icons.book, color: Colors.blue.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: Colors.grey),
          ),
          backgroundColor: Colors.grey.shade100,
        );
      }),
    );
  }

  Widget _buildBookFooterImages(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/do.jpeg'), // Replace with book cover image
              radius: 40.0,
            ),
            SizedBox(height: 4.0),
            Text('ListView'),
            ElevatedButton(
              onPressed: () => _navigateToHomeScreen(context, 0), // Pass tab index for ListView
              child: Text('Go to ListView'),
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/gr.png'), // Replace with book cover image
              radius: 40.0,
            ),
            SizedBox(height: 4.0),
            Text('GridView'),
            ElevatedButton(
              onPressed: () => _navigateToHomeScreen(context, 1), // Pass tab index for GridView
              child: Text('Go to GridView'),
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/sc.png'), // Replace with book cover image
              radius: 40.0,
            ),
            SizedBox(height: 4.0),
            Text('ScrollView'),
            ElevatedButton(
              onPressed: () => _navigateToHomeScreen(context, 2), // Pass tab index for Custom ScrollView
              child: Text('Go to ScrollView'),
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
        builder: (context) => HomeScreen(initialTabIndex: tabIndex), // Pass tab index
      ),
    );
  }
}
