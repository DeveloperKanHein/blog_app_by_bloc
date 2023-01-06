import 'package:flutter/material.dart';

showLoading({ required BuildContext context })
{
  Widget dia = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    ),
  );

  showDialog(
    // barrierDismissible: false,
      context: context,
      builder: (_) => dia);
}