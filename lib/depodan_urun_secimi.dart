import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/is_baslat.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcess.dart';
import 'package:stok_takip_uygulamasi/model/ProductTransactions.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/urun_ozet.dart';
import 'package:stok_takip_uygulamasi/urun_ozet_depo.dart';
import 'model/BaseCategory.dart';
import 'package:http/http.dart' as http;

class DepodanUrunSecimi extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final myData<BaseCategory>? sonuc;
  final String? kategori;
  final String? urunler;
  final int? islemId;

  const DepodanUrunSecimi(
      {Key? key,
      this.islemTuru,
      this.islemAdi,
      this.islemAciklamasi,
      this.anaDepo,
      this.hedefDepo,
      this.islemTarihi,
      this.sonuc,
      this.kategori,
      this.urunler,
      this.islemId})
      : super(key: key);

  @override
  State<DepodanUrunSecimi> createState() => _DepodanUrunSecimiState();
}

class _DepodanUrunSecimiState extends State<DepodanUrunSecimi> {
  @override
  initState() {
    super.initState();
    setState(() {});
  }

  var tfTif = new TextEditingController();

  late myData<ProductTransactions> depodanProduct =
      myData<ProductTransactions>();

  Future<myData<ProductTransactions>> depodanProductListele() async {
    print(widget.anaDepo);
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductTransactions/GetAll?ProductIdFilter=0&ProductProcessIdFilter=0&DepartmentIdFilter=0&WarehouseIdFilter=${widget.anaDepo}&ParentIdFilter=0&MinMiktarFilter=1&MaksMiktarFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true&CustomStatus=1'));

    print(widget.anaDepo);
    print(
        'https://stok.bahcelievler.bel.tr/api/ProductTransactions/GetAll?ProductIdFilter=0&ProductProcessIdFilter=0&DepartmentIdFilter=0&WarehouseIdFilter=${widget.anaDepo}&ParentIdFilter=0&MinMiktarFilter=1&MaksMiktarFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true');
    print(res.body);
    depodanProduct = myData<ProductTransactions>.fromJson(
        json.decode(res.body), ProductTransactions.fromJsonModel);
    print("prd: ${depodanProduct.data![0].product?.productName.toString()}");
    print(depodanProduct.data![0].product?.productName);

    return depodanProduct;
  }

  var selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color(0xFF976775),
        title: Text('Depodan Ürün Seçimi',
            style: GoogleFonts.raleway(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
      endDrawer: DrawerMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              // TextField(
              //   controller: tfTif,
              //   decoration: InputDecoration(
              //     hintText: widget.sonuc?.data![0].malzemeAdi.toString(),
              //     suffixIcon: IconButton(
              //       onPressed: () {
              //
              //
              //         },
              //       icon: const Icon(Icons.search_sharp),
              //     ),
              //   ),
              // ),

              // FutureBuilder(
              //   builder: (context, snapshot) {
              //
              //     return ListView.builder(
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         return Card(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text('Ürün Adı: ${depodanProduct.data?[0].islemAciklama}'),
              //
              //             ],
              //           ),
              //         );
              //       },
              //       itemCount: depodanProduct.data?.length,
              //     );
              //   },
              //   future: depodanProductListele(),
              // ),

              FutureBuilder<myData<ProductTransactions>>(
                future: depodanProductListele(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var urunlerlistesi = snapshot.data?.data;

                    print(urunlerlistesi![0]);
                    return Container(
                      child: Column(children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: urunlerlistesi.length,
                          itemBuilder: (context, index) {
                            var urun = urunlerlistesi[index];
                            // return CheckboxListTile(
                            //   title: Text(urun.product!.productName),
                            //   subtitle: Text("Miktar: ${urun.miktar.toString()}\nBarkod: ${urun.product?.barkod.toString()}"),
                            //   value: selectedIndexes.contains(index),
                            //   onChanged: (_) {
                            //     if (selectedIndexes.contains(index)) {
                            //       selectedIndexes.remove(index);
                            //       setState(() {
                            //
                            //       });// unselect
                            //     } else {
                            //       selectedIndexes.add(index);
                            //       setState(() {
                            //         print(selectedIndexes.length);
                            //       });//
                            //       // select
                            //     }
                            //   },
                            //   controlAffinity: ListTileControlAffinity.platform,
                            // );

                            return Container(
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    urun.product?.productName.toString() == null
                                        ? ''
                                        : urun.product!.productName,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   urun.product?.productName.toString() == null
                                      //       ? ''
                                      //       : urun.product!.productName,
                                      // ),
                                      Text("Ürün Adedi: ${urun.miktar.toString()}")
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: (){

                                    print(urun.product);
                                    print(urun.product?.barkod);
                                    print(urun.product?.urunKimlikNo);
                                    print(urun.product?.sistemSeriNo);
                                    print(widget.islemTuru);
                                    print(urun.product?.id);
                                    print(widget.islemId);
                                    print(urun.id);
                                    print(urun.productProcess?.productTransactions?[0].id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UrunOzetDepo(parentId: urun.id,islemId: widget.islemId,productId: urun.product?.id,islemTuru: widget.islemTuru,product: urun.product, barkod: urun.product?.barkod, urunKimlikNo: urun.product?.urunKimlikNo, sistemSeriNo: urun.product?.sistemSeriNo,)));
                                    setState(() {

                                    });
                                  },
                                ),
                                // child: SizedBox(
                                //   height: 50,
                                //   child: Container(
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //
                                //       children: [
                                //         Row(
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Padding(
                                //               padding: const EdgeInsets.all(8.0),
                                //               child: Text(
                                //                 urun.product?.productName
                                //                             .toString() ==
                                //                         null
                                //                     ? ''
                                //                     : urun.product!.productName,
                                //               ),
                                //             ),
                                //
                                //
                                //                AnimatedButton(
                                //                  width: 50,
                                //                   height: 30,
                                //                   color:
                                //                       const Color(0XFFAAA3B4),
                                //                   text: 'Seç',
                                //                   pressEvent: () {
                                //                     setState(() {});
                                //                     Navigator.push(
                                //                         context,
                                //                         MaterialPageRoute(
                                //                             builder: (context) => UrunOzet(
                                //                                 islemTuru: widget.islemTuru,
                                //                                 productName: urun.product?.productName,
                                //                                 categoryAdi:  urun.product?.category?.ad,
                                //                                 barkod: urun.product?.barkod,
                                //                                 urunKimlikNo: urun.product?.urunKimlikNo,
                                //                                 sistemSeriNo: urun.product?.sistemSeriNo,
                                //                                 id: urun.product?.id,
                                //
                                //                                 islemId: widget.islemId,
                                //                                 // selectedProduct:selectedProduct
                                //                             )));
                                //                   }),
                                //
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ),
                            );
                          },
                        ),
                      ]),
                    );
                  } else {
                    return Center();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
