import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loadmore/loadmore.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcess.dart';
import 'package:http/http.dart' as http;

class IslemlerDetay extends StatefulWidget {
  final String islemAdi;

  const IslemlerDetay({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<IslemlerDetay> createState() => _IslemlerDetayState();
}

class _IslemlerDetayState extends State<IslemlerDetay> {
  @override
  initState() {
    super.initState();
  }

  late String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Color(0xFF976775),
        title: Text(title),
      ),
      endDrawer: DrawerMenu(),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            if (this.widget.islemAdi == 'İşlem Taslakları') {
              return Drafts(islemAdi: 'İşlem Taslakları');
            }
            if (this.widget.islemAdi == 'Onayımı Bekleyen İşlemler') {
              title = 'Onayımı Bekleyen İşlemler';
              return WaitingForMyConfirmations(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Onaya Gönderdiğim İşlemler') {
              title = 'Onaya Gönderdiğim İşlemler';
              return WaitingForConfirmations(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Reddedilen İşlemler') {
              title = 'Reddedilen İşlemler';
              return Rejecteds(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Onayladığım İşlemler') {
              title = 'Onayladığım İşlemler';
              return MyConfirmation(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Reddettiğim İşlemler') {
              title = 'Reddettiğim İşlemler';
              return RejectedsByMe(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == '') {
              return Text('data');
            }
          }),
    );
  }
}

//region GetAllDrafts
class Drafts extends StatefulWidget {
  final String islemAdi;

  const Drafts({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  var title = 'İşlem Taslakları';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    draftsListeleWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()..addListener(_loadMore);

    setState(() {
      title = 'İşlem Taslakları';
      print('İŞlem taslakları çalıştı');
    });
  }

  List<ProductProcessData> drafts = <ProductProcessData>[];
  List<ProductProcessData> draftsList = <ProductProcessData>[];
  int pageNum = 1;
  int pageSize = 5;

  Future<List<ProductProcessData>> draftsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllDrafts?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    drafts = ProductProcess.fromJson(json.decode(res.body)).data.toList();

    // print(cevap);
    // print(drafts[0].islemTuru);
    // print(drafts[0].islemAdi);
    setState(() {});
    return drafts;
  }

  Future<List<ProductProcessData>> draftsListeleWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    drafts.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllDrafts?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    drafts = ProductProcess.fromJson(json.decode(res.body)).data.toList();


    for (int i = 0; i < drafts.length; i++) {
        draftsList.add(drafts[i]);


    }


    setState(() {});
    return draftsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));


    pageNum = pageNum+1;
    draftsListeleWithFilter(pageNum, 3, 'Id', false, false);
    print(pageNum);
    return true;
  }


  @override
  Widget build(BuildContext context) {


      return RefreshIndicator(
        onRefresh: _refresh,
        child: LoadMore(
          isFinish: drafts.length==0,
          onLoadMore: _loadMore,
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            // controller: controller,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: [
                  Text(draftsList[index].islemAdi.toString()),
                  Text(draftsList[index].islemTuru.toString()),
                  Text(draftsList[index].islemTarihi.toString()),
                  Text(draftsList[index].islemAciklama.toString()),
                  Text(draftsList[index].onayiBeklenenUser.toString()),
                  Text(draftsList[index].onayIsteyenUser.toString()),
                  Text(draftsList[index].anaDepoId.toString()),
                  Text(draftsList[index].hedefDepoID.toString()),
                ],
              ));
            },
            itemCount: draftsList.length,
          ),
        ),
      );

  }
}
//endregion

//region GetAllWaitingForMyConfirmations
class WaitingForMyConfirmations extends StatefulWidget {
  final String islemAdi;

  const WaitingForMyConfirmations({Key? key, required this.islemAdi})
      : super(key: key);

  @override
  State<WaitingForMyConfirmations> createState() =>
      _WaitingForMyConfirmationsState();
}

class _WaitingForMyConfirmationsState extends State<WaitingForMyConfirmations> {
  var title = 'Onayımı Bekleyen İşlemler';

  @override
  initState() {
    super.initState();

    WaitingForMyConfirmationsListele();
    setState(() {
      title = 'Onayımı Bekleyen İşlemler';
      print('onay bekleyenler çalıştı');
    });
  }

  List<ProductProcessData> onayimiBekleyenIslemler = <ProductProcessData>[];

