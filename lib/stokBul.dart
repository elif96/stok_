import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'package:stok_takip_uygulamasi/model/Envanter.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class stokBul extends StatefulWidget {
  const stokBul({Key? key}) : super(key: key);

  @override
  State<stokBul> createState() => _stokBulState();
}

class _stokBulState extends State<stokBul> {
  @override
  void initState() {
    super.initState();
  }

  String _scanBarcode = 'Unknown';

  Future<void> startBarcodeScanStream() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> liste = ['e', '3'];
    var varyant;
    return Scaffold(
      appBar: AppBar(
          primary: true,
          backgroundColor: Color(0XFF976775),
          title: Text('Stok Bul')),
      endDrawer: DrawerMenu(),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => startBarcodeScanStream(),
                icon: Icon(Icons.barcode_reader),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchField<String>(
              hint: 'Ürün Ara',

              onSuggestionTap: (e) {
                varyant = e.searchKey;

                setState(() {
                  varyant = e.key.toString();
                  //detay getir apisi çalışacak widget ın içine basacak.
                });
              },
              suggestionAction: SuggestionAction.unfocus,
              itemHeight: 50,
              searchStyle: TextStyle(color: Color(0XFF976775)),
              suggestionStyle: TextStyle(color: Color(0XFF976775)),
              // suggestionsDecoration: BoxDecoration(color: Colors.red),
              suggestions: liste
                  .map(
                    (e) => SearchFieldListItem<String>(e.toString(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.toString(),
                                  style: TextStyle(color: Color(0XFF6E3F52))),
                            ),
                          ],
                        ),
                        key: Key(e.toString())),
                  )
                  .toList(),
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () => scanBarcodeNormal(),
                        child: Text('Start barcode scan')),
                    ElevatedButton(
                        onPressed: () => scanQR(),
                        child: Text('Start QR scan')),
                    ElevatedButton(
                        onPressed: () => startBarcodeScanStream(),
                        child: Text('Start barcode scan stream')),
                    Text('Scan result : $_scanBarcode\n',
                        style: TextStyle(fontSize: 20))
                  ]))
        ],
      ),

      // ListView(
      //   padding: const EdgeInsets.all(8),
      //   children: <Widget>[
      //     Container(
      //       height: 50,
      //       color: Color(0XFFDBDCE8),
      //       child: Row(
      //         children: [
      //           Image.network(
      //               'https://www.bahcelievler.istanbul/style/images/favicon.png'),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(3.0),
      //                 child: Text(
      //                   'Ürün Adı: TV',
      //                   style: TextStyle(
      //                       color: Color(0XFF976775),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(3.0),
      //                 child: Text(
      //                   'Ürün Adedi: 23',
      //                   style: TextStyle(
      //                       color: Color(0XFF976775),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Divider(),
      //     Container(
      //       height: 50,
      //       color: Color(0XFFDBDCE8),
      //       child: Row(
      //         children: [
      //           Image.network(
      //               'https://www.bahcelievler.istanbul/style/images/favicon.png'),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(3.0),
      //                 child: Text(
      //                   'Ürün Adı: TV',
      //                   style: TextStyle(
      //                       color: Color(0XFF976775),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(3.0),
      //                 child: Text(
      //                   'Ürün Adedi: 23',
      //                   style: TextStyle(
      //                       color: Color(0XFF976775),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Divider(),
      //     Container(
      //       height: 50,
      //       color: Color(0XFFDBDCE8),
      //       child: Row(
      //         children: [
      //           Image.network(
      //               'https://www.bahcelievler.istanbul/style/images/favicon.png'),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(3.0),
      //                 child: Text(
      //                   'Ürün Adı: TV',
      //                   style: TextStyle(
      //                       color: Color(0XFF976775),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(3.0),
      //                 child: Text(
      //                   'Ürün Adedi: 23',
      //                   style: TextStyle(
      //                       color: Color(0XFF976775),
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // )
    );
  }
}
