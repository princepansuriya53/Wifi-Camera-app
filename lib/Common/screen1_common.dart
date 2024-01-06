import 'package:flutter/material.dart';

class button {
  Widget card({required Images}) {
    return SizedBox(
      height: 80,
      width: 110,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        color: Colors.blue.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(Images)],
        ),
      ),
    );
  }
}
