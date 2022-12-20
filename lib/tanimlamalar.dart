import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/kategoriTanim.dart';
import 'package:stok_takip_uygulamasi/markaTanim.dart';
import 'package:stok_takip_uygulamasi/modelTanim.dart';
import 'package:stok_takip_uygulamasi/varyantElemanTanim.dart';
import 'package:stok_takip_uygulamasi/varyantTanim.dart';

class Tanimlamalar extends StatefulWidget {
  const Tanimlamalar({Key? key}) : super(key: key);

  @override
  State<Tanimlamalar> createState() => _TanimlamalarState();
}

class _TanimlamalarState extends State<Tanimlamalar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('Tanımlamalar')),
      endDrawer: DrawerMenu(),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KategoriTanim()));
            },
            leading: Icon(
              Icons.category,
              color: Color(0XFF6E3F52),
            ),
            title: Text(
              'Kategori Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni kategori tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MarkaTanim()));
            },
            leading: Icon(
              Icons.branding_watermark_outlined,
              color: Color(0XFF6E3F52),
            ),
            title: Text(
              'Marka Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni marka tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModelTanim()));
            },
            leading: Icon(
              Icons.model_training,
              color: Color(0XFF6E3F52),
            ),
            title: Text(
              'Model Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni model tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VaryantTanim()));
            },
            leading: Icon(
              Icons.view_in_ar,
              color: Color(0XFF6E3F52),
            ),
            title: Text(
              'Varyant Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni varyant tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VaryantElemanTanim()));
            },
            leading: Icon(
              Icons.fitbit,
              color: Color(0XFF6E3F52),
            ),
            title: Text(
              'Varyant Eleman Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni varyant eleman tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),

        ],
      ),
    );
  }
}
