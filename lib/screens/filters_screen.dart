import 'package:flutter/material.dart';

import '../widget/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({Key key}) : super(key: key);
  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Filters'),
      ),
      drawer: MainDrawer(),
      body: Center(
          child: Text(
        'Filters',
      )),
    );
  }
}
