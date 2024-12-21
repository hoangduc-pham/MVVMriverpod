
import 'package:consapppro/config/app_image.dart';
import 'package:consapppro/view/widget/list_app.dart';
import 'package:consapppro/view/widget/list_movie.dart';
import 'package:consapppro/view/widget/list_system.dart';
import 'package:consapppro/view/widget/list_topic.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const ListSystem(),
                  Image.asset(AppImage.homeBackground),
                ],
              ),
            ),
            const ListTopic(),
            const ListApp(),
            const ListMovie(),
          ],
        ),
      ),
    );
  }
}
