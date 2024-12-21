import 'package:consapppro/config/app_color.dart';
import 'package:flutter/material.dart';

class ListTopic extends StatefulWidget {
  const ListTopic({super.key});

  @override
  State<ListTopic> createState() => _ListTopicState();
}

class _ListTopicState extends State<ListTopic> {
  final ScrollController _scrollController = ScrollController();

     final Map<int, bool> _isHover = {};
  @override
  Widget build(BuildContext context) {
    final titleTopic = [
      "Home Office",
      "Game",
      "Music",
      "Home Hub",
      "Sport",
      "LG Hub"
    ];
    final colorTopic = [
      AppColor.purple,
      AppColor.green,
      AppColor.blue,
      AppColor.orange,
      AppColor.yellow,
      AppColor.yellow2
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, top: 16),
      child: MouseRegion(
        onHover: (event) {
          // Lấy vị trí con trỏ chuột và kích thước của danh sách
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localPosition = box.globalToLocal(event.position);

          // Kiểm tra nếu chuột nằm trong góc phải của danh sách
          if (localPosition.dx >= box.size.width - 50) {
            // Cuộn danh sách sang phải
            _scrollController.animateTo(
              _scrollController.offset + 200, // Cuộn thêm 50 pixels
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          } else if (localPosition.dx <= 50) {
            // Cuộn danh sách sang trái nếu chuột ở góc trái
            _scrollController.animateTo(
              _scrollController.offset - 200, // Cuộn lùi 50 pixels
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          }
        },
        child: SizedBox(
          height: 60,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: titleTopic.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MouseRegion(
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
                  child: Container(
                    width: 190,
                    decoration: BoxDecoration(
                      color: colorTopic[index],
                      border: (_isHover[index] == true) ? Border.all(color: Colors.white, width: 4) : null,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        titleTopic[index],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
