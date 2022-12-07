import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class IslemTanim extends StatefulWidget {
  final String islemTuru;
  final String islemAdi;
  final String islemAciklamasi;
  final String islemTarihi;

  const IslemTanim(
      {Key? key,
      required this.islemTuru,
      required this.islemAdi,
      required this.islemAciklamasi,
      required this.islemTarihi})
      : super(key: key);

  @override
  State<IslemTanim> createState() => _IslemTanimState();
}

class _IslemTanimState extends State<IslemTanim> {
  var urun;
  List<String> list = <String>[
    'Ürün 1',
    'Ürün 2',
    'Ürün 3',
    'Ürün 4',
    'Ürün 5',
    'Ürün 6',
    'Ürün 7',
    'Ürün 8',
    'Ürün 9',
    'Ürün 10',
    'Ürün 11',
    'Ürün 12',
    'Ürün 1',
    'Ürün 2',
    'Ürün 3',
    'Ürün 4',
    'Ürün 5',
    'Ürün 6',
    'Ürün 7',
    'Ürün 8',
    'Ürün 9',
    'Ürün 10',
    'Ürün 11',
    'Ürün 12',
    'Ürün 13'
  ];

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
              suggestions: list
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
                  setState(() {

                  });
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

  final ScrollController _controllerOne = ScrollController();
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
        endDrawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: const Color(0XFF6E3F52)),
                child: Text(' '),
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'TANIMLAMALAR',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFF976775)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tanimlamalar()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'İŞLEM TASLAKLARI',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFF976775)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IsTaslak()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'ONAY İŞLEMLERİ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFF976775)),
                ),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => IsTaslak()));
                },
              ),
            ],
          ),
        ),
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
    List<String> liste = ['e','3'];
    var varyant;
    for (var i = 0; i < strings.length; i++) {
      Text(urun.toString().toString().isEmpty ? '' : urun.toString().replaceAll(RegExp('[^a-zA-Z0-9ğüşöçiİĞÜŞÖÇ]', unicode: true), ''));

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
                                  style: TextStyle(color: Color(0XFF6E3F52))),
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

 

