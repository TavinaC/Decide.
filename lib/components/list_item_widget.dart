import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget{

  const ListItemWidget({super.key, required this.item, required this.animation, required this.onClicked});

  final String item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) => ListTile(
      contentPadding: EdgeInsets.all(padding),
      title: Text(item),
      trailing: GestureDetector(
        onTap: onClicked,
        child: Text("X"),
      ),
  );
}