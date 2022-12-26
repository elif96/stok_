import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'model/BaseCategory.dart';
import 'package:http/http.dart' as http;

class IslemTanim extends StatefulWidget {
  final String islemTuru;
  final String islemAdi;
  final String islemAciklamasi;
  final String islemTarihi;
  final int anaDepo;
  final int hedefDepo;

  const IslemTanim(
      {Key? key,
      required this.islemTuru,
      required this.islemAdi,
      required this.islemAciklamasi,
      required this.anaDepo,
      required this.hedefDepo,
      required this.islemTarihi})
      : super(key: key);

  @override
  State<IslemTanim> createState() => _IslemTanimState();
}

class _IslemTanimState extends State<IslemTanim> {
  @override
  initState() {
    super.initState();
    baseCategoryListele();

    setState(() {});
  }

  var urun;


  void showIslemBilgileri() {
    AwesomeDialog(
      context: context,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "İşlem Türü: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemTuru}"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "İşlem Adı: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemAdi}"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "İşlem Açıklaması: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemAciklamasi}"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "İşlem Tarihi: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemTarihi}"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Ana Depo:  ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.anaDepo}"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Hedef Depo:  ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.hedefDepo}"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
      dialogType: DialogType.noHeader,
      borderSide: const BorderSide(
        color: Color(0XFF6E3F52),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      showCloseIcon: true,
    ).show();
  }

