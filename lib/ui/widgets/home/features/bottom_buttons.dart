import 'package:flutter/material.dart';
class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          alignment: Alignment.center,
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){controller.previousPage(duration: kTabScrollDuration, curve: Curves.ease);}, iconSize: 32, color: Colors.deepPurple, icon: Icon(Icons.arrow_back_ios_new)),
              SizedBox(width: 60,),
              IconButton(onPressed: (){controller.nextPage(duration: kTabScrollDuration, curve: Curves.ease);}, iconSize: 32, color: Colors.deepPurple, icon: Icon(Icons.arrow_forward_ios))

            ],
          )

      ),
    );
  }
}