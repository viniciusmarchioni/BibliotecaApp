import 'package:flutter/material.dart';

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
          child: InkWell(
            splashColor: Colors.black26,
            onTap: () {},
            child: Ink.image(
              image: const AssetImage('assets/yuri.jpg'),
              child: const Center(
                child: Text(
                  'Yuri Alberto',
                  style: TextStyle(
                      color: Colors.white, backgroundColor: Colors.black),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
