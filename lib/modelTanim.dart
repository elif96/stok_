import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/model/Marka.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';
import 'package:http/http.dart' as http;

class ModelTanim extends StatefulWidget {
  const ModelTanim({Key? key}) : super(key: key);

  @override
  State<ModelTanim> createState() => _ModelTanimState();
}

class _ModelTanimState extends State<ModelTanim> {
  var tfModelAdi = TextEditingController();
  var tfMarkaAdi = TextEditingController();
  var TfTest = TextEditingController();
  var marka;
  List<Marka> markaListesi = <Marka>[];
  List<Marka> markaObjs = <Marka>[];

  @override
  initState() {
    super.initState();
    // markaListele();
  }

  getMoreData() {
    print("Get more");
  }

  var cevap;
  var dropdownvalue;

  Future<Marka> markaListeleWithFilter(String MarkaAdiFilter, int Page,
      int PageSize, String Orderby, bool Desc) async {
    //https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=a&Page=1&PageSize=12&Orderby=Id&Desc=false

    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=${MarkaAdiFilter}&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}'));
    cevap = Marka.fromJson(json.decode(res.body));
    print(res.body);
    print(cevap.data);
    print(cevap.data[0]);

    print(cevap);
    print(cevap.data[0].markaAdi);

    return cevap;
  }

  // Future<Marka> markaListele() async {
  //   http.Response res = await http
  //       .get(Uri.parse('https://stok.bahcelievler.bel.tr/api/Brands'));
  //   var cevap = Marka.fromJson(json.decode(res.body));
  //   // print(cevap.data[0]);
  //
  //   // print(cevap);
  //   // print(cevap.data[0].markaAdi);
  //
  //   return cevap;
  // }

  var trimmedValue;

  Future<void> modelEkle() async {
    setState(() {});
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/BrandModels');
    print(dropdownvalue);
    trimmedValue = ((((dropdownvalue.replaceAll('[', '')).replaceAll(']', ''))
                .replaceAll('<', ''))
            .replaceAll('>', ''))
        .replaceAll("'", '');
    print("model: ${tfModelAdi.text}");
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder
            .convert({"brandId": trimmedValue, "modelAdi": tfModelAdi.text}));

    // print(tfModelAdi.text);
    tfModelAdi.text = "";

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka kayıt işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else if (tfModelAdi.text == "" || tfModelAdi.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Model kayıt işlemi gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Model kaydı oluşturulamadı."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> markaSil(int markaId) async {
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/Brands/$markaId');
    print(url);

    http.Response response = await http.delete(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'});
    print(response.statusCode);
    print(response.body);

    print(response.reasonPhrase);

    if (response.reasonPhrase == 'Not Found') {
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Silinecek marka bulunamadı."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'Internal Server Error') {
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Silinmek istenen markaya ait modeller tanımlı olduğu için silme işlemi gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'No Content') {
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka silme işlemi başarıyla gerçekleştirildi."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    }
    setState(() {});
  }

  Future<void> markaGuncelle(int markaId) async {
    setState(() {});
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/Brands');

    http.Response response = await http.put(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body:
            json.encoder.convert({"id": markaId, "markaAdi": tfMarkaAdi.text}));
    tfMarkaAdi.text = "";

    print(response.statusCode);
    if (response.statusCode <= 299 || response.statusCode >= 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka güncelleme işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else if (tfMarkaAdi.text == "" || tfMarkaAdi.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka adı boş olamaz."),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka güncellenemedi."),
        backgroundColor: Colors.red,
      ));
    }
  }

  void showGuncellemeDialog(int trimmedValue) {
    AwesomeDialog(
      context: context,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text('Lütfen güncellemek istediğiniz yeni marka adını girin.',
                style: GoogleFonts.notoSansTaiLe(
                  fontSize: 15,
                  color: Color(0XFF976775),
                )),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: tfMarkaAdi,
              decoration: InputDecoration(
                hintText: 'Marka Adı',
                hintStyle: TextStyle(color: Color(0XFF976775)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0XFF463848)),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            AnimatedButton(
                color: Color(0XFF463848),
                text: 'Güncelle',
                pressEvent: () {
                  print(tfMarkaAdi.text);
                  if (tfMarkaAdi.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: const Text('Marka adını boş bırakamazsınız.'),
                      duration: const Duration(seconds: 2),
                    ));
                  } else {
                    print('TTT');
                    print(trimmedValue);
                    markaGuncelle(trimmedValue);
                    print(trimmedValue);
                    Navigator.pop(context);
                  }
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



  int pageNum = 1;
  int pageSize = 5;
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('Model Tanım')),
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
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [

                FutureBuilder<Marka>(
                  future: markaListeleWithFilter('', pageNum, pageSize, 'Id', true),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
                          return SearchField<Marka>(
                            hint: 'Marka Seçiniz',
                            onSuggestionTap: (e) {
                              dropdownvalue = e.searchKey;
                              setState(() {

                                dropdownvalue = e.key.toString();
                              });
                            },
                            suggestionAction: SuggestionAction.unfocus,
                            itemHeight: 50,
                            searchStyle: TextStyle(color: Color(0XFF976775)),
                            suggestionStyle:
                                TextStyle(color: Color(0XFF976775)),
                            // suggestionsDecoration: BoxDecoration(color: Colors.red),
                            suggestions: snapshot.data!.data
                                .map(
                                  (e) => SearchFieldListItem<Marka>(
                                      e.markaAdi.toString(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [

                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Text(e.markaAdi.toString(),
                                                style: TextStyle(
                                                    color:
                                                        Color(0XFF6E3F52))),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(child: Text('Load More'), onTap: (){

                                                // pageNum +=1;
                                                pageSize +=5;
                                                setState(() {

                                                });



                                              },),
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: Color(0XFF6E3F52),
                                                ),
                                                onTap: () {
                                                  markaSil(e.id!);
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.border_color_outlined,
                                                  color: Color(0XFF6E3F52),
                                                ),
                                                onTap: () {
                                                  showGuncellemeDialog(e.id!);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      key: Key(e.id.toString())),

                                )
                                .toList(),

                          );
                          // SearchField<Marka>(
                          //   hint: 'Marka Seçiniz',
                          //   onSuggestionTap: (e) {
                          //     markaListeleWithFilter(
                          //         e.searchKey, 1, 50, e.key.toString(), true);
                          //
                          //     dropdownvalue = e.searchKey;
                          //     // print('object');
                          //     // print(e.key);
                          //     // print(e.item);
                          //     // print(e.child);
                          //     // print(e.searchKey);
                          //     // print(e.key.toString());
                          //
                          //     setState(() {
                          //       dropdownvalue = e.key.toString();
                          //     });
                          //   },
                          //   suggestionAction: SuggestionAction.unfocus,
                          //   itemHeight: 50,
                          //   searchStyle: TextStyle(color: Color(0XFF976775)),
                          //   suggestionStyle:
                          //       TextStyle(color: Color(0XFF976775)),
                          //   // suggestionsDecoration: BoxDecoration(color: Colors.red),
                          //   suggestions: snapshot.data!.data!
                          //       .map(
                          //         (e) => SearchFieldListItem<Marka>(
                          //             e.markaAdi.toString(),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Text(e.markaAdi.toString(),
                          //                       style: TextStyle(
                          //                           color: Color(0XFF6E3F52))),
                          //                 ),
                          //                 Row(
                          //                   children: [
                          //                     GestureDetector(
                          //                       child: Icon(
                          //                         Icons.delete_outline,
                          //                         color: Color(0XFF6E3F52),
                          //                       ),
                          //                       onTap: () {
                          //                         markaSil(e.id!);
                          //                       },
                          //                     ),
                          //                     SizedBox(
                          //                       width: 10,
                          //                     ),
                          //                     GestureDetector(
                          //                       child: Icon(
                          //                         Icons.border_color_outlined,
                          //                         color: Color(0XFF6E3F52),
                          //                       ),
                          //                       onTap: () {
                          //                         showGuncellemeDialog(e.id!);
                          //                       },
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //             key: Key(e.id.toString())),
                          //       )
                          //       .toList(),
                          // );
                        },
                      );
                    }
                    else if (!(snapshot.hasError)) {
                      return SearchField(suggestions: [],).emptyWidget;
                    }
                    return const CircularProgressIndicator(
                      color: Color(0XFF976775),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: tfModelAdi,
                  style: TextStyle(color: Color(0XFF976775)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.model_training,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Model Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0XFF463848),
                        side: BorderSide(width: 1.0, color: Color(0XFF463848)),
                      ),
                      onPressed: () {
                        modelEkle();
                      },
                      child: (Text(
                        'MODEL EKLE',
                        style: TextStyle(
                            color: Color(0XFFDBDCE8),
                            fontSize: 15,
                            letterSpacing: 2.0),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
