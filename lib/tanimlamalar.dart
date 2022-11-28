import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/kategoriTanim.dart';
import 'package:stok_takip_uygulamasi/markaTanim.dart';
import 'package:stok_takip_uygulamasi/modelTanim.dart';

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
                    MaterialPageRoute(builder: (context) => IsTaslak()));              },
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
              style: TextStyle(color: Color(0XFF976775)),
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
              style: TextStyle(color: Color(0XFF976775)),
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
              style: TextStyle(color: Color(0XFF976775)),
            ),
            subtitle: Text(
              'Yeni model tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
        ],
      ),
    );
  }
}
