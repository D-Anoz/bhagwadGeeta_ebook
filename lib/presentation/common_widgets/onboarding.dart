import 'package:ebook/core/constants/images.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomOnboardingWidget extends StatelessWidget {
  final String? image, title, desc;
  const CustomOnboardingWidget({this.image, this.title, this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  radius: 150,
                  backgroundColor: AppColors.outerCircle,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: AppColors.innerCircle,
                  ),
                ),
                Image.asset(
                  image ?? 'No image',
                  height: 300,
                  width: 200,
                ),
                Positioned(
                    right: 2,
                    top: 5,
                    child: Image.asset(
                      Images.largeEllipse,
                      height: 16,
                      width: 16,
                    )),
                Positioned(
                    left: 2,
                    bottom: 5,
                    child: Image.asset(
                      Images.smEllipse,
                      height: 12,
                      width: 12,
                    ))
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              title ?? "Untitled",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.obText),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 168,
              child: Text(
                desc ?? "No description",
                style: const TextStyle(fontSize: 16, color: AppColors.obText),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
