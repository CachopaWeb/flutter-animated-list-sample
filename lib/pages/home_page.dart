import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listKey = GlobalKey<AnimatedListState>();
  final items = <String>['Item 1', 'Item 2', 'Item 3'];

  Widget _builderSlide(context, index, animation) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: _buildItem(index),
    );
  }

  Widget _builderFade(context, index, animation) {
    return FadeTransition(
      opacity: animation.drive(
        Tween<double>(
          begin: 0,
          end: 1,
        ),
      ),
      child: _buildItem(index),
    );
  }

  Widget _buildAnimatedList() {
    return AnimatedList(
      key: _listKey,
      initialItemCount: items.length,
      itemBuilder: _builderSlide,
    );
  }

  Widget _buildItem(int index) {
    return Card(
      elevation: 15,
      child: ListTile(
        title: Text(items[index]),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildItem(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList'),
        centerTitle: true,
      ),
      body: _buildAnimatedList(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              items.add('Item ${items.length + 1}');
              _listKey.currentState!.insertItem(
                items.length - 1,
                duration: const Duration(milliseconds: 500),
              );
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              items.removeLast();
              _listKey.currentState!.removeItem(
                items.length,
                (context, animation) =>
                    _builderFade(context, items.length - 1, animation),
                duration: const Duration(milliseconds: 500),
              );
              setState(() {});
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
