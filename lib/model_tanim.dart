import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/Marka.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/model/TextSearchResultItem.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
import 'package:textfield_search/textfield_search.dart';

class ModelTanim extends StatefulWidget {
  const ModelTanim({Key? key}) : super(key: key);

  @override
  State<ModelTanim> createState() => _ModelTanimState();
}

class _ModelTanimState extends State<ModelTanim> {
  var tfMarkaAdi = TextEditingController();
  var marka;
  final _searchController2 = TextEditingController();
  final _modelController = TextEditingController();

  @override
  initState() {
    super.initState();
    setState(() {});
  }
  // myData<Marka> cevaps = myData<Marka>();

  var cevap;

  List<Marka>? cevapData = [];
  myData<Marka> cevapSon = myData<Marka>();
  var modelid;



  Future<List> markaListeleWithFilter(
      int page, int pageSize, String orderby, bool desc) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=${_searchController2.text}&Page=${page}&PageSize=${pageSize}&Orderby=${orderby}&Desc=${desc}'));

    // if (kDebugMode) {
    //   print(cevaps.data?.length);
    // }

    List cevapData2 = <dynamic>[];
    var d = myData<Marka>.fromJson(json.decode(res.body), Marka.fromJsonModel);
    print("cevapData2 ${d.data}");
    if (d.data!.isNotEmpty) {
      var items =
          myData<Marka>.fromJson(json.decode(res.body), Marka.fromJsonModel)
              .data!;

      for (var el in items) {
        var obj2 = TextSearchResultItem.fromJson(
            {"label": el.markaAdi, "value": el.id});
        cevapData2.add(obj2);
        // modelid = el.id;

      }

      return cevapData2;
    }


