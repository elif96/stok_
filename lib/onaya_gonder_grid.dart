import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/tif_listesi.dart';

import 'drawer_menu.dart';
import 'model/BaseCategory.dart';

class OnayaGonderGrid extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final myData<Category>? sonuc;
  final String? kategori;
  final String? urunler;

  OnayaGonderGrid(
      {Key? key,   this.islemTuru,
        this.islemAdi,
        this.islemAciklamasi,
        this.anaDepo,
        this.hedefDepo,
        this.islemTarihi,
        this.sonuc,
        this.kategori, this.urunler})
      : super(key: key);

  @override
  State<OnayaGonderGrid> createState() => _OnayaGonderGridState();
}

class _OnayaGonderGridState extends State<OnayaGonderGrid> {
  @override
  initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color(0xFF976775),
        title: Text('SEÇİLEN ÜRÜNLER',
            style: GoogleFonts.notoSansTaiLe(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
      endDrawer: DrawerMenu(),
      body: Container(
        child: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'TİF',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'KATEGORİ',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'ÜRÜN',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('${this.widget.sonuc!.data!}')),
                    DataCell(Text('19')),
                    DataCell(Text('Student')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Janine')),
                    DataCell(Text('43')),
                    DataCell(Text('Professor')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('William')),
                    DataCell(Text('27')),
                    DataCell(Text('Associate Professor')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('William')),
                    DataCell(Text('27')),
                    DataCell(Text('Associate Professor')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('William')),
                    DataCell(Text('27')),
                    DataCell(Text('Associate Professor')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('William')),
                    DataCell(Text('27')),
                    DataCell(Text('Associate Professor')),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0XFF463848),
                      side: const BorderSide(width: 1.0, color: Color(0XFF463848)),
                    ),
                    onPressed: () async {
                      // final Future<SharedPreferences> _prefs =
                      // SharedPreferences.getInstance();
                      //
                      // final SharedPreferences prefs = await _prefs;
                      // prefs.getString('islemAdi');
                      // prefs.getString('islemAciklamasi');
                      // prefs.getString('islemTarihi');
                      // prefs.getInt('islemTuru');
                      // prefs.getInt('anaDepo');
                      // prefs.getInt('hedefDepo');
                      // print('urun grid');
                      // print(prefs.getString('islemAdi'));
                      // print(prefs.getString('islemAciklamasi'));
                      // print(prefs.getString('islemTarihi'));
                      // print(prefs.getInt('islemTuru'));
                      // print(prefs.getInt('anaDepo'));
                      // print(prefs.getInt('hedefDepo'));
                      // print('urun grid');

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  TifListesi(islemTuru: this.widget.islemTuru
                          .toString(),
                          islemAdi: this.widget.islemAdi.toString(),
                          islemAciklamasi: this.widget.islemAciklamasi
                              .toString(),
                          anaDepo: int.parse(
                              this.widget.anaDepo.toString()),
                          hedefDepo: int.parse(
                              this.widget.hedefDepo.toString()),
                          islemTarihi: this.widget.islemTarihi.toString())));
                      setState(() {});
                    },
                    child: const Text("DAHA FAZLA\nÜRÜN EKLE",
                        style: TextStyle(
                            color: Color(0XFFDBDCE8),
                            fontSize: 15,
                            letterSpacing: 2.0)),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0XFF463848),
                    side: const BorderSide(width: 1.0, color: Color(0XFF463848)),
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> OnayaGonderGrid()));
                    setState(() {});
                  },
                  child: const Text("ONAYA GÖNDER",
                      style: TextStyle(
                          color: Color(0XFFDBDCE8),
                          fontSize: 15,
                          letterSpacing: 2.0)),
                )

              ],
            )
          ],
        ),
    ),
      ),
    );
  }
}
