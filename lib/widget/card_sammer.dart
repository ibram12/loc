import 'package:flutter/material.dart';

class CardSammer extends StatelessWidget {
const  CardSammer(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image});
final  String image;
final  String title;
final  String subTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  subTitle,
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
