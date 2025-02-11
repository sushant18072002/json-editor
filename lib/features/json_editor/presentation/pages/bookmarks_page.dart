import 'package:flutter/material.dart';

class BookmarksPage extends StatelessWidget {
  static const String route = '/bookmarks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: Center(
        child: Text('Bookmarks Page'),
      ),
    );
  }
}