    return cevapData2;
  }

  // Future<myData<Marka>> markaListeleWithFilter(String MarkaAdiFilter, int Page,
  //     int PageSize, String Orderby, bool Desc) async {
  //   if (kDebugMode) {
  //     print("markaListeleWithFilter $MarkaAdiFilter");
  //   }
  //
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=${MarkaAdiFilter}&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}'));
  //
  //   setState(() {
  //     cevaps =
  //         myData<Marka>.fromJson(json.decode(res.body), Marka.fromJsonModel);
  //     cevapData =
  //         myData<Marka>.fromJson(json.decode(res.body), Marka.fromJsonModel)
  //             .data;
  //   });
  //   if (kDebugMode) {
  //     print(cevaps.data?.length);
  //     print(cevaps.data![0].markaAdi);
  //   }
  //
  //   setState(() {});
  //   return cevaps;
  // }
  // List<Marka> cvp = <Marka>[];
  // Future<Marka> markaListeleWithFilter(String MarkaAdiFilter, int Page,
  //     int PageSize, String Orderby, bool Desc) async {
  //   //https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=a&Page=1&PageSize=12&Orderby=Id&Desc=false
  //
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=${MarkaAdiFilter}&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}'));
  //   cevap = Marka.fromJson(json.decode(res.body));
  //   // print(res.body);
  //   print(cevap.data.length);
  //   // print(cevap.data[0].markaAdi);
  //
  //
  //   return cevap;
  // }

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

  Future<void> modelEkle(int brandId) async {
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/BrandModels');
    if (modelid == null || modelid == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen listeden bir marka seçin."),
        backgroundColor: Colors.red,
      ));
    }

    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder
            .convert({"brandId": modelid, "modelAdi": _modelController.text}));

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Model kayıt işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
      setState(() {});
    } else if (_modelController.text == "" || _modelController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen model adı girin."),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Model kaydı oluşturulamadı."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> markaSil(int markaId) async {
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/Brands/$markaId');
    http.Response response = await http.delete(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'});

    if (response.reasonPhrase == 'Not Found') {
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Silinecek marka bulunamadı."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'Internal Server Error') {
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Silinmek istenen markaya ait modeller tanımlı olduğu için silme işlemi gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } else if (response.reasonPhrase == 'No Content') {
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
    if (response.statusCode <= 299 || response.statusCode >= 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Marka güncelleme işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else if (tfMarkaAdi.text == "" || tfMarkaAdi.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Marka adı boş olamaz."),
        backgroundColor: Colors.red,
      ));
    } else if (markaId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen listeden bir marka seçin."),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
            const SizedBox(
              height: 15,
            ),
            Text('Lütfen güncellemek istediğiniz yeni marka adını girin.',
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  color: myColors.baslikColor,
                )),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: tfMarkaAdi,
              decoration: InputDecoration(
                hintText: 'Marka Adı',
                hintStyle: TextStyle(color: myColors.baslikColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: myColors.baslikColor),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            AnimatedButton(
                color: myColors.baslikColor,
                text: 'Güncelle',
                pressEvent: () {
                  // print(tfMarkaAdi.text);
                  if (tfMarkaAdi.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Marka adını boş bırakamazsınız.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    // print('TTT');
                    // print(trimmedValue);
                    markaGuncelle(trimmedValue);
                    // print(trimmedValue);
                    Navigator.pop(context);
                  }
                })
          ],
        ),
      ),
      dialogType: DialogType.noHeader,
      borderSide: BorderSide(
        color: myColors.baslikColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: myColors.topColor,
            title: const Text('Model Tanım')),
        endDrawer: DrawerMenu(),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Expanded(
                  //   child: LazyLoadScrollView(
                  //     onEndOfPage: () => loadMore(),
                  //     child: SearchField<Marka>(
                  //       autoCorrect: true,
                  //       hint: 'Marka Seçiniz',
                  //       onSuggestionTap: (e) {
                  //         dropdownvalue = e.searchKey;
                  //         setState(() {
                  //           dropdownvalue = e.key.toString();
                  //         });
                  //       },
                  //       suggestionAction: SuggestionAction.unfocus,
                  //       itemHeight: 50,
                  //       searchStyle: TextStyle(color: Color(0XFF976775)),
                  //       suggestionStyle: TextStyle(color: Color(0XFF976775)),
                  //       // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  //       suggestions: cvpSon
                  //           .map(
                  //             (e) => SearchFieldListItem<Marka>(e.markaAdi.toString(),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 GestureDetector(
                  //                   child: Text('Load More'),
                  //                   onTap: () {
                  //                     print(
                  //                         pageNumber * 5 == (cvpSon.length) + 1);
                  //                     print(pageNumber * 5);
                  //                     print(cvpSon.length);
                  //                     // pageNum +=1;
                  //                     // print("e: ${e.markaAdi}");
                  //                     // print('object');
                  //                     // print(cvpSon[0].markaAdi);
                  //
                  //                     pageNumber += 1;
                  //                     markaListeleWithFilter(
                  //                         '', pageNumber, 5, 'Id', true);
                  //                     setState(() {});
                  //                   },
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Text(e.markaAdi.toString(),
                  //                       style:
                  //                       TextStyle(color: Color(0XFF6E3F52))),
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
                  //                         setState(() {});
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
                  //           .toList(),
                  //     ),
                  //   ),
                  // ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       markaListeleWithFilter('ve', 1, 5, 'Id', true);
                  //     },
                  //     child: Text('dkf => ${cevapData?.length}')),

                  TextFieldSearch(
                    label: 'Complex Future List',
                    controller: _searchController2,
                    future: () {
                      return markaListeleWithFilter(1, 1000, 'Id', true);
                    },
                    getSelectedValue: (item) {

                      modelid = item.value;

                      if (kDebugMode) {
                        print("getSelectedValue ${item.value}");
                      }
                      modelid = item.value;
                    },
                    minStringLength: 2,
                    textStyle: TextStyle(color: myColors.baslikColor),
                    decoration: const InputDecoration(hintText: 'Marka Arayın'),

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _modelController,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: myColors.baslikColor,
                          side: BorderSide(
                              width: 1.0, color: myColors.baslikColor),
                        ),
                        onPressed: () {
                          print(modelid);

                          modelEkle(modelid);
                        },
                        child: (const Text(
                          'MODEL EKLE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              letterSpacing: 2.0),
                        ))),
                  ),
                ],
              ),
            )
            // SingleChildScrollView(
            //   child: Form(
            //     child: ListView(
            //       shrinkWrap: true,
            //       children: [
            //
            //         FutureBuilder<Marka>(
            //           future:
            //               markaListeleWithFilter('', pageNum, pageSize, 'Id', true),
            //           builder: (context, snapshot) {
            //             if (snapshot.hasData) {
            //
            //               print("snapshot data length: ${snapshot.data!.data.length}");
            //               for (int i = 0; i < snapshot.data!.data.length; i++) {
            //
            //                 // print("snapshot:${snapshot.data!.data[i].markaAdi}");
            //                 // print("Cevap: ${snapshot.data!.data[i].markaAdi}");
            //                 markalar.add(snapshot.data!.data[i]);
            //                 // print(markalar[i].markaAdi);
            //               }
            //
            //               for (int i = 0; i < markalar.length; i++) {
            //                 print("Marka:${markalar[i].markaAdi}");
            //               }
            //               return ListView.builder(
            //                 controller: _controller,
            //                 shrinkWrap: true,
            //                 itemCount: 1,
            //                 itemBuilder: (context, index) {
            //
            //                   // TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
            //                   return SearchField<Marka>(
            //                     autoCorrect: true,
            //                     hint: 'Marka Seçiniz',
            //                     onSuggestionTap: (e) {
            //                       dropdownvalue = e.searchKey;
            //                       setState(() {
            //                         dropdownvalue = e.key.toString();
            //                       });
            //                     },
            //                     suggestionAction: SuggestionAction.unfocus,
            //                     itemHeight: 50,
            //                     searchStyle: TextStyle(color: Color(0XFF976775)),
            //                     suggestionStyle:
            //                         TextStyle(color: Color(0XFF976775)),
            //                     // suggestionsDecoration: BoxDecoration(color: Colors.red),
            //                     suggestions: markalar
            //                         .map(
            //                           (e) => SearchFieldListItem<Marka>(
            //                               e.markaAdi.toString(),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   GestureDetector(
            //                                     child: Text('Load More'),
            //                                     onTap: () {
            //                                       // pageNum +=1;
            //                                       // print("e: ${e.markaAdi}");
            //
            //                                       pageNum += 1;
            //                                       markalar=[];
            //
            //                                     },
            //                                   ),
            //                                   Padding(
            //                                     padding: const EdgeInsets.all(8.0),
            //                                     child: Text(e.markaAdi.toString(),
            //                                         style: TextStyle(
            //                                             color: Color(0XFF6E3F52))),
            //                                   ),
            //                                   Row(
            //                                     children: [
            //                                       GestureDetector(
            //                                         child: Icon(
            //                                           Icons.delete_outline,
            //                                           color: Color(0XFF6E3F52),
            //                                         ),
            //                                         onTap: () {
            //                                           markaSil(e.id!);
            //                                         },
            //                                       ),
            //                                       SizedBox(
            //                                         width: 10,
            //                                       ),
            //                                       GestureDetector(
            //                                         child: Icon(
            //                                           Icons.border_color_outlined,
            //                                           color: Color(0XFF6E3F52),
            //                                         ),
            //                                         onTap: () {
            //                                           showGuncellemeDialog(e.id!);
            //                                         },
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ],
            //                               ),
            //                               key: Key(e.id.toString())),
            //                         )
            //                         .toList(),
            //                   );
            //
            //                   // SearchField<Marka>(
            //                   //   hint: 'Marka Seçiniz',
            //                   //   onSuggestionTap: (e) {
            //                   //     markaListeleWithFilter(
            //                   //         e.searchKey, 1, 50, e.key.toString(), true);
            //                   //
            //                   //     dropdownvalue = e.searchKey;
            //                   //     // print('object');
            //                   //     // print(e.key);
            //                   //     // print(e.item);
            //                   //     // print(e.child);
            //                   //     // print(e.searchKey);
            //                   //     // print(e.key.toString());
            //                   //
            //                   //     setState(() {
            //                   //       dropdownvalue = e.key.toString();
            //                   //     });
            //                   //   },
            //                   //   suggestionAction: SuggestionAction.unfocus,
            //                   //   itemHeight: 50,
            //                   //   searchStyle: TextStyle(color: Color(0XFF976775)),
            //                   //   suggestionStyle:
            //                   //       TextStyle(color: Color(0XFF976775)),
            //                   //   // suggestionsDecoration: BoxDecoration(color: Colors.red),
            //                   //   suggestions: snapshot.data!.data!
            //                   //       .map(
            //                   //         (e) => SearchFieldListItem<Marka>(
            //                   //             e.markaAdi.toString(),
            //                   //             child: Row(
            //                   //               mainAxisAlignment:
            //                   //                   MainAxisAlignment.spaceBetween,
            //                   //               children: [
            //                   //                 Padding(
            //                   //                   padding: const EdgeInsets.all(8.0),
            //                   //                   child: Text(e.markaAdi.toString(),
            //                   //                       style: TextStyle(
            //                   //                           color: Color(0XFF6E3F52))),
            //                   //                 ),
            //                   //                 Row(
            //                   //                   children: [
            //                   //                     GestureDetector(
            //                   //                       child: Icon(
            //                   //                         Icons.delete_outline,
            //                   //                         color: Color(0XFF6E3F52),
            //                   //                       ),
            //                   //                       onTap: () {
            //                   //                         markaSil(e.id!);
            //                   //                       },
            //                   //                     ),
            //                   //                     SizedBox(
            //                   //                       width: 10,
            //                   //                     ),
            //                   //                     GestureDetector(
            //                   //                       child: Icon(
            //                   //                         Icons.border_color_outlined,
            //                   //                         color: Color(0XFF6E3F52),
            //                   //                       ),
            //                   //                       onTap: () {
            //                   //                         showGuncellemeDialog(e.id!);
            //                   //                       },
            //                   //                     ),
            //                   //                   ],
            //                   //                 ),
            //                   //               ],
            //                   //             ),
            //                   //             key: Key(e.id.toString())),
            //                   //       )
            //                   //       .toList(),
            //                   // );
            //                 },
            //               );
            //             } else if (!(snapshot.hasError)) {
            //               return SearchField(
            //                 suggestions: [],
            //               ).emptyWidget;
            //             }
            //             return const CircularProgressIndicator(
            //               color: Color(0XFF976775),
            //             );
            //           },
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         TextFormField(
            //           controller: tfModelAdi,
            //           style: TextStyle(color: Color(0XFF976775)),
            //           decoration: InputDecoration(
            //               prefixIcon: Icon(
            //                 Icons.model_training,
            //                 color: Color(0XFF6E3F52),
            //               ),
            //               hintStyle: TextStyle(color: Color(0XFF976775)),
            //               hintText: "Model Adı",
            //               border: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Color(0XFF6E3F52)))),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Container(
            //           height: 50,
            //           child: OutlinedButton(
            //               style: OutlinedButton.styleFrom(
            //                 backgroundColor: Color(0XFF463848),
            //                 side: BorderSide(width: 1.0, color: Color(0XFF463848)),
            //               ),
            //               onPressed: () {
            //                 modelEkle();
            //               },
            //               child: (Text(
            //                 'MODEL EKLE',
            //                 style: TextStyle(
            //                     color: Color(0XFFDBDCE8),
            //                     fontSize: 15,
            //                     letterSpacing: 2.0),
            //               ))),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            )

        // SingleChildScrollView(
        //   child: Form(
        //     child: ListView(
        //       shrinkWrap: true,
        //       children: [
        //         FutureBuilder<Marka>(
        //           future:
        //               markaListeleWithFilter('', pageNum, pageSize, 'Id', true),
        //           builder: (context, snapshot) {
        //             if (snapshot.hasData) {
        //
        //               print("snapshot data length: ${snapshot.data!.data.length}");
        //               for (int i = 0; i < snapshot.data!.data.length; i++) {
        //                 print("snapshot:${snapshot.data!.data[i].markaAdi}");
        //                 // print("Cevap: ${snapshot.data!.data[i].markaAdi}");
        //                 markalar.add(cevap.data[i]);
        //                 // print(markalar[i].markaAdi);
        //               }
        //               for (int i = 0; i < markalar.length; i++) {
        //                 print("Marka:${markalar[i].markaAdi}");
        //               }
        //               return ListView.builder(
        //                 controller: _controller,
        //                 shrinkWrap: true,
        //                 itemCount: 1,
        //                 itemBuilder: (context, index) {
        //                   // TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
        //                   return SearchField<Marka>(
        //                     autoCorrect: true,
        //                     hint: 'Marka Seçiniz',
        //                     onSuggestionTap: (e) {
        //                       dropdownvalue = e.searchKey;
        //                       setState(() {
        //                         dropdownvalue = e.key.toString();
        //                       });
        //                     },
        //                     suggestionAction: SuggestionAction.unfocus,
        //                     itemHeight: 50,
        //                     searchStyle: TextStyle(color: Color(0XFF976775)),
        //                     suggestionStyle:
        //                         TextStyle(color: Color(0XFF976775)),
        //                     // suggestionsDecoration: BoxDecoration(color: Colors.red),
        //                     suggestions: markalar
        //                         .map(
        //                           (e) => SearchFieldListItem<Marka>(
        //                               e.markaAdi.toString(),
        //                               child: Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                   GestureDetector(
        //                                     child: Text('Load More'),
        //                                     onTap: () {
        //                                       // pageNum +=1;
        //                                       // print("e: ${e.markaAdi}");
        //
        //                                       pageNum += 1;
        //                                       // pageSize +=5;
        //                                     },
        //                                   ),
        //                                   Padding(
        //                                     padding: const EdgeInsets.all(8.0),
        //                                     child: Text(e.markaAdi.toString(),
        //                                         style: TextStyle(
        //                                             color: Color(0XFF6E3F52))),
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       GestureDetector(
        //                                         child: Icon(
        //                                           Icons.delete_outline,
        //                                           color: Color(0XFF6E3F52),
        //                                         ),
        //                                         onTap: () {
        //                                           markaSil(e.id!);
        //                                         },
        //                                       ),
        //                                       SizedBox(
        //                                         width: 10,
        //                                       ),
        //                                       GestureDetector(
        //                                         child: Icon(
        //                                           Icons.border_color_outlined,
        //                                           color: Color(0XFF6E3F52),
        //                                         ),
        //                                         onTap: () {
        //                                           showGuncellemeDialog(e.id!);
        //                                         },
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ],
        //                               ),
        //                               key: Key(e.id.toString())),
        //                         )
        //                         .toList(),
        //                   );
        //
        //                   // SearchField<Marka>(
        //                   //   hint: 'Marka Seçiniz',
        //                   //   onSuggestionTap: (e) {
        //                   //     markaListeleWithFilter(
        //                   //         e.searchKey, 1, 50, e.key.toString(), true);
        //                   //
        //                   //     dropdownvalue = e.searchKey;
        //                   //     // print('object');
        //                   //     // print(e.key);
        //                   //     // print(e.item);
        //                   //     // print(e.child);
        //                   //     // print(e.searchKey);
        //                   //     // print(e.key.toString());
        //                   //
        //                   //     setState(() {
        //                   //       dropdownvalue = e.key.toString();
        //                   //     });
        //                   //   },
        //                   //   suggestionAction: SuggestionAction.unfocus,
        //                   //   itemHeight: 50,
        //                   //   searchStyle: TextStyle(color: Color(0XFF976775)),
        //                   //   suggestionStyle:
        //                   //       TextStyle(color: Color(0XFF976775)),
        //                   //   // suggestionsDecoration: BoxDecoration(color: Colors.red),
        //                   //   suggestions: snapshot.data!.data!
        //                   //       .map(
        //                   //         (e) => SearchFieldListItem<Marka>(
        //                   //             e.markaAdi.toString(),
        //                   //             child: Row(
        //                   //               mainAxisAlignment:
        //                   //                   MainAxisAlignment.spaceBetween,
        //                   //               children: [
        //                   //                 Padding(
        //                   //                   padding: const EdgeInsets.all(8.0),
        //                   //                   child: Text(e.markaAdi.toString(),
        //                   //                       style: TextStyle(
        //                   //                           color: Color(0XFF6E3F52))),
        //                   //                 ),
        //                   //                 Row(
        //                   //                   children: [
        //                   //                     GestureDetector(
        //                   //                       child: Icon(
        //                   //                         Icons.delete_outline,
        //                   //                         color: Color(0XFF6E3F52),
        //                   //                       ),
        //                   //                       onTap: () {
        //                   //                         markaSil(e.id!);
        //                   //                       },
        //                   //                     ),
        //                   //                     SizedBox(
        //                   //                       width: 10,
        //                   //                     ),
        //                   //                     GestureDetector(
        //                   //                       child: Icon(
        //                   //                         Icons.border_color_outlined,
        //                   //                         color: Color(0XFF6E3F52),
        //                   //                       ),
        //                   //                       onTap: () {
        //                   //                         showGuncellemeDialog(e.id!);
        //                   //                       },
        //                   //                     ),
        //                   //                   ],
        //                   //                 ),
        //                   //               ],
        //                   //             ),
        //                   //             key: Key(e.id.toString())),
        //                   //       )
        //                   //       .toList(),
        //                   // );
        //                 },
        //               );
        //             } else if (!(snapshot.hasError)) {
        //               return SearchField(
        //                 suggestions: [],
        //               ).emptyWidget;
        //             }
        //             return const CircularProgressIndicator(
        //               color: Color(0XFF976775),
        //             );
        //           },
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         TextFormField(
        //           controller: tfModelAdi,
        //           style: TextStyle(color: Color(0XFF976775)),
        //           decoration: InputDecoration(
        //               prefixIcon: Icon(
        //                 Icons.model_training,
        //                 color: Color(0XFF6E3F52),
        //               ),
        //               hintStyle: TextStyle(color: Color(0XFF976775)),
        //               hintText: "Model Adı",
        //               border: OutlineInputBorder(
        //                   borderSide: BorderSide(color: Color(0XFF6E3F52)))),
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Container(
        //           height: 50,
        //           child: OutlinedButton(
        //               style: OutlinedButton.styleFrom(
        //                 backgroundColor: Color(0XFF463848),
        //                 side: BorderSide(width: 1.0, color: Color(0XFF463848)),
        //               ),
        //               onPressed: () {
        //                 modelEkle();
        //               },
        //               child: (Text(
        //                 'MODEL EKLE',
        //                 style: TextStyle(
        //                     color: Color(0XFFDBDCE8),
        //                     fontSize: 15,
        //                     letterSpacing: 2.0),
        //               ))),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

//region GetAllDrafts
class ShowWidget extends StatefulWidget {
  final String islemAdi;

  const ShowWidget({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<ShowWidget> createState() => _ShowWidgetState();
}

class _ShowWidgetState extends State<ShowWidget> {
  var title = 'İşlem Taslakları';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    print('AAAA');
    setState(() {
      title = 'İşlem Taslakları';
      print('İŞlem taslakları çalıştı');
    });
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('M'),
    );
  }
}
//endregion