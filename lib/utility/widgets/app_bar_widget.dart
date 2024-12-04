import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final bool showBackBtn;
  final PreferredSizeWidget? bottom;
  final List<Widget>? action;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.showBackBtn,
    this.action,
    this.bottom
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold,),
      ),
      leading: showBackBtn
          ? GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new,))
          : null,
      actions: action,
      bottom: bottom,
    );
  }
}
