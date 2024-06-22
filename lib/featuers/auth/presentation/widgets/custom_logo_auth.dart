import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key, });
  @override
  Widget build(BuildContext context) {
    return Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(120),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: Image.asset(
                      kLogo,
                      height: 150,
                       fit: BoxFit.fill,
                    ),
                  ),
                ),
              ); 
  }
}
