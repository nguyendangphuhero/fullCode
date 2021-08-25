import 'package:flutter/material.dart';

class NoOrderHistoryFoundContent extends StatelessWidget {
  const NoOrderHistoryFoundContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'No orders found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
