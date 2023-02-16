import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/model/Product.dart';
import 'package:stok_takip_uygulamasi/model/ProductCategory.dart';
import 'package:stok_takip_uygulamasi/model/ProductVariantElements.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
import 'package:stok_takip_uygulamasi/onayaGonderileceklerListe.dart';
import 'package:stok_takip_uygulamasi/onaya_gonder_grid.dart';
import 'package:http/http.dart' as http;
import 'drawer_menu.dart';

class UrunOzet extends StatefulWidget {
  final List<ProductVariantElements>? productVariantElements;
  final String? productName;
  final String? barkod;
  final String? categoryAdi;
  final int? categorybirim;
  final int? categoryEnvanterTuru;
  final String? urunKimlikNo;
  final String? sistemSeriNo;
  final int? id;
  final String? islemTuru;
  final int? islemId;
  final myData<Product>? selectedProduct;

  const UrunOzet(
      {Key? key,
      this.productName,
      this.productVariantElements,
      this.categoryAdi,
      this.categorybirim,
      this.categoryEnvanterTuru,
      this.barkod,
      this.urunKimlikNo,
      this.sistemSeriNo,
      this.id,
      this.islemTuru,
      this.islemId,
      this.selectedProduct})
      : super(key: key);

  @override
  State<UrunOzet> createState() => _UrunOzetState();
}

var kategoriBirim;

class _UrunOzetState extends State<UrunOzet> {
  var tfMiktar = TextEditingController();

  @override
  initState() {
    super.initState();
    print(widget.selectedProduct?.data![0].category?.ad.toString());
    print("kat bir: ${widget.categorybirim.toString()}");
    print(widget.selectedProduct?.data?.length);
    print(widget.selectedProduct?.data![0].barkod);
    if (widget.categorybirim == 1) {
      print("dsada");
      kategoriBirim == "ADET";
      setState(() {});
    } else if (widget.categorybirim == 2) {
      kategoriBirim == "KİLOGRAM";
    } else if (widget.categorybirim == 3) {
      kategoriBirim == "GRAM";
    }
    // else if(widget.categorybirim == 4){
    //   kategoriBirim == "METRE";
    // }
    else if (widget.categorybirim == 5) {
      kategoriBirim == "LİTRE";
    } // else if(widget.categorybirim == 6){
    //   kategoriBirim == "PAKET";
    // }
    // else if(widget.categorybirim == 7){
    //   kategoriBirim == "Ambalaj";
    // }
    else if (widget.categorybirim == 8) {
      kategoriBirim == "KUTU";
    } else if (widget.categorybirim == 9) {
      kategoriBirim == "METRE";
    } else if (widget.categorybirim == 10) {
      kategoriBirim == "SANTİMETRE";
    } else if (widget.categorybirim == 11) {
      kategoriBirim == "METREKÜP";
    } else if (widget.categorybirim == 12) {
      kategoriBirim == "METREKARE";
    } else if (widget.categorybirim == 13) {
      kategoriBirim == "RULO";
    } else if (widget.categorybirim == 14) {
      kategoriBirim == "SET";
    } // else if(widget.categorybirim == 15){
    //   kategoriBirim == "Litre";
    // }
    else if (widget.categorybirim == 16) {
      kategoriBirim == "CM3";
    }
  }