  void showUrunAra() {
    AwesomeDialog(
      context: context,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Lütfen ürün seçimi yapınız.',
                style: GoogleFonts.notoSansTaiLe(
                  fontSize: 15,
                  color: Color(0XFF976775),
                )),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  showTifListesi();
                },
                child: Text('Tif Listesi')),
            SearchField<String>(
              hint: 'Ürün Seçiniz',

              onSuggestionTap: (e) {
                urun = e.searchKey;

                setState(() {
                  urun = e.key.toString();
                });
              },
              suggestionAction: SuggestionAction.unfocus,
              itemHeight: 50,
              searchStyle: TextStyle(color: Color(0XFF976775)),
              suggestionStyle: TextStyle(color: Color(0XFF976775)),
              // suggestionsDecoration: BoxDecoration(color: Colors.red),
              suggestions: baseCategory
                  .map(
                    (e) => SearchFieldListItem<String>(e.toString(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.hesapKodu.toString(),
                                  style: TextStyle(color: Color(0XFF6E3F52))),
                            ),
                          ],
                        ),
                        key: Key(e.toString())),
                  )
                  .toList(),
            ),
            // DropdownButtonFormField(
            //   decoration: InputDecoration(
            //       hintStyle: TextStyle(color: Color(0XFF976775)),
            //       hintText: "Ürün Seçiniz..",
            //       border: OutlineInputBorder(
            //           borderSide:
            //               BorderSide(color: Color(0XFF6E3F52), width: 3))),
            //   items: list.map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child:
            //           Text(value, style: TextStyle(color: Color(0XFF976775))),
            //     );
            //   }).toList(),
            //   onChanged: (newVal) {
            //     setState(() {
            //       urun = newVal;
            //     });
            //   },
            // ),
            SizedBox(
              height: 40,
            ),
            AnimatedButton(
                color: Color(0XFF463848),
                text: 'Seç',
                pressEvent: () {
                  setState(() {});
                  // print(tfIslemAdi.text);
                  // if (tfIslemAdi.text == "") {
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(
                  //     backgroundColor: Colors.red,
                  //     content: const Text(
                  //         'İşlem adını boş bırakamazsınız.'),
                  //     duration:
                  //     const Duration(seconds: 2),
                  //   ));
                  // } else if (tfIslemAciklamasi.text ==
                  //     "") {
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(
                  //     backgroundColor: Colors.red,
                  //     content: const Text(
                  //         'İşlem açıklamasını boş bırakamazsınız.'),
                  //     duration:
                  //     const Duration(seconds: 2),
                  //   ));
                  // } else if (tfIslemAciklamasi.text ==
                  //     "") {
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(
                  //     backgroundColor: Colors.red,
                  //     content: const Text(
                  //         'İşlem tarihini boş bırakamazsınız.'),
                  //     duration:
                  //     const Duration(seconds: 2),
                  //   ));
                  // } else {
                  //
                  //   String islemAdi = tfIslemAdi.text;
                  //   String islemTarihi = tfIslemTarihi.text;
                  //   String islemAciklamasi = tfIslemAciklamasi.text;
                  //   print("*");
                  //   print(islemAdi);
                  //   print(islemTarihi);
                  //   print("*");
                  //
                  //   tfIslemAdi.clear();
                  //   tfIslemAciklamasi.clear();
                  //   tfIslemTarihi.clear();
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               IslemTurDetay(
                  //                   islemTuru:
                  //                   islemTuru,
                  //                   islemAdi:
                  //                   islemAdi,
                  //                   islemAciklamasi:
                  //                   islemAciklamasi,
                  //                   islemTarihi:
                  //                   islemTarihi)));
                  // }
                })
          ],
        ),
      ),
      dialogType: DialogType.noHeader,
      borderSide: const BorderSide(
        color: Color(0XFF6E3F52),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      showCloseIcon: true,
    ).show();
  }

  void showTifListesi() {
    AwesomeDialog(
      context: context,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          SearchField<String>(
            hint: 'Hesap Kodu Seçiniz',

            onSuggestionTap: (e) {
              urun = e.searchKey;
              setState(() {
                print("urun: ${urun}");
                urun = e.key.toString();
              });
              print(urun);
              print( ((((urun.replaceAll('[', '')).replaceAll(']', ''))
                  .replaceAll('<', ''))
                  .replaceAll('>', ''))
                  .replaceAll("'", ''));
              duzey1Listele(int.parse(((((urun.replaceAll('[', '')).replaceAll(']', ''))
                  .replaceAll('<', ''))
                  .replaceAll('>', ''))
                  .replaceAll("'", '')));
              setState(() {

              });

            },
            suggestionAction: SuggestionAction.unfocus,
            itemHeight: 50,
            searchStyle: TextStyle(color: Color(0XFF976775)),
            suggestionStyle: TextStyle(color: Color(0XFF976775)),
            // suggestionsDecoration: BoxDecoration(color: Colors.red),
            suggestions: baseCategory
                .map(
                  (e) => SearchFieldListItem<String>(e.hesapKodu.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.hesapKodu.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.hesapKodu.toString())),
                )
                .toList(),
          ),
          SizedBox(
            height: 40,
          ),
          SearchField<String>(
            hint: 'Düzey 1 Seçiniz',

            onSuggestionTap: (e) {
              urun = e.searchKey;

              setState(() {
                urun = e.key.toString();
              });
            },
            suggestionAction: SuggestionAction.unfocus,
            itemHeight: 50,
            searchStyle: TextStyle(color: Color(0XFF976775)),
            suggestionStyle: TextStyle(color: Color(0XFF976775)),
            // suggestionsDecoration: BoxDecoration(color: Colors.red),
            suggestions: duzey1
                .map(
                  (e) => SearchFieldListItem<String>(e.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.duzey1.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.toString())),
                )
                .toList(),
          ),
          SizedBox(
            height: 40,
          ),
          SearchField<String>(
            hint: 'Düzey 2 Seçiniz',

            onSuggestionTap: (e) {
              urun = e.searchKey;

              setState(() {
                urun = e.key.toString();
              });
            },
            suggestionAction: SuggestionAction.unfocus,
            itemHeight: 50,
            searchStyle: TextStyle(color: Color(0XFF976775)),
            suggestionStyle: TextStyle(color: Color(0XFF976775)),
            // suggestionsDecoration: BoxDecoration(color: Colors.red),
            suggestions: baseCategory
                .map(
                  (e) => SearchFieldListItem<String>(e.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.hesapKodu.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.toString())),
                )
                .toList(),
          ),
          SizedBox(
            height: 40,
          ),
          SearchField<String>(
            hint: 'Düzey 3 Seçiniz',

            onSuggestionTap: (e) {
              urun = e.searchKey;

              setState(() {
                urun = e.key.toString();
              });
            },
            suggestionAction: SuggestionAction.unfocus,
            itemHeight: 50,
            searchStyle: TextStyle(color: Color(0XFF976775)),
            suggestionStyle: TextStyle(color: Color(0XFF976775)),
            // suggestionsDecoration: BoxDecoration(color: Colors.red),
            suggestions: baseCategory
                .map(
                  (e) => SearchFieldListItem<String>(e.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.hesapKodu.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.toString())),
                )
                .toList(),
          ),
          SizedBox(
            height: 40,
          ),
          SearchField<String>(
            hint: 'Düzey 4 Seçiniz',

            onSuggestionTap: (e) {
              urun = e.searchKey;

              setState(() {
                urun = e.key.toString();
              });
            },
            suggestionAction: SuggestionAction.unfocus,
            itemHeight: 50,
            searchStyle: TextStyle(color: Color(0XFF976775)),
            suggestionStyle: TextStyle(color: Color(0XFF976775)),
            // suggestionsDecoration: BoxDecoration(color: Colors.red),
            suggestions: baseCategory
                .map(
                  (e) => SearchFieldListItem<String>(e.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.hesapKodu.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.toString())),
                )
                .toList(),
          ),
          SizedBox(
            height: 40,
          ),
          SearchField<String>(
            hint: 'Düzey 5 Seçiniz',

            onSuggestionTap: (e) {
              urun = e.searchKey;

              setState(() {
                urun = e.key.toString();
              });
            },
            suggestionAction: SuggestionAction.unfocus,
            itemHeight: 50,
            searchStyle: TextStyle(color: Color(0XFF976775)),
            suggestionStyle: TextStyle(color: Color(0XFF976775)),
            // suggestionsDecoration: BoxDecoration(color: Colors.red),
            suggestions: baseCategory
                .map(
                  (e) => SearchFieldListItem<String>(e.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.hesapKodu.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.toString())),
                )
                .toList(),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color(0XFF463848),
              side: BorderSide(width: 1.0, color: Color(0XFF463848)),
            ),
            onPressed: () {
              setState(() {});
            },
            child: Text("SEÇ",
                style: TextStyle(
                    color: Color(0XFFDBDCE8),
                    fontSize: 15,
                    letterSpacing: 2.0)),
          )
        ]),
      ),
      dialogType: DialogType.noHeader,
      borderSide: const BorderSide(
        color: Color(0XFF6E3F52),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      showCloseIcon: true,
    ).show();
  }

  List<Data> baseCategory = <Data>[];

  Future<List<Data>> baseCategoryListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?Page=1&PageSize=4&Orderby=Id&Desc=false&isDeleted=false'));
    baseCategory = BaseCategory.fromJson(json.decode(res.body)).data.toList();
    print(baseCategory[0].hesapKodu);
    return baseCategory;
  }
  List<Data> duzey1 = <Data>[];

  Future<List<Data>> duzey1Listele(int ParentIdFilter) async {
    print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));
    duzey1 = BaseCategory.fromJson(json.decode(res.body)).data.toList();
    print(duzey1[0].duzey1);
    return duzey1;
  }

  var tfRenk = TextEditingController();
  List<String> myList = [
    'Widget 1',
    'Widget 2',
    'Widget 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Color(0xFF976775),
          title: Text('İŞLEM TANIM',
              style: GoogleFonts.notoSansTaiLe(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              )),
        ),
        endDrawer: DrawerMenu(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'İşlem Bilgilerini Görüntüleyin',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0XFF6E3F52),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showIslemBilgileri();
                            }),
                    ]),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ürün Seçimi Yapmak İçin Arayın',
                    style: TextStyle(
                        color: Color(0XFF976775),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      showUrunAra();
                    },
                    icon: Icon(Icons.search_sharp),
                    color: Color(0XFF976775),
                    iconSize: 24,
                  ),
                ],
              ),
              Divider(
                thickness: 3.0,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0XFFAAA3B4), width: 2.0)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Name',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Age',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Role',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Sarah')),
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
                ),
              ),
              // DataTable(
              //   columns: const <DataColumn>[
              //     DataColumn(
              //       label: Expanded(
              //         child: Text(
              //           'Name',
              //           style: TextStyle(fontStyle: FontStyle.italic),
              //         ),
              //       ),
              //     ),
              //     DataColumn(
              //       label: Expanded(
              //         child: Text(
              //           'Age',
              //           style: TextStyle(fontStyle: FontStyle.italic),
              //         ),
              //       ),
              //     ),
              //     DataColumn(
              //       label: Expanded(
              //         child: Text(
              //           'Role',
              //           style: TextStyle(fontStyle: FontStyle.italic),
              //         ),
              //       ),
              //     ),
              //   ],
              //   rows: const <DataRow>[
              //     DataRow(
              //       cells: <DataCell>[
              //         DataCell(Text('Sarah')),
              //         DataCell(Text('19')),
              //         DataCell(Text('Student')),
              //       ],
              //     ),
              //     DataRow(
              //       cells: <DataCell>[
              //         DataCell(Text('Janine')),
              //         DataCell(Text('43')),
              //         DataCell(Text('Professor')),
              //       ],
              //     ),
              //     DataRow(
              //       cells: <DataCell>[
              //         DataCell(Text('William')),
              //         DataCell(Text('27')),
              //         DataCell(Text('Associate Professor')),
              //       ],
              //     ),
              //   ],
              // ),
              getTextWidgets(myList),
              ElevatedButton(
                onPressed: () {},
                child: Text('Ekle'),
              )
            ],
          ))),
        ));
  }

  Widget getTextWidgets(List<String> strings) {
    List<Widget> list = <Widget>[];
    List<String> liste = ['e', '3'];
    var varyant;
    for (var i = 0; i < strings.length; i++) {
      Text(urun.toString().toString().isEmpty
          ? ''
          : urun.toString().replaceAll(
              RegExp('[^a-zA-Z0-9ğüşöçiİĞÜŞÖÇ]', unicode: true), ''));

      list.add(SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Expanded(
                child: SearchField<String>(
                  hint: '${strings[i]} Seçiniz',

                  onSuggestionTap: (e) {
                    varyant = e.searchKey;

                    setState(() {
                      varyant = e.key.toString();
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
                                      style:
                                          TextStyle(color: Color(0XFF6E3F52))),
                                ),
                              ],
                            ),
                            key: Key(e.toString())),
                      )
                      .toList(),
                ),
              ),
              Expanded(
                child: TextField(
                    decoration: InputDecoration(
                  hintText: strings[i],
                  hintStyle: const TextStyle(color: Color(0XFF976775)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0XFF463848)),
                  ),
                )),
              ),
            ],
          ),
        ),
      ));
    }
    return Column(children: [Column(children: list)]);
  }
}
