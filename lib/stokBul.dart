import 'dart:convert';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/Product.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';

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
    if (barcodeScanRes != null || barcodeScanRes != "") {
      stokBul(barcodeScanRes);
      FlutterBeep.beep();
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
    stokBul(barcodeScanRes);
  }

  myData<Product> stokBilgileri = myData<Product>();

  Future<myData<Product>> stokBul(String barkod) async {
    var url = Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Products/GetAll?BarkodFilter=$barkod&CategoryIdFilter=0&BrandIdFilter=0&BrandModelIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true');
    http.Response response = await http.get(
      url,
      headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
    );
    print('object');
    print(response.body);

    stokBilgileri = myData<Product>.fromJson(
        json.decode(response.body), Product.fromJsonModel);
    print(stokBilgileri.data?.length);

    setState(() {});
    return stokBilgileri;
  }

  showWidget() {
    if (stokBilgileri != null) {
      print('SDFsdfsdf');

      return StokSonucWidget();
    } else {
      return Center();
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    List<String> liste = ['e', '3'];
    var varyant;
    return Scaffold(
      appBar: AppBar(
          primary: true,
          backgroundColor: myColors.topColor,
          title: Text('Stok Bul')),
      endDrawer: DrawerMenu(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    stokBul("4005900008862");
                  },
                  child: Text('test'),
                ),
                Visibility(
                    visible: stokBilgileri.data?.length == 0 ? false : true,
                    child: Card(
                      child: Column(
                        children: [
                          Text(
                              stokBilgileri.data?[0].productName.toString() == null
                                  ? 'Henüz tarama yapılmadı.'
                                  : stokBilgileri.data![0].productName.toString()),
                          Text(
                              stokBilgileri.data?[0].barkod.toString() == null
                                  ? 'Henüz tarama yapılmadı.'
                                  : stokBilgileri.data![0].barkod.toString()),
                          Text(
                              stokBilgileri.data?[0].sistemSeriNo.toString() == null
                                  ? 'Henüz tarama yapılmadı.'
                                  : stokBilgileri.data![0].sistemSeriNo.toString()),
                          Text(
                              stokBilgileri.data?[0].urunKimlikNo.toString() == null
                                  ? 'Henüz tarama yapılmadı.'
                                  : stokBilgileri.data![0].urunKimlikNo.toString()),


                        ],
                      ),
                    ))
              ],
            ),
            Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // ElevatedButton(
                      //     onPressed: () => scanBarcodeNormal(),
                      //     child: Text('Start barcode scan')),
                      // ElevatedButton(
                      //     onPressed: () => scanQR(),
                      //     child: Text('Start QR scan')),
                      ElevatedButton(
                          onPressed: () => startBarcodeScanStream(),
                          child: Text('Barkodu Tarayın')),
                      Text('Okunan Barkod : $_scanBarcode\n',
                          style: TextStyle(fontSize: 20))
                    ]))
          ],
        ),
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

class StokSonucWidget extends StatefulWidget {
  const StokSonucWidget({Key? key}) : super(key: key);

  @override
  State<StokSonucWidget> createState() => _StokSonucWidgetState();
}

class _StokSonucWidgetState extends State<StokSonucWidget> {
  var title = 'İşlem Taslakları';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();
    setState(() {});
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: Card(
          child: Text('kjdsfl'),
        ));
  }
}
