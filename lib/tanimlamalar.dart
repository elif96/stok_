import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/kategori_tanim.dart';
import 'package:stok_takip_uygulamasi/marka_tanim.dart';
import 'package:stok_takip_uygulamasi/model_tanim.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
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
          backgroundColor: myColors.topColor, title: Text('Tanımlamalar')),
      endDrawer: DrawerMenu(),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const KategoriTanim()));
            },
            leading: Icon(
              Icons.category,
              color: myColors.baslikColor,
            ),
            title: Text(
              'Kategori Tanım',
              style: TextStyle(color: myColors.baslikColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni kategori tanımlayın',
              style: TextStyle(color: myColors.textColor),
            ),
            trailing: Icon(Icons.arrow_right, color: myColors.baslikColor),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MarkaTanim()));
            },
            leading: Icon(
              Icons.branding_watermark_outlined,
              color: myColors.baslikColor,
            ),
            title: Text(
              'Marka Tanım',
              style: TextStyle(color: myColors.baslikColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni marka tanımlayın',
              style: TextStyle(color: myColors.textColor),
            ),
            trailing: Icon(Icons.arrow_right, color: myColors.baslikColor),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModelTanim()));
            },
            leading: Icon(
              Icons.model_training,
              color: myColors.baslikColor,
            ),
            title: Text(
              'Model Tanım',
              style: TextStyle(color: myColors.baslikColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni model tanımlayın',
              style: TextStyle(color: myColors.textColor),
            ),
            trailing: Icon(Icons.arrow_right, color: myColors.baslikColor),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VaryantTanim()));
            },
            leading: Icon(
              Icons.view_in_ar,
              color: myColors.baslikColor,
            ),
            title: Text(
              'Varyant Tanım',
              style: TextStyle(color: myColors.baslikColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni varyant tanımlayın',
              style: TextStyle(color: myColors.textColor),
            ),
            trailing: Icon(Icons.arrow_right, color: myColors.baslikColor),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VaryantElemanTanim()));
            },
            leading: Icon(
              Icons.fitbit,
              color: myColors.baslikColor,
            ),
            title: Text(
              'Varyant Eleman Tanım',
              style: TextStyle(color: myColors.baslikColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Yeni varyant eleman tanımlayın',
              style: TextStyle(color: myColors.textColor),
            ),
            trailing: Icon(Icons.arrow_right, color: myColors.baslikColor),
          ),

        ],
      ),
    );
  }
}
