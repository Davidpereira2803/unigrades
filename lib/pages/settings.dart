import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(230, 175, 175, 175),
        primaryColor: const Color.fromARGB(200, 180, 37, 37),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(200, 180, 37, 37)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(200, 180, 37, 37),
          title: const Text('Settings'),
          centerTitle: true,
          leading: IconButton(
                onPressed: (){
                Navigator.pop(context);
                },
                icon: const Icon(Icons.home),
                tooltip: 'Go to Home Page',
          ),
        ),
        body: 
          ColorPickerPage()
        ),
      );
  }
}

class ColorPickerPage extends StatefulWidget {

  ColorPickerPage();

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
  
  void onColorPicked(Color pickedColor) {}
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  late Color _pickedColor;

  @override
  void initState() {
    _pickedColor = Colors.blue; // Initial color
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorPicker(
              pickerColor: _pickedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _pickedColor = color;
                });
              },
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onColorPicked(_pickedColor);
                Navigator.pop(context);
              },
              child: Text('Save Color'),
            ),
          ],
        ),
      ),
    );
  }
}

