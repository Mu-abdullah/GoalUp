import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, this.search});
  final String? search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Search Screen')));
  }
}
