import 'package:flutter/material.dart';

class NotificationsTile extends StatelessWidget {
  const NotificationsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(
                radius: 22,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                      'Hello Reuben, your car has been serviced. Please go pick it up. Remember to leave a review')),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
