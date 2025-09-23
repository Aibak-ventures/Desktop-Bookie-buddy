import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: child,
    );
  }
}
