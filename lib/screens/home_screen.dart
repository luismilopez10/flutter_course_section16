import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../share_preferences/preferences.dart';
import '../providers/providers.dart';

class HomeScreen extends StatefulWidget {
  static const String routerName = 'Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: Icon(Preferences.isDarkmode
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined),
          onPressed: () {
            Preferences.isDarkmode = !Preferences.isDarkmode;
            final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

            Preferences.isDarkmode
              ? themeProvider.setDarkmode()
              : themeProvider.setLightmode();
            setState(() {});
          },
        ),
      ),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
