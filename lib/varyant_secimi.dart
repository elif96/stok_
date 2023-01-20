import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_uygulamasi/onaya_gonder_grid.dart';

import 'drawer_menu.dart';

class VaryantSecimi extends StatefulWidget {
  final String? variantAdi;
  final List? varyantElemanAdi;
  final String? productName;

  const VaryantSecimi({Key? key, this.variantAdi, this.varyantElemanAdi, this.productName}) : super(key: key);

  @override
  State<VaryantSecimi> createState() => _VaryantSecimiState();
}

class _VaryantSecimiState extends State<VaryantSecimi> {
  @override
  initState() {
    super.initState();
    print("varyantAdi: ${this.widget.variantAdi}");
    print("varyantElemanAdi: ${this.widget.varyantElemanAdi}");
    print("productName: ${this.widget.productName}");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color(0xFF976775),
        title: Text('VARYANT SEÇİMİ',
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OnayaGonderGrid()));
                }, child: Text('Varyant Seç'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
