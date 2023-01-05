import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/kategori_tanim.dart';
import 'package:stok_takip_uygulamasi/marka_tanim.dart';
import 'package:stok_takip_uygulamasi/model_tanim.dart';
import 'package:stok_takip_uygulamasi/varyant_eleman_tanim.dart';
import 'package:stok_takip_uygulamasi/varyant_tanim.dart';

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
          backgroundColor: const Color(0xFF976775), title: const Text('Tanımlamalar')),
      endDrawer: DrawerMenu(),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const KategoriTanim()));
            },
            leading: const Icon(
              Icons.category,
              color: Color(0XFF6E3F52),
            ),
            title: const Text(
              'Kategori Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Yeni kategori tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: const Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MarkaTanim()));
            },
            leading: const Icon(
              Icons.branding_watermark_outlined,
              color: Color(0XFF6E3F52),
            ),
            title: const Text(
              'Marka Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Yeni marka tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: const Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModelTanim()));
            },
            leading: const Icon(
              Icons.model_training,
              color: Color(0XFF6E3F52),
            ),
            title: const Text(
              'Model Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Yeni model tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: const Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VaryantTanim()));
            },
            leading: const Icon(
              Icons.view_in_ar,
              color: Color(0XFF6E3F52),
            ),
            title: const Text(
              'Varyant Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Yeni varyant tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: const Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VaryantElemanTanim()));
            },
            leading: const Icon(
              Icons.fitbit,
              color: Color(0XFF6E3F52),
            ),
            title: const Text(
              'Varyant Eleman Tanım',
              style: TextStyle(color: Color(0XFF976775), fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Yeni varyant eleman tanımlayın',
              style: TextStyle(color: Color(0XFFAAA3B4)),
            ),
            trailing: const Icon(Icons.arrow_right, color: Color(0XFFAAA3B4)),
          ),

        ],
      ),
    );
  }
}
