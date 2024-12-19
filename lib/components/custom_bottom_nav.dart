import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0;

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFC67C4E),
            Color(0xFFEDAB81),
          ],
          stops: [0.2647, 0.7794],
          transform: GradientRotation(
            260.06 * (3.1415 / 180),
          ),
        ),
      ),
      width: _currentIndex == index ? 10.0 : 0.0,
      height: 5.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xffC67C4E);
    const unSelectedColor = Color(0xff8D8D8D);

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ["home-icon", "heart-icon", "bag-icon", "notification-icon"]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = key;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/$value.svg",
                          colorFilter: ColorFilter.mode(
                            _currentIndex == key
                                ? selectedColor
                                : unSelectedColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        _buildDot(key),
                      ],
                    ),
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }
}
