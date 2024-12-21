import 'package:consapppro/config/app_color.dart';
import 'package:consapppro/config/app_image.dart';
import 'package:flutter/material.dart';

class ListSystem extends StatefulWidget {
  const ListSystem({super.key});

  @override
  State<ListSystem> createState() => _ListSystemState();
}

class _ListSystemState extends State<ListSystem> {
  final Map<int, bool> _isHover = {};
  final icons = [
            AppImage.user,
            AppImage.bell,
            AppImage.setting,
            AppImage.search,
            AppImage.note,
          ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: List.generate(icons.length, (index) {
          return Column(
            children: [
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHover[index] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHover[index] = false;
                  });
                },
                child: AnimatedScale(
                  scale: (_isHover[index] == true) ? 1.5 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    icons[index],
                    width: 24,
                    height: 24,
                    color: (_isHover[index] == true)
                        ? Colors.white
                        : AppColor.grey,
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          );
        })));
  }
}