  Future<List<ProductProcessData>> WaitingForMyConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    onayimiBekleyenIslemler =
        ProductProcess.fromJson(json.decode(res.body)).data.toList();
    // print(cevap);
    // print(onayimiBekleyenIslemler[0].islemTuru);
    // print(onayimiBekleyenIslemler[0].islemAdi);
    setState(() {});
    return onayimiBekleyenIslemler;
  }

  @override
  Widget build(BuildContext context) {
    if (onayimiBekleyenIslemler.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            semanticsValue: 'sd',
            strokeWidth: 3.0,
            color: Color(0XFFDBDCE8),
            backgroundColor: Color(0XFFAAA3B4),
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        // controller: controller,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              onayimiBekleyenIslemler[index].islemAdi == ''
                  ? Text('data')
                  : Text(onayimiBekleyenIslemler[index].islemAdi.toString()),
              Text(onayimiBekleyenIslemler[index].islemTuru.toString()),
              Text(onayimiBekleyenIslemler[index].islemTarihi.toString()),
              Text(onayimiBekleyenIslemler[index].islemAciklama.toString()),
              Text(onayimiBekleyenIslemler[index].onayiBeklenenUser.toString()),
              Text(onayimiBekleyenIslemler[index].onayIsteyenUser.toString()),
              Text(onayimiBekleyenIslemler[index].anaDepoId.toString()),
              Text(onayimiBekleyenIslemler[index].hedefDepoID.toString()),
            ],
          ));
        },
        itemCount: onayimiBekleyenIslemler.length,
      );
    }
  }
}
//endregion

//region WaitingForConfirmations
class WaitingForConfirmations extends StatefulWidget {
  final String islemAdi;

  const WaitingForConfirmations({Key? key, required this.islemAdi})
      : super(key: key);

  @override
  State<WaitingForConfirmations> createState() =>
      _WaitingForConfirmationsState();
}

class _WaitingForConfirmationsState extends State<WaitingForConfirmations> {
  var title = 'Onayıma Gönderdiğim İşlemler';

  @override
  initState() {
    super.initState();
    WaitingForConfirmationsListele();
    setState(() {
      title = 'Onaya Gönderdiğim İşlemler';
      print('onaya gönderdiğim çalıştı');
    });
  }

  List<ProductProcessData> onayaGonderdigimIslemler = <ProductProcessData>[];

  Future<List<ProductProcessData>> WaitingForConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    onayaGonderdigimIslemler =
        ProductProcess.fromJson(json.decode(res.body)).data.toList();
    // print(cevap);
    print(onayaGonderdigimIslemler[0].islemTuru);
    print(onayaGonderdigimIslemler[0].islemAdi);
    print(onayaGonderdigimIslemler[0].onayiBeklenenUser);
    print(onayaGonderdigimIslemler[0].islemAciklama);
    setState(() {});
    return onayaGonderdigimIslemler;
  }

  @override
  Widget build(BuildContext context) {
    if (onayaGonderdigimIslemler.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            semanticsValue: 'sd',
            strokeWidth: 3.0,
            color: Color(0XFFDBDCE8),
            backgroundColor: Color(0XFFAAA3B4),
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        // controller: controller,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              Text(onayaGonderdigimIslemler[index].islemAdi.toString()),
              Text(onayaGonderdigimIslemler[index].islemTuru.toString()),
              Text(onayaGonderdigimIslemler[index].islemTarihi.toString()),
              Text(onayaGonderdigimIslemler[index].islemAciklama.toString()),
              Text(
                  onayaGonderdigimIslemler[index].onayiBeklenenUser.toString()),
              Text(onayaGonderdigimIslemler[index].onayIsteyenUser.toString()),
              Text(onayaGonderdigimIslemler[index].anaDepoId.toString()),
              Text(onayaGonderdigimIslemler[index].hedefDepoID.toString()),
            ],
          ));
        },
        itemCount: onayaGonderdigimIslemler.length,
      );
    }
  }
}
//endregion

//region Rejecteds
class Rejecteds extends StatefulWidget {
  final String islemAdi;

  const Rejecteds({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<Rejecteds> createState() => _RejectedsState();
}

class _RejectedsState extends State<Rejecteds> {
  var title = 'Reddedilen İşlemler';

  @override
  initState() {
    super.initState();
    RejectedsListele();
    setState(() {
      title = 'Reddedilen İşlemler';
      print('Reddedilen Islemler çalıştı');
    });
  }

  List<ProductProcessData> reddedilenIslemler = <ProductProcessData>[];

  Future<List<ProductProcessData>> RejectedsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejecteds?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    reddedilenIslemler =
        ProductProcess.fromJson(json.decode(res.body)).data.toList();
    // print(cevap);
    print(reddedilenIslemler[0].islemTuru);
    print(reddedilenIslemler[0].islemAdi);
    print(reddedilenIslemler[0].onayiBeklenenUser);
    print(reddedilenIslemler[0].islemAciklama);
    setState(() {});
    return reddedilenIslemler;
  }

  @override
  Widget build(BuildContext context) {
    if (reddedilenIslemler.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            semanticsValue: 'sd',
            strokeWidth: 3.0,
            color: Color(0XFFDBDCE8),
            backgroundColor: Color(0XFFAAA3B4),
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        // controller: controller,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              Text(reddedilenIslemler[index].islemAdi.toString()),
              Text(reddedilenIslemler[index].islemTuru.toString()),
              Text(reddedilenIslemler[index].islemTarihi.toString()),
              Text(reddedilenIslemler[index].islemAciklama.toString()),
              Text(reddedilenIslemler[index].onayiBeklenenUser.toString()),
              Text(reddedilenIslemler[index].onayIsteyenUser.toString()),
              Text(reddedilenIslemler[index].anaDepoId.toString()),
              Text(reddedilenIslemler[index].hedefDepoID.toString()),
            ],
          ));
        },
        itemCount: reddedilenIslemler.length,
      );
    }
  }
}
//endregion

