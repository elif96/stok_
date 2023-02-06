import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/is_baslat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('tr'),
      ],
      title: 'Stok Takip Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white60,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0XFF463848)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0XFF463848)),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
//       theme: FlexThemeData.light(
//         scheme: FlexScheme.brandBlue,
//         surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
//         blendLevel: 20,
//         appBarOpacity: 0.95,
//         subThemesData: const FlexSubThemesData(
//           blendOnLevel: 20,
//           blendOnColors: false,
//         ),
//         visualDensity: FlexColorScheme.comfortablePlatformDensity,
//         useMaterial3: true,
//         // To use the playground font, add GoogleFonts package and uncomment
//         // fontFamily: GoogleFonts.notoSans().fontFamily,
//       ),
//       darkTheme: FlexThemeData.dark(
//         scheme: FlexScheme.brandBlue,
//         surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
//         blendLevel: 15,
//         appBarOpacity: 0.90,
//         subThemesData: const FlexSubThemesData(
//           blendOnLevel: 30,
//         ),
//         visualDensity: FlexColorScheme.comfortablePlatformDensity,
//         useMaterial3: true,
//         // To use the playground font, add GoogleFonts package and uncomment
//         // fontFamily: GoogleFonts.notoSans().fontFamily,
//       ),
// // If you do not have a themeMode switch, uncomment this line
// // to let the device system mode control the theme mode:
// // themeMode: ThemeMode.system,
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future loader() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Container(
                    width: 300,
                    height: 170,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Card(
                          child: Column(children: [
                        Image.asset('assets/logo.jpeg'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('STOK TAKİP UYGULAMASI',
                            style: GoogleFonts.notoSansTaiLe(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF976775),
                              letterSpacing: 2,
                            )),
                      ])),
                    )),
                const SizedBox(height: 50),
                const TextField(
                  style: TextStyle(color: Color(0XFF976775)),
                  controller: null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0XFF976775)),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Color(0XFF6E3F52)),
                      hintText: 'Kullanıcı Adı',
                      fillColor: Colors.white70),
                ),
                const SizedBox(height: 15),
                const TextField(
                  style: TextStyle(color: Color(0XFF976775)),
                  controller: null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0XFF976775)),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Color(0XFF6E3F52)),
                      hintText: 'Şifre',
                      fillColor: Colors.white70),
                ),
                const SizedBox(height: 15),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: AnimatedButton(
                        color: const Color(0XFF6E3F52),
                        text: 'GİRİŞ',
                        pressEvent: () {
                          //kullanıcı kontrolü
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IsBaslat()));
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
