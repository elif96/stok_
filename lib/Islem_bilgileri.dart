import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/depodan_urun_secimi.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
import 'package:stok_takip_uygulamasi/tif_kategori_urun_secimi.dart';
import 'package:http/http.dart' as http;

class IslemBilgileri extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final int? islemId;

  const IslemBilgileri(
      {Key? key,
      this.islemTuru,
      this.islemAdi,
      this.islemAciklamasi,
      this.anaDepo,
      this.hedefDepo,
      this.islemTarihi,
      this.islemId})
      : super(key: key);

  @override
  State<IslemBilgileri> createState() => _IslemBilgileriState();
}

class _IslemBilgileriState extends State<IslemBilgileri> {
  bool _isButtonDisabled = true;
  var urun;

  @override
  initState() {
    super.initState();
    // baseCategoryListele();
    _isButtonDisabled = true;
    setState(() {});

  }

  //region islemBilgileri
  void showIslemBilgileri() {
    AwesomeDialog(
      context: context,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "İşlem Id: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemId}"),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "İşlem Türü: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemTuru}"),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "İşlem Adı: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemAdi}"),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "İşlem Açıklaması: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemAciklamasi}"),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "İşlem Tarihi: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.islemTarihi}"),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "Ana Depo:  ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${this.widget.anaDepo.toString()} == null ? null : ${this.widget.anaDepo.toString()}"),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "Hedef Depo:  ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" ${this.widget.hedefDepo}"),
            ],
          ),
          const SizedBox(
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

  //endregion
  var tfTifList = TextEditingController();

  //region urunAra
  // void showUrunAra() {
  //   AwesomeDialog(
  //     context: context,
  //     body: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Lütfen ürün seçimi veya barkod ile tarama yapınız.',
  //               style: GoogleFonts.raleway(
  //                 fontSize: 15,
  //                 color: const Color(0XFF976775),
  //               )),
  //           Align(
  //             alignment: Alignment.topRight,
  //             child: Container(
  //                 decoration: BoxDecoration(
  //                   border:
  //                       Border.all(width: 2, color: const Color(0XFF6E3F52)),
  //                   color: const Color(0XFF976775),
  //                   shape: BoxShape.rectangle,
  //                 ),
  //                 child: IconButton(
  //                     icon: const Icon(Icons.barcode_reader),
  //                     color: const Color(0XFF463848),
  //                     onPressed: () {})),
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           TextField(
  //             controller: tfTifList,
  //             onTap: () {
  //               showTifListesi();
  //             },
  //             decoration: InputDecoration(
  //               labelStyle: const TextStyle(color: Color(0XFF976775)),
  //               label: const Text('TİF Listesi'),
  //               prefixIcon: GestureDetector(
  //                   child: const Icon(
  //                 Icons.search_sharp,
  //                 color: Color(0XFF976775),
  //               )),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Kategori Seçiniz',
  //
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //
  //               setState(() {
  //                 urun = e.key.toString();
  //               });
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //             suggestions: baseCategory.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(e.hesapKodu.toString(),
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52))),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.toString())),
  //                 )
  //                 .toList(),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Ürün Seçiniz',
  //
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //
  //               setState(() {
  //                 urun = e.key.toString();
  //               });
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //             suggestions: baseCategory.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(e.hesapKodu.toString(),
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52))),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.toString())),
  //                 )
  //                 .toList(),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           AnimatedButton(
  //               color: const Color(0XFF463848),
  //               text: 'Seç',
  //               pressEvent: () {
  //                 setState(() {});
  //               })
  //         ],
  //       ),
  //     ),
  //     dialogType: DialogType.noHeader,
  //     borderSide: const BorderSide(
  //       color: Color(0XFF6E3F52),
  //       width: 2,
  //     ),
  //     width: MediaQuery.of(context).size.width,
  //     buttonsBorderRadius: const BorderRadius.all(
  //       Radius.circular(2),
  //     ),
  //     dismissOnTouchOutside: true,
  //     dismissOnBackKeyPress: false,
  //     headerAnimationLoop: false,
  //     animType: AnimType.bottomSlide,
  //     showCloseIcon: true,
  //   ).show();
  // }

  //endregion

  //region showTifListesi
  // void showTifListesi() {
  //   AwesomeDialog(
  //     context: context,
  //     body: StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(children: [
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Hesap Kodu Seçiniz',
  //             suggestions: baseCategory.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.hesapKodu.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(e.malzemeAdi.toString(),
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52))),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.id.toString())),
  //                 )
  //                 .toList(),
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //               setState(() {
  //                 // print(e.key);
  //                 // print("urun: ${urun}");
  //                 urun = e.key.toString();
  //               });
  //               // print( ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //               //     .replaceAll('<', ''))
  //               //     .replaceAll('>', ''))
  //               //     .replaceAll("'", ''));
  //               duzey1Listele(int.parse(
  //                   ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //                               .replaceAll('<', ''))
  //                           .replaceAll('>', ''))
  //                       .replaceAll("'", '')));
  //               // hasChild(6);
  //               setState(() {});
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Düzey 1 Seçiniz',
  //             suggestions: duzey1.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.duzey1.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width / 1.5,
  //                             child: Text(e.malzemeAdi.toString(),
  //                                 softWrap: true,
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52), fontSize: 12)),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.id.toString())),
  //                 )
  //                 .toList(),
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //               setState(() {
  //                 // print(e.key);
  //                 // print("urun: ${urun}");
  //                 urun = e.key.toString();
  //               });
  //               // print(urun);
  //               // print(((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //               //             .replaceAll('<', ''))
  //               //         .replaceAll('>', ''))
  //               //     .replaceAll("'", ''));
  //               duzey2Listele(int.parse(
  //                   ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //                               .replaceAll('<', ''))
  //                           .replaceAll('>', ''))
  //                       .replaceAll("'", '')));
  //               setState(() {});
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Düzey 2 Seçiniz',
  //             suggestions: duzey2.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.duzey2.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width / 1.5,
  //                             child: Text(e.malzemeAdi.toString(),
  //                                 softWrap: true,
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.fade,
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52), fontSize: 12)),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.id.toString())),
  //                 )
  //                 .toList(),
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //               setState(() {
  //                 // print(e.key);
  //                 // print("urun: ${urun}");
  //                 urun = e.key.toString();
  //               });
  //               // print(urun);
  //               // print( ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //               //     .replaceAll('<', ''))
  //               //     .replaceAll('>', ''))
  //               //     .replaceAll("'", ''));
  //               duzey3Listele(int.parse(
  //                   ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //                               .replaceAll('<', ''))
  //                           .replaceAll('>', ''))
  //                       .replaceAll("'", '')));
  //               setState(() {});
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Düzey 3 Seçiniz',
  //             suggestions: duzey3.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.duzey3.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width / 1.5,
  //                             child: Text(e.malzemeAdi.toString(),
  //                                 softWrap: true,
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.fade,
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52), fontSize: 12)),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.id.toString())),
  //                 )
  //                 .toList(),
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //               setState(() {
  //                 // print(e.key);
  //                 // print("urun: ${urun}");
  //                 urun = e.key.toString();
  //               });
  //               // print(urun);
  //               // print( ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //               //     .replaceAll('<', ''))
  //               //     .replaceAll('>', ''))
  //               //     .replaceAll("'", ''));
  //               duzey4Listele(int.parse(
  //                   ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //                               .replaceAll('<', ''))
  //                           .replaceAll('>', ''))
  //                       .replaceAll("'", '')));
  //               setState(() {});
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Düzey 4 Seçiniz',
  //             suggestions: duzey4.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.duzey4.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width / 1.5,
  //                             child: Text(e.malzemeAdi.toString(),
  //                                 softWrap: true,
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.fade,
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52), fontSize: 12)),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.id.toString())),
  //                 )
  //                 .toList(),
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //               setState(() {
  //                 // print(e.key);
  //                 // print("urun: ${urun}");
  //                 urun = e.key.toString();
  //               });
  //               duzey5Listele(int.parse(
  //                   ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //                               .replaceAll('<', ''))
  //                           .replaceAll('>', ''))
  //                       .replaceAll("'", '')));
  //               setState(() {});
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           SearchField<String>(
  //             hint: 'Düzey 5 Seçiniz',
  //             suggestions: duzey5.data!
  //                 .map(
  //                   (e) => SearchFieldListItem<String>(e.duzey5.toString(),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width / 1.5,
  //                             child: Text(e.malzemeAdi.toString(),
  //                                 softWrap: true,
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.fade,
  //                                 style: const TextStyle(
  //                                     color: Color(0XFF6E3F52), fontSize: 12)),
  //                           ),
  //                         ],
  //                       ),
  //                       key: Key(e.id.toString())),
  //                 )
  //                 .toList(),
  //             onSuggestionTap: (e) {
  //               urun = e.searchKey;
  //               setState(() {
  //                 // print(e.key);
  //                 // print("urun: ${urun}");
  //                 urun = e.key.toString();
  //               });
  //               // print(urun);
  //               // print( ((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //               //     .replaceAll('<', ''))
  //               //     .replaceAll('>', ''))
  //               //     .replaceAll("'", ''));
  //               // duzey5Listele(int.parse(((((urun.replaceAll('[', '')).replaceAll(']', ''))
  //               //     .replaceAll('<', ''))
  //               //     .replaceAll('>', ''))
  //               //     .replaceAll("'", '')));
  //                setState(() {});
  //             },
  //             suggestionAction: SuggestionAction.unfocus,
  //             itemHeight: 50,
  //             searchStyle: const TextStyle(color: Color(0XFF976775)),
  //             suggestionStyle: const TextStyle(color: Color(0XFF976775)),
  //             // suggestionsDecoration: BoxDecoration(color: Colors.red),
  //           ),
  //           OutlinedButton(
  //             style: OutlinedButton.styleFrom(
  //               backgroundColor: const Color(0XFF463848),
  //               side: const BorderSide(width: 1.0, color: Color(0XFF463848)),
  //             ),
  //             onPressed: () {
  //               setState(() {});
  //             },
  //             child: Text(_isButtonDisabled ? "Hold on..." : "SEÇ",
  //                 style: const TextStyle(
  //                     color: Color(0XFFDBDCE8),
  //                     fontSize: 15,
  //                     letterSpacing: 2.0)),
  //           )
  //         ]),
  //       );
  //     }),
  //     dialogType: DialogType.noHeader,
  //     borderSide: const BorderSide(
  //       color: Color(0XFF6E3F52),
  //       width: 2,
  //     ),
  //     width: MediaQuery.of(context).size.width,
  //     buttonsBorderRadius: const BorderRadius.all(
  //       Radius.circular(2),
  //     ),
  //     dismissOnTouchOutside: true,
  //     dismissOnBackKeyPress: false,
  //     headerAnimationLoop: false,
  //     animType: AnimType.bottomSlide,
  //     showCloseIcon: true,
  //   ).show();
  // }

  //endregion

  //region hasChild
  // List<BaseCategoryParentChildData> _hasChild = <BaseCategoryParentChildData>[];
  //
  // Future<List<BaseCategoryParentChildData>> hasChild(int ParentIdFilter) async {
  //   // print("parent id:${ParentIdFilter}");
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetSingleBaseCategoryByIdWithParentAndChildren/${ParentIdFilter}'));
  //   // print(res.body);
  //   _hasChild =
  //       BaseCategoryParentChild.fromJson(json.decode(res.body)).data.toList();
  //   // print(_hasChild[0].malzemeAdi);
  //
  //   // print(_hasChild);
  //   if (_hasChild.isEmpty) {
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  //
  //   // print('duzey 0: ${duzey1[0].id}');
  //
  //   setState(() {});
  //   return _hasChild;
  // }

  //endregion

  //region baseCategory
  // myData<BaseCategory> baseCategory = myData<BaseCategory>();
  //
  // Future<myData<BaseCategory>> baseCategoryListele() async {
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?Page=1&PageSize=4&Orderby=Id&Desc=false&isDeleted=false'));
  //   baseCategory = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);
  //
  //   tfTifList.text = baseCategory.data![baseCategory.data!.length- 1].malzemeAdi!;
  //   if (baseCategory.data?.length == 0) {
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  //
  //   return baseCategory;
  // }
  //
  // //endregion
  //
  // //region duzey1
  // late myData<BaseCategory> duzey1;
  //
  // Future<myData<BaseCategory>> duzey1Listele(int ParentIdFilter) async {
  //   // print("parent id:${ParentIdFilter}");
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));
  //   // print(res.body);
  //   duzey1 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);
  //   // print("1 Malzeme: ${duzey1[duzey1.length - 1].malzemeAdi}");
  //   tfTifList.text = duzey1.data![duzey1.data!.length - 1].malzemeAdi!;
  //
  //   if (duzey1.data?.length == 0) {
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  //
  //   setState(() {});
  //   return duzey1;
  // }
  //
  // //endregion
  //
  // //region duzey2
  // late myData<BaseCategory> duzey2;
  //
  // Future<myData<BaseCategory>> duzey2Listele(int ParentIdFilter) async {
  //   setState(() {});
  //   // print("parent id:${ParentIdFilter}");
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));
  //   // print(res.body);
  //   duzey2 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);
  //   // print('duzey 0: ${duzey2[0].id}');
  //   // print("2 Malzeme: ${duzey2[duzey2.length - 1].malzemeAdi}");
  //   tfTifList.text = duzey2.data![duzey2.data!.length - 1].malzemeAdi!;
  //   if (duzey2.data?.length == 0) {
  //     // print('2boş');
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     // print('2boş değil');
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  //
  //   setState(() {});
  //   return duzey2;
  // }
  //
  // //endregion
  //
  // //region duzey3
  // late myData<BaseCategory> duzey3;
  //
  // Future<myData<BaseCategory>> duzey3Listele(int ParentIdFilter) async {
  //   setState(() {});
  //   // print("parent id:${ParentIdFilter}");
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));
  //   // print(res.body);
  //   duzey3 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);
  //   // print('duzey 0: ${duzey3[0].id}');
  //   // print("3 Malzeme: ${duzey3[duzey3.length - 1].malzemeAdi}");
  //   tfTifList.text = duzey3.data![duzey3.data!.length - 1].malzemeAdi!;
  //   if (duzey3.data?.length == 0) {
  //     // print('3boş');
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     // print('3boş değil');
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  //
  //   setState(() {});
  //   return duzey3;
  // }
  //
  // //endregion
  //
  // //region duzey4
  // late myData<BaseCategory> duzey4;
  //
  // Future<myData<BaseCategory>> duzey4Listele(int ParentIdFilter) async {
  //   setState(() {});
  //   // print("parent id:${ParentIdFilter}");
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));
  //   // print(res.body);
  //   duzey4 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);
  //   // print('duzey 0: ${duzey4[0].id}');
  //   // print("4 Malzeme: ${duzey4[duzey4.length - 1].malzemeAdi}");
  //   tfTifList.text = duzey4.data![duzey4.data!.length - 1].malzemeAdi!;
  //   if (duzey4.data?.length == 0) {
  //     // print('4boş');
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     // print('4boş değil');
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  //
  //   setState(() {});
  //   return duzey4;
  // }
  //
  // //endregion
  //
  // //region duzey5
  // late myData<BaseCategory> duzey5;
  //
  // Future<myData<BaseCategory>> duzey5Listele(int ParentIdFilter) async {
  //   setState(() {});
  //   // print("parent id:${ParentIdFilter}");
  //   http.Response res = await http.get(Uri.parse(
  //       'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));
  //   // print(res.body);
  //   duzey5 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);
  //   // print('duzey 0: ${duzey5[0].id}');
  //   // print("5 Malzeme: ${duzey5[duzey5.length - 1].malzemeAdi}");
  //   tfTifList.text = duzey5.data![duzey5.data!.length - 1].malzemeAdi!;
  //   if (duzey5.data?.length == 0) {
  //     // print('5boş');
  //     setState(() {
  //       _isButtonDisabled = false;
  //     });
  //   } else {
  //     // print('5boş değil');
  //     setState(() {
  //       _isButtonDisabled = true;
  //     });
  //   }
  //
  //   setState(() {});
  //   return duzey5;
  // }
  //
  // endregion

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
          backgroundColor: myColors.topColor,
          title: Text('İŞLEM BİLGİLERİ',
              style: GoogleFonts.raleway(
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
                  // RichText(
                  //   text: TextSpan(children: [
                  //     TextSpan(
                  //         text: 'İşlem Bilgilerini Görüntüleyin',
                  //         style: const TextStyle(
                  //             decoration: TextDecoration.underline,
                  //             color: Color(0XFF6E3F52),
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20),
                  //         recognizer: TapGestureRecognizer()
                  //           ..onTap = () {
                  //             showIslemBilgileri();
                  //           }),
                  //   ]),
                  // ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "İşlem Id: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" ${this.widget.islemId}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "İşlem Türü: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" ${this.widget.islemTuru}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "İşlem Adı: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" ${this.widget.islemAdi}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "İşlem Açıklaması: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" ${this.widget.islemAciklamasi}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "İşlem Tarihi: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" ${this.widget.islemTarihi}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Ana Depo:  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" ${this.widget.anaDepo}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Hedef Depo:  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" ${this.widget.hedefDepo}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ürün Seçimi Yapmak İçin Arayın',
                    style: TextStyle(
                        color: myColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () async {
                      // final Future<SharedPreferences> _prefs =
                      //     SharedPreferences.getInstance();
                      //
                      // final SharedPreferences prefs = await _prefs;
                      // prefs.getString('islemAdi');
                      // prefs.getString('islemAciklamasi');
                      // prefs.getString('islemTarihi');
                      // prefs.getInt('islemTuru');
                      // prefs.getInt('anaDepo');
                      // prefs.getInt('hedefDepo');
                      // print('islem tanim');
                      // print(prefs.getString('islemAdi'));
                      // print(prefs.getString('islemAciklamasi'));
                      // print(prefs.getString('islemTarihi'));
                      // print(prefs.getInt('islemTuru'));
                      // print(prefs.getInt('anaDepo'));
                      // print(prefs.getInt('hedefDepo'));
                      // print('islem tanim');
                      print(widget.islemId);
                      if(widget.islemTuru == "5" || widget.islemTuru == "6" || widget.islemTuru == "7" || widget.islemTuru == "8"){
                       print(widget.islemTuru);
                       print(widget.islemAdi);
                       print(widget.islemAciklamasi);
                       print(widget.anaDepo);
                       print(widget.hedefDepo);
                       print(widget.islemTarihi);
                       print(widget.islemId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepodanUrunSecimi(
                                    islemTuru: this.widget.islemTuru.toString(),
                                    islemAdi: this.widget.islemAdi.toString(),
                                    islemAciklamasi:
                                    this.widget.islemAciklamasi.toString(),
                                    anaDepo: int.parse(
                                        this.widget.anaDepo.toString()),
                                    hedefDepo: int.parse(
                                        this.widget.hedefDepo.toString()),
                                    islemTarihi:
                                    this.widget.islemTarihi.toString(),
                                    islemId: this.widget.islemId
                                )));
                      }
                      else{

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TifKategoriUrunSecimi(
                                    islemTuru: this.widget.islemTuru.toString(),
                                    islemAdi: this.widget.islemAdi.toString(),
                                    islemAciklamasi:
                                    this.widget.islemAciklamasi.toString(),
                                    anaDepo: int.parse(
                                        this.widget.anaDepo.toString()) == null ? 0 : int.parse(
                                        this.widget.anaDepo.toString()),
                                    hedefDepo: int.parse(
                                        this.widget.hedefDepo.toString()),
                                    islemTarihi:
                                    this.widget.islemTarihi.toString(),
                                    islemId: this.widget.islemId
                                )));
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Test(islemTuru: this.widget.islemTuru.toString(), islemAdi: this.widget.islemAdi.toString(), islemAciklamasi: this.widget.islemAciklamasi.toString(), anaDepo: int.parse(this.widget.anaDepo.toString()), hedefDepo: int.parse(this.widget.hedefDepo.toString()), islemTarihi: this.widget.islemTarihi.toString())));
                      //   showUrunAra();
                    },
                    icon: Icon(Icons.search_sharp, color: myColors.textColor),
                    color: const Color(0XFF976775),
                    iconSize: 24,
                  ),
                ],
              ),

              // Container(
              //   decoration: BoxDecoration(
              //       border:
              //           Border.all(color: const Color(0XFFAAA3B4), width: 2.0)),
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height / 4,
              //   child: SingleChildScrollView(
              //     child: DataTable(
              //       columns: const <DataColumn>[
              //         DataColumn(
              //           label: Expanded(
              //             child: Text(
              //               'Name',
              //               style: TextStyle(fontStyle: FontStyle.italic),
              //             ),
              //           ),
              //         ),
              //         DataColumn(
              //           label: Expanded(
              //             child: Text(
              //               'Age',
              //               style: TextStyle(fontStyle: FontStyle.italic),
              //             ),
              //           ),
              //         ),
              //         DataColumn(
              //           label: Expanded(
              //             child: Text(
              //               'Role',
              //               style: TextStyle(fontStyle: FontStyle.italic),
              //             ),
              //           ),
              //         ),
              //       ],
              //       rows: const <DataRow>[
              //         DataRow(
              //           cells: <DataCell>[
              //             DataCell(Text('Sarah')),
              //             DataCell(Text('19')),
              //             DataCell(Text('Student')),
              //           ],
              //         ),
              //         DataRow(
              //           cells: <DataCell>[
              //             DataCell(Text('Janine')),
              //             DataCell(Text('43')),
              //             DataCell(Text('Professor')),
              //           ],
              //         ),
              //         DataRow(
              //           cells: <DataCell>[
              //             DataCell(Text('William')),
              //             DataCell(Text('27')),
              //             DataCell(Text('Associate Professor')),
              //           ],
              //         ),
              //         DataRow(
              //           cells: <DataCell>[
              //             DataCell(Text('William')),
              //             DataCell(Text('27')),
              //             DataCell(Text('Associate Professor')),
              //           ],
              //         ),
              //         DataRow(
              //           cells: <DataCell>[
              //             DataCell(Text('William')),
              //             DataCell(Text('27')),
              //             DataCell(Text('Associate Professor')),
              //           ],
              //         ),
              //         DataRow(
              //           cells: <DataCell>[
              //             DataCell(Text('William')),
              //             DataCell(Text('27')),
              //             DataCell(Text('Associate Professor')),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // getTextWidgets(myList),
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
                  searchStyle: const TextStyle(color: Color(0XFF976775)),
                  suggestionStyle: const TextStyle(color: Color(0XFF976775)),
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
                                      style: const TextStyle(
                                          color: Color(0XFF6E3F52))),
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