//region MyConfirmation
class MyConfirmation extends StatefulWidget {
  final String islemAdi;

  const MyConfirmation({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<MyConfirmation> createState() => _MyConfirmationState();
}

class _MyConfirmationState extends State<MyConfirmation> {
  var title = 'Onayladigim İşlemler';

  @override
  initState() {
    super.initState();
    MyConfirmationListele();
    setState(() {
      title = 'Onayladigim İşlemler';
      print('Onayladigim Islemler çalıştı');
    });
  }

  List<ProductProcessData> onayladigimIslemler = <ProductProcessData>[];

  Future<List<ProductProcessData>> MyConfirmationListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllMyConfirmation?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    onayladigimIslemler =
        ProductProcess.fromJson(json.decode(res.body)).data.toList();
    // print(cevap);
    print(onayladigimIslemler[0].islemTuru);
    print(onayladigimIslemler[0].islemAdi);
    print(onayladigimIslemler[0].onayiBeklenenUser);
    print(onayladigimIslemler[0].islemAciklama);
    setState(() {});
    return onayladigimIslemler;
  }

  @override
  Widget build(BuildContext context) {
    if (onayladigimIslemler.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
        shrinkWrap: true,
        // controller: controller,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              Text(onayladigimIslemler[index].islemAdi.toString()),
              Text(onayladigimIslemler[index].islemTuru.toString()),
              Text(onayladigimIslemler[index].islemTarihi.toString()),
              Text(onayladigimIslemler[index].islemAciklama.toString()),
              Text(onayladigimIslemler[index].onayiBeklenenUser.toString()),
              Text(onayladigimIslemler[index].onayIsteyenUser.toString()),
              Text(onayladigimIslemler[index].anaDepoId.toString()),
              Text(onayladigimIslemler[index].hedefDepoID.toString()),
            ],
          ));
        },
        itemCount: onayladigimIslemler.length,
      );
    }
  }
}
//endregion

//region RejectedsByMe
class RejectedsByMe extends StatefulWidget {
  final String islemAdi;

  const RejectedsByMe({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<RejectedsByMe> createState() => _RejectedsByMeState();
}

class _RejectedsByMeState extends State<RejectedsByMe> {
  var title = 'Reddettigim İşlemler';

  @override
  initState() {
    super.initState();
    RejectedsByMeListele();
    setState(() {
      title = 'Reddettigim İşlemler';
      print('Reddettigim Islemler çalıştı');
    });
  }

  List<ProductProcessData> reddettigimIslemler = <ProductProcessData>[];

  Future<List<ProductProcessData>> RejectedsByMeListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejectedsByMe?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    reddettigimIslemler =
        ProductProcess.fromJson(json.decode(res.body)).data.toList();
    // print(cevap);
    print(reddettigimIslemler[0].islemTuru);
    print(reddettigimIslemler[0].islemAdi);
    print(reddettigimIslemler[0].onayiBeklenenUser);
    print(reddettigimIslemler[0].islemAciklama);
    setState(() {});
    return reddettigimIslemler;
  }

  @override
  Widget build(BuildContext context) {
    if (reddettigimIslemler.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            semanticsValue: 'sd',
            strokeWidth: 3.0,
            color: Color(0XFFDBDCE8),
            backgroundColor: Color(0XFFAAA3B4),
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        // controller: controller,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              Text(reddettigimIslemler[index].islemAdi.toString()),
              Text(reddettigimIslemler[index].islemTuru.toString()),
              Text(reddettigimIslemler[index].islemTarihi.toString()),
              Text(reddettigimIslemler[index].islemAciklama.toString()),
              Text(reddettigimIslemler[index].onayiBeklenenUser.toString()),
              Text(reddettigimIslemler[index].onayIsteyenUser.toString()),
              Text(reddettigimIslemler[index].anaDepoId.toString()),
              Text(reddettigimIslemler[index].hedefDepoID.toString()),
            ],
          ));
        },
        itemCount: reddettigimIslemler.length,
      );
    }
  }
}
//endregion
