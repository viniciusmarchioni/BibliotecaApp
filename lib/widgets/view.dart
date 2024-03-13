import 'package:flutter/material.dart';
import 'package:ripple_image_button/ripple_image_button.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 5,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RippleImageButton(
            onTap: () {
              debugPrint('');
            },
            image: const AssetImage('assets/yuri.jpg'),
          ),
        );
      }),
    );
  }
}