  Future<void> productTransaction() async {
    var url =
        Uri.parse('https://stok.bahcelievler.bel.tr/api/ProductTransactions');
    print("1 kere çalıştım.");
    print(widget.productVariantElements![0].productId);
    print(widget.selectedProduct?.data![0].id);
    print(widget.islemId);
    print(widget.islemTuru);
    print(tfMiktar.text);
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          // "productId": widget.productVariantElements![0].productId,
          "productId": widget.selectedProduct?.data?[0].id,
          "productProcessId": widget.islemId,
          "islemTuru": widget.islemTuru,
          "miktar": tfMiktar.text,
          "parentId": 0
        }));
    print(response.body);
    if(tfMiktar.text == "" || tfMiktar.text == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lütfen miktar giriniz."),
        backgroundColor: Colors.red,
      ));
    }
    else{
      if(response.body.contains('"errors":null')){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    onayaGonderileceklerListe(
                        islemId: widget.islemId)));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Onaya gönderdiğiniz işlem üzerinde işlem yapamazsınız"),
          backgroundColor: Colors.red,
        ));
      }

    }

  }

  Future<void> sendToAproval() async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: myColors.topColor,
        title: Text('ÜRÜN ÖZETİ',
            style: GoogleFonts.raleway(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
      endDrawer: DrawerMenu(),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kategori: ",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.baslikColor,
                        )),
                    Text(
                        "${widget.selectedProduct?.data![0].category!.ad.toString()}",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.textColor,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ürün: ",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.baslikColor,
                        )),
                    Text(
                        "${widget.selectedProduct?.data![0].productName.toString()}",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.textColor,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Barkod: ",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.baslikColor,
                        )),
                    Text(
                        "${widget.selectedProduct?.data![0].barkod.toString()}",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.textColor,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ürün Kimlik No: ",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.baslikColor,
                        )),
                    Text(
                        "${widget.selectedProduct?.data![0].urunKimlikNo.toString()}",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.textColor,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sistem Seri No: ",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.baslikColor,
                        )),
                    Text(
                        "${widget.selectedProduct?.data![0].sistemSeriNo.toString()}",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.textColor,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Text("Varyanlar:",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: myColors.baslikColor,
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${widget.selectedProduct?.data![0].productVariantElements![index].variantElement.variant.varyantAdi.toString()} - ${widget.selectedProduct?.data![0].productVariantElements![index].variantElement.varyantElemanAdi.toString()}",
                            style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: myColors.textColor,
                            )),
                        // Text(widget.productVariantElements![index].variantElement.varyantElemanAdi.toString()),
                      ],
                    );
                  },
                  itemCount: widget
                      .selectedProduct?.data![0].productVariantElements?.length,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("İşlem Türü: ",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.baslikColor,
                        )),
                    Text("${widget.islemTuru.toString()}",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: myColors.textColor,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Miktar:',
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: myColors.baslikColor,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Color(0XFF976775)),
                              controller: tfMiktar,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: myColors.topColor),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      TextStyle(color: myColors.topColor),
                                  hintText: '**,**',
                                  fillColor: Colors.white70),
                            ),
                          ),
                          SizedBox(width: 25),
                          Text(
                              widget.selectedProduct?.data![0].category!.birim ==
                                      1
                                  ? 'ADET'
                                  : widget.selectedProduct?.data![0].category!
                                              .birim ==
                                          2
                                      ? 'KİLOGRAM'
                                      : widget.selectedProduct?.data![0]
                                                  .category!.birim ==
                                              3
                                          ? 'GRAM'
                                          : widget.categorybirim == 5
                                              ? 'LİTRE'
                                              : widget.selectedProduct?.data![0]
                                                          .category!.birim ==
                                                      8
                                                  ? 'KUTU'
                                                  : widget
                                                              .selectedProduct
                                                              ?.data![0]
                                                              .category!
                                                              .birim ==
                                                          9
                                                      ? 'METRE'
                                                      : widget
                                                                  .selectedProduct
                                                                  ?.data![0]
                                                                  .category!
                                                                  .birim ==
                                                              10
                                                          ? 'SANTİMETRE'
                                                          : widget
                                                                      .selectedProduct
                                                                      ?.data![0]
                                                                      .category!
                                                                      .birim ==
                                                                  11
                                                              ? 'METREKÜP'
                                                              : widget
                                                                          .selectedProduct
                                                                          ?.data![
                                                                              0]
                                                                          .category!
                                                                          .birim ==
                                                                      12
                                                                  ? 'METREKARE'
                                                                  : widget.selectedProduct?.data![0].category!.birim ==
                                                                          13
                                                                      ? 'RULO'
                                                                      : widget.selectedProduct?.data![0].category!.birim ==
                                                                              14
                                                                          ? 'SET'
                                                                          : widget.selectedProduct?.data![0].category!.birim == 16
                                                                              ? 'CM3'
                                                                              : '',
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: myColors.baslikColor,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AnimatedButton(
                          color: myColors.topColor,
                          text: 'İleri',
                          pressEvent: () {
                            // print(widget.selectedProduct?.data![0]
                            //     .productVariantElements![0].productId);
                            productTransaction();
                            print("işlem: ${widget.islemId}");


                            // setState(() {});
                          })
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(50.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height/5,
                //     child: Row(
                //       children: [
                //         Text("Miktar:"),
                //         //virgülden sonra en fazla iki hane
                //         const TextField(
                //           style: TextStyle(color: Color(0XFF976775)),
                //           controller: null,
                //           decoration: InputDecoration(
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(width: 1, color: Color(0XFF976775)),
                //               ),
                //               filled: true,
                //               hintStyle: TextStyle(color: Color(0XFF6E3F52)),
                //               hintText: '*,**',
                //               fillColor: Colors.white70),
                //         ),
                //         Text(widget.categorybirim.toString())
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
