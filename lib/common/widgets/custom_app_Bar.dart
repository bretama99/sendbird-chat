import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final VoidCallback onLeadingBtnPressed;
  final VoidCallback onRearBtnPressed;
  final IconData? iconData;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.onLeadingBtnPressed,
      required this.onRearBtnPressed,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4.0,
      centerTitle: true,
      title: Text(
        title ?? 'Name',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leading: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
        child: FittedBox(
          child: IconButton(
            onPressed: onLeadingBtnPressed,
            icon: Icon(
              iconData,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ),
      actions: [
        Container(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.035),
          child: IconButton(
            onPressed: onRearBtnPressed,
            icon: const Icon(Icons.menu),
          ),
        )
      ],
    );
  }
}
