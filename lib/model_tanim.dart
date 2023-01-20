import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/Marka.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/model/myData.dart';

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
  var scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    // markaListele();
    setState(() {});

    // markaListeleWithFilter('', 1, 5, 'Id', true);
    setState(() {});
  }

  var cevap;
  var dropdownvalue;

  myData<Marka> cevaps = myData<Marka>();
  myData<Marka> cevapSon = myData<Marka>();

  Future<myData<Marka>> markaListeleWithFilter(String MarkaAdiFilter, int Page,
      int PageSize, String Orderby, bool Desc) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Brands/GetAll?MarkaAdiFilter=${MarkaAdiFilter}&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}'));
    cevaps = myData<Marka>.fromJson(json.decode(res.body), Marka.fromJsonModel);

    setState(() {});
    // for (int i = 0; i < cevaps.data!.length; i++) {
    //   print(cevaps.data![i].markaAdi);
    //   cevapSon.data?.add(cevaps.data![i]);
    // }

    // print(cevapSon.data?[0].markaAdi);
    print(cevaps.data![0].markaAdi);
    setState(() {});
    return cevaps;
  }

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

  var trimmedValue;

  Future<void> modelEkle() async {
    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/BrandModels');
    // print("ddd: ${dropdownvalue}");
    // print("ddd: ${trimmedValue}");
    if (dropdownvalue == null || dropdownvalue == "") {
      print('object');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen listeden bir varyant seçin."),
        backgroundColor: Colors.red,
      ));
    } else {
      // trimmedValue = ((((dropdownvalue.replaceAll('[', '')).replaceAll(']', ''))
      //             .replaceAll('<', ''))
      //         .replaceAll('>', ''))
      //     .replaceAll("'", '');
    }

    // print("model: ${tfModelAdi.text}");
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert(
            {"brandId": dropdownvalue.value, "modelAdi": tfModelAdi.text}));

    // print(tfModelAdi.text);
    tfModelAdi.text = "";

    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Marka kayıt işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else if (tfModelAdi.text == "" || tfModelAdi.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Model kayıt işlemi gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
    } else if (trimmedValue == null || dropdownvalue == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen listeden bir marka seçin."),
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
    // print(url);

    http.Response response = await http.delete(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'});
    // print(response.statusCode);
    // print(response.body);
    //
    // print(response.reasonPhrase);

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

    // print(response.statusCode);
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
                style: GoogleFonts.notoSansTaiLe(
                  fontSize: 15,
                  color: const Color(0XFF976775),
                )),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: tfMarkaAdi,
              decoration: const InputDecoration(
                hintText: 'Marka Adı',
                hintStyle: TextStyle(color: Color(0XFF976775)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0XFF463848)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            AnimatedButton(
                color: const Color(0XFF463848),
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

  int pageNumber = 1;

  bool isLoadingVertical = false;

  Future loadMore() async {
    setState(() {
      isLoadingVertical = true;
    });
    // await new Future.delayed(const Duration(seconds: 1));

    pageNumber += 1;
    markaListeleWithFilter('', pageNumber, 5, 'Id', true);

    print('UPDATED');
    setState(() {
      isLoadingVertical = false;
    });
  }

  var myController = new TextEditingController();
  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: const Color(0xFF976775),
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
                  ElevatedButton(
                      onPressed: () {
                        markaListeleWithFilter('ve', 1, 5, 'Id', true);
                      },
                      child: Text('dkf')),

                  // DropdownSearch<String>(
                  //
                  //   items: cevaps.data.map((e)=>e['name']).toList(),
                  //   showSearchBox: true,
                  //   label: "Menu mode",
                  //   hint: "country in menu mode",
                  //   onChanged: (value){
                  //     print(value);
                  //   },
                  //   selectedItem: "Canada",
                  // ),

                  // SearchField<Marka>(
                  //
                  //   onSubmit:  (dropdownValue){
                  //     print(dropdownValue);
                  //     markaListeleWithFilter(dropdownValue.toString(), 1, 1000, 'Id', true);
                  //   },
                  //   onSuggestionTap: (x){
                  //     print(x);
                  //     markaListeleWithFilter(x.toString(), 1, 1000, 'Id', true);
                  //   },
                  //     suggestions:cevaps.data == null
                  //     ? []
                  //     : cevaps.data!
                  //     .map(
                  //       (e) =>
                  //       SearchFieldListItem<Marka>(
                  //           e.markaAdi.toString(),
                  //           child: Row(
                  //             mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Text(e.markaAdi.toString(),
                  //                     style: const TextStyle(
                  //                         color: Color(0XFF6E3F52))),
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   GestureDetector(
                  //                     child: const Icon(
                  //                       Icons.border_color_outlined,
                  //                       color: Color(0XFF6E3F52),
                  //                     ),
                  //                     onTap: () {
                  //                       showGuncellemeDialog(e.id!);
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //           key: Key(e.id.toString())),
                  // )
                  //     .toList()
                  // ),

                  // FutureBuilder<myData<Marka>>(
                  //   future: markaListeleWithFilter(TfTest.text, 1, 1000, 'Id', true),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //           TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
                  //           return SearchField<myData<Marka>>(
                  //             autoCorrect: true,
                  //             hint: 'Marka Seçiniz',
                  //             onSuggestionTap: (e) {
                  //               dropdownvalue = e.searchKey;
                  //               setState(() {
                  //                 dropdownvalue = e.key.toString();
                  //               });
                  //             },
                  //             suggestionAction: SuggestionAction.unfocus,
                  //             itemHeight: 50,
                  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
                  //             suggestionStyle:
                  //             const TextStyle(color: Color(0XFF976775)),
                  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  //             suggestions: snapshot.data!.data!
                  //                 .map(
                  //                   (e) => SearchFieldListItem<myData<Marka>>(
                  //
                  //                   e.markaAdi.toString(),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text(e.markaAdi.toString(),
                  //                             style: const TextStyle(
                  //                                 color: Color(0XFF6E3F52))),
                  //                       ),
                  //                       // Row(
                  //                       //   children: [
                  //                       //     GestureDetector(
                  //                       //       child: const Text('Load More'),
                  //                       //
                  //                       //       onTap: () {
                  //                       //         // pageNum +=1;
                  //                       //         print("e: ${e.varyantAdi}");
                  //                       //
                  //                       //
                  //                       //         pageSize += 5;
                  //                       //
                  //                       //         setState(() {});
                  //                       //       },
                  //                       //     ),
                  //                       //     GestureDetector(
                  //                       //       child: const Icon(
                  //                       //         Icons.delete_outline,
                  //                       //         color: Color(0XFF6E3F52),
                  //                       //       ),
                  //                       //       onTap: () {
                  //                       //         varyantElemanSil(e.id!);
                  //                       //       },
                  //                       //     ),
                  //                       //     const SizedBox(
                  //                       //       width: 10,
                  //                       //     ),
                  //                       //     GestureDetector(
                  //                       //       child: const Icon(
                  //                       //         Icons.border_color_outlined,
                  //                       //         color: Color(0XFF6E3F52),
                  //                       //       ),
                  //                       //       onTap: () {
                  //                       //         showGuncellemeDialog(e.id!);
                  //                       //       },
                  //                       //     ),
                  //                       //   ],
                  //                       // ),
                  //                     ],
                  //                   ),
                  //                   key: Key(e.id.toString())),
                  //             )
                  //                 .toList(),
                  //           );
                  //
                  //
                  //
                  //     } else if (!(snapshot.hasError)) {
                  //       return SearchField(
                  //         suggestions: [],
                  //       ).emptyWidget;
                  //     }
                  //     return const CircularProgressIndicator(
                  //       color: Color(0XFF976775),
                  //     );
                  //   },
                  // ),
                  SingleChildScrollView(
                    child: Form(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Single selection dropdown with search option",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            DropDownTextField(
                              searchShowCursor: false,
                              enableSearch: true,
                              searchKeyboardType: TextInputType.number,
                              dropDownList: cevaps.data == null
                                  ? [DropDownValueModel(name: ' ', value: ' ')]
                                  : cevaps.data!
                                  .map(
                                    (e) => DropDownValueModel(
                                    name: e.markaAdi.toString(),
                                    value: e.id
                                    // child: Row(
                                    //   mainAxisAlignment:
                                    //   MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: Text(e.markaAdi.toString(),
                                    //           style: const TextStyle(
                                    //               color: Color(0XFF6E3F52))),
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         GestureDetector(
                                    //           child: const Icon(
                                    //             Icons.border_color_outlined,
                                    //             color: Color(0XFF6E3F52),
                                    //           ),
                                    //           onTap: () {
                                    //             showGuncellemeDialog(e.id!);
                                    //           },
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    // key: Key(e.id.toString())
                                    ),
                              ).toList(),
                              onChanged: (x) {

                                setState(() {
                                  print("dropdownvalue: ${x}");
                                  markaListeleWithFilter(x, 1, 1000, 'Id', true);

                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // CustomSearchableDropDown(
                  //
                  //     onChanged: (x) {
                  //       print("dropdownvalue: ${x}");
                  //       setState(() {
                  //         markaListeleWithFilter(x, 1, 1000, 'Id', true);
                  //
                  //       });
                  //     },
                  //     menuMode: true,
                  //     items: cevaps.data == null
                  //         ? ['']
                  //         : cevaps.data!
                  //             .map(
                  //               (e) => SearchFieldListItem<Marka>(
                  //                   e.markaAdi.toString(),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text(e.markaAdi.toString(),
                  //                             style: const TextStyle(
                  //                                 color: Color(0XFF6E3F52))),
                  //                       ),
                  //                       Row(
                  //                         children: [
                  //                           GestureDetector(
                  //                             child: const Icon(
                  //                               Icons.border_color_outlined,
                  //                               color: Color(0XFF6E3F52),
                  //                             ),
                  //                             onTap: () {
                  //                               showGuncellemeDialog(e.id!);
                  //                             },
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   key: Key(e.id.toString())),
                  //             )
                  //             .toList(),
                  //     label: dropdownValue,
                  //     dropDownMenuItems: cevaps.data == null
                  //         ? ['']
                  //         : cevaps.data!
                  //             .map(
                  //               (e) => SearchFieldListItem<Marka>(
                  //                   e.markaAdi.toString(),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text(e.markaAdi.toString(),
                  //                             style: const TextStyle(
                  //                                 color: Color(0XFF6E3F52))),
                  //                       ),
                  //                       Row(
                  //                         children: [
                  //                           GestureDetector(
                  //                             child: const Icon(
                  //                               Icons.border_color_outlined,
                  //                               color: Color(0XFF6E3F52),
                  //                             ),
                  //                             onTap: () {
                  //                               showGuncellemeDialog(e.id!);
                  //                             },
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   key: Key(e.id.toString())),
                  //             )
                  //             .toList()
                  // ),

                  SearchField<Marka>(
                    autoCorrect: true,
                    hint: 'Marka Seçiniz',
                    onSuggestionTap: (e) {
                      dropdownvalue = e.searchKey;
                      setState(() {
                        dropdownvalue = e.key.toString();
                      });
                    },
                    suggestionAction: SuggestionAction.unfocus,
                    itemHeight: 50,
                    searchStyle: const TextStyle(color: Color(0XFF976775)),
                    onSubmit: (x) {
                      print("dropdownvalue: ${x}");
                      setState(() {
                        markaListeleWithFilter(x, 1, 1000, 'Id', true);

                      });
                    },
                    suggestionStyle: const TextStyle(color: Color(0XFF976775)),
                    // suggestionsDecoration: BoxDecoration(color: Colors.red),
                    suggestions: cevaps.data == null
                        ? []
                        : cevaps.data!
                            .map(
                              (e) => SearchFieldListItem<Marka>(
                                  e.markaAdi.toString(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e.markaAdi.toString(),
                                            style: const TextStyle(
                                                color: Color(0XFF6E3F52))),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            child: const Icon(
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSearchableDropDown(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
                    dropdownHintText: 'Marka Adı ',
                    dropdownItemStyle:
                        const TextStyle(color: Color(0XFF976775)),
                    menuMode: true,
                    labelStyle: const TextStyle(color: Color(0XFF976775)),
                    items: cevaps.data == null
                        ? []
                        : cevaps.data!.map((item) {
                            return DropdownMenuItem(
                              value: item.id.toString(),
                              child: Text(item.markaAdi.toString()),
                            );
                          }).toList(),
                    onChanged: (newVal) {
                      dropdownvalue = newVal;
                    },
                    label: 'Model Seçin',
                    dropDownMenuItems: cevaps.data == null
                        ? []
                        : cevaps.data!.map((item) {
                            // print(item.markaAdi);
                            return item.markaAdi;
                          }).toList(),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: tfModelAdi,
                    style: const TextStyle(color: Color(0XFF976775)),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.model_training,
                          color: Color(0XFF6E3F52),
                        ),
                        hintStyle: TextStyle(color: Color(0XFF976775)),
                        hintText: "Model Adı",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0XFF463848),
                          side: const BorderSide(
                              width: 1.0, color: Color(0XFF463848)),
                        ),
                        onPressed: () {
                          modelEkle();
                        },
                        child: (const Text(
                          'MODEL EKLE',
                          style: TextStyle(
                              color: Color(0XFFDBDCE8),
                              fontSize: 15,
                              letterSpacing: 2.0),
                        ))),
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.model_training,
                            color: Color(0XFF6E3F52)),
                        hintStyle: TextStyle(color: Color(0XFF976775)),
                        hintText: "Model",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                    hint: const Text('Model Seçiniz'),
                    items: cevaps.data == null
                        ? []
                        : cevaps.data!.map((item) {
                            return DropdownMenuItem(
                              value: item.id.toString(),
                              child: Text(item.markaAdi.toString()),
                            );
                          }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        dropdownvalue = newVal;
                      });
                    },
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
