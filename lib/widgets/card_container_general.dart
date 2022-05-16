import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardContainerGeneral extends StatelessWidget {
  
  const CardContainerGeneral({
    Key? key,
    required this.child, 
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 5),
        width: double.infinity,
        //height: 400,
        decoration: _cardBorders(),
        child: Container(
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              ChangeNotifierProvider(
                create: (_) {},
                child: child,
              ),
            ]
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
        topRight: Radius.circular(40),
        bottomLeft: Radius.circular(40)
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.50),
          offset: const Offset(-10,10),
          blurRadius: 2,
        ),
      ],
    );
  }
}
