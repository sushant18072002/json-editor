import 'package:flutter/material.dart';

class VirtualScroller extends StatelessWidget {
  final List<Widget> children;

  const VirtualScroller({required this.children});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}