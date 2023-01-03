import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loadmore/loadmore.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
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
        backgroundColor: const Color(0xFF976775),
        title: Text(title),
      ),
      endDrawer: DrawerMenu(),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            if (this.widget.islemAdi == 'İşlem Taslakları') {
              return const Drafts(islemAdi: 'İşlem Taslakları');
            }
            if (this.widget.islemAdi == 'Onayımı Bekleyen İşlemler') {
              title = 'Onayımı Bekleyen İşlemler';
              return WaitingForMyConfirmations(
                islemAdi: this.widget.islemAdi,
              );
            }
            if (this.widget.islemAdi == 'Onay Beklediğim İşlemler') {
              title = 'Onay Beklediğim İşlemler';
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
              return const Text('data');
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

  Future<List<ProductProcessData>> draftsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllDrafts?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    drafts = ProductProcess.fromJson(json.decode(res.body)).data.toList();

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
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));


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
          textBuilder: DefaultLoadMoreTextBuilder.turkish,
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

  const WaitingForMyConfirmations({Key? key, required this.islemAdi}) : super(key: key);

  @override
  State<WaitingForMyConfirmations> createState() => _WaitingForMyConfirmationsState();
}

class _WaitingForMyConfirmationsState extends State<WaitingForMyConfirmations> {
  var title = 'WaitingForMyConfirmations';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    WaitingForMyConfirmationsWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()..addListener(_loadMore);

    setState(() {
      title = 'WaitingForMyConfirmations';
      print('WaitingForMyConfirmations çalıştı');
    });
  }

  List<ProductProcessData> WaitingForMyConfirmations = <ProductProcessData>[];
  List<ProductProcessData> WaitingForMyConfirmationsList = <ProductProcessData>[];
  int pageNumWaitingForMyConfirmations = 1;

  Future<List<ProductProcessData>> WaitingForMyConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    WaitingForMyConfirmations = ProductProcess.fromJson(json.decode(res.body)).data.toList();

    setState(() {});
    return WaitingForMyConfirmations;
  }

  Future<List<ProductProcessData>> WaitingForMyConfirmationsWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    WaitingForMyConfirmations.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    WaitingForMyConfirmations = ProductProcess.fromJson(json.decode(res.body)).data.toList();


    for (int i = 0; i < WaitingForMyConfirmations.length; i++) {
      WaitingForMyConfirmationsList.add(WaitingForMyConfirmations[i]);


    }


    setState(() {});
    return WaitingForMyConfirmationsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));


    pageNumWaitingForMyConfirmations = pageNumWaitingForMyConfirmations+1;
    WaitingForMyConfirmationsWithFilter(pageNumWaitingForMyConfirmations, 3, 'Id', false, false);
    print(pageNumWaitingForMyConfirmations);
    return true;
  }


  @override
  Widget build(BuildContext context) {


    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        textBuilder: DefaultLoadMoreTextBuilder.turkish,
        isFinish: WaitingForMyConfirmations.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(WaitingForMyConfirmationsList[index].islemAdi.toString()),
                    Text(WaitingForMyConfirmationsList[index].islemTuru.toString()),
                    Text(WaitingForMyConfirmationsList[index].islemTarihi.toString()),
                    Text(WaitingForMyConfirmationsList[index].islemAciklama.toString()),
                    Text(WaitingForMyConfirmationsList[index].onayiBeklenenUser.toString()),
                    Text(WaitingForMyConfirmationsList[index].onayIsteyenUser.toString()),
                    Text(WaitingForMyConfirmationsList[index].anaDepoId.toString()),
                    Text(WaitingForMyConfirmationsList[index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: WaitingForMyConfirmationsList.length,
        ),
      ),
    );

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
  var title = 'WaitingForConfirmations';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    WaitingForConfirmationsWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()..addListener(_loadMore);

    setState(() {
      title = 'WaitingForConfirmations';
      print('WaitingForConfirmations çalıştı');
    });
  }

  List<ProductProcessData> WaitingForConfirmations = <ProductProcessData>[];
  List<ProductProcessData> WaitingForConfirmationsList = <ProductProcessData>[];
  int pageNumWaitingForConfirmations = 1;

  Future<List<ProductProcessData>> WaitingForConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    WaitingForConfirmations = ProductProcess.fromJson(json.decode(res.body)).data.toList();

    setState(() {});
    return WaitingForConfirmations;
  }

  Future<List<ProductProcessData>> WaitingForConfirmationsWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    WaitingForConfirmations.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    WaitingForConfirmations = ProductProcess.fromJson(json.decode(res.body)).data.toList();


    for (int i = 0; i < WaitingForConfirmations.length; i++) {
      WaitingForConfirmationsList.add(WaitingForConfirmations[i]);


    }


    setState(() {});
    return WaitingForConfirmationsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));


    pageNumWaitingForConfirmations = pageNumWaitingForConfirmations+1;
    WaitingForConfirmationsWithFilter(pageNumWaitingForConfirmations, 3, 'Id', false, false);
    print(pageNumWaitingForConfirmations);
    return true;
  }


  @override
  Widget build(BuildContext context) {


    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        textBuilder: DefaultLoadMoreTextBuilder.turkish,
        isFinish: WaitingForConfirmations.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(WaitingForConfirmationsList[index].islemAdi.toString()),
                    Text(WaitingForConfirmationsList[index].islemTuru.toString()),
                    Text(WaitingForConfirmationsList[index].islemTarihi.toString()),
                    Text(WaitingForConfirmationsList[index].islemAciklama.toString()),
                    Text(WaitingForConfirmationsList[index].onayiBeklenenUser.toString()),
                    Text(WaitingForConfirmationsList[index].onayIsteyenUser.toString()),
                    Text(WaitingForConfirmationsList[index].anaDepoId.toString()),
                    Text(WaitingForConfirmationsList[index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: WaitingForConfirmationsList.length,
        ),
      ),
    );

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
  var title = 'Rejecteds';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    RejectedsWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()..addListener(_loadMore);

    setState(() {
      title = 'Rejecteds';
      print('Rejecteds çalıştı');
    });
  }

  List<ProductProcessData> Rejecteds = <ProductProcessData>[];
  List<ProductProcessData> RejectedsList = <ProductProcessData>[];
  int pageNumRejecteds = 1;

  Future<List<ProductProcessData>> RejectedsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejecteds?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    Rejecteds = ProductProcess.fromJson(json.decode(res.body)).data.toList();

    setState(() {});
    return Rejecteds;
  }

  Future<List<ProductProcessData>> RejectedsWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    Rejecteds.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejecteds?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    Rejecteds = ProductProcess.fromJson(json.decode(res.body)).data.toList();


    for (int i = 0; i < Rejecteds.length; i++) {
      RejectedsList.add(Rejecteds[i]);


    }


    setState(() {});
    return RejectedsList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));


    pageNumRejecteds = pageNumRejecteds+1;
    RejectedsWithFilter(pageNumRejecteds, 3, 'Id', false, false);
    print(pageNumRejecteds);
    return true;
  }


  @override
  Widget build(BuildContext context) {


    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        textBuilder: DefaultLoadMoreTextBuilder.turkish,
        isFinish: Rejecteds.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(RejectedsList[index].islemAdi.toString()),
                    Text(RejectedsList[index].islemTuru.toString()),
                    Text(RejectedsList[index].islemTarihi.toString()),
                    Text(RejectedsList[index].islemAciklama.toString()),
                    Text(RejectedsList[index].onayiBeklenenUser.toString()),
                    Text(RejectedsList[index].onayIsteyenUser.toString()),
                    Text(RejectedsList[index].anaDepoId.toString()),
                    Text(RejectedsList[index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: RejectedsList.length,
        ),
      ),
    );

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
  var title = 'MyConfirmation';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    MyConfirmationWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()..addListener(_loadMore);

    setState(() {
      title = 'MyConfirmation';
      print('MyConfirmation çalıştı');
    });
  }

  List<ProductProcessData> MyConfirmation = <ProductProcessData>[];
  List<ProductProcessData> MyConfirmationList = <ProductProcessData>[];
  int pageNumMyConfirmation = 1;

  Future<List<ProductProcessData>> MyConfirmationListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllMyConfirmation?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    MyConfirmation = ProductProcess.fromJson(json.decode(res.body)).data.toList();

    setState(() {});
    return MyConfirmation;
  }

  Future<List<ProductProcessData>> MyConfirmationWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    MyConfirmation.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllMyConfirmation?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    MyConfirmation = ProductProcess.fromJson(json.decode(res.body)).data.toList();


    for (int i = 0; i < MyConfirmation.length; i++) {
      MyConfirmationList.add(MyConfirmation[i]);


    }


    setState(() {});
    return MyConfirmationList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));


    pageNumMyConfirmation = pageNumMyConfirmation+1;
    MyConfirmationWithFilter(pageNumMyConfirmation, 3, 'Id', false, false);
    print(pageNumMyConfirmation);
    return true;
  }


  @override
  Widget build(BuildContext context) {


    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        textBuilder: DefaultLoadMoreTextBuilder.turkish,
        isFinish: MyConfirmation.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(MyConfirmationList[index].islemAdi.toString()),
                    Text(MyConfirmationList[index].islemTuru.toString()),
                    Text(MyConfirmationList[index].islemTarihi.toString()),
                    Text(MyConfirmationList[index].islemAciklama.toString()),
                    Text(MyConfirmationList[index].onayiBeklenenUser.toString()),
                    Text(MyConfirmationList[index].onayIsteyenUser.toString()),
                    Text(MyConfirmationList[index].anaDepoId.toString()),
                    Text(MyConfirmationList[index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: MyConfirmationList.length,
        ),
      ),
    );

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
  var title = 'RejectedsByMe';
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();

    // draftsListele();
    RejectedsByMeWithFilter(1, 3, 'Id', false, false);
    scrollController = ScrollController()..addListener(_loadMore);

    setState(() {
      title = 'RejectedsByMe';
      print('RejectedsByMe çalıştı');
    });
  }

  List<ProductProcessData> RejectedsByMe = <ProductProcessData>[];
  List<ProductProcessData> RejectedsByMeList = <ProductProcessData>[];
  int pageNumRejectedsByMe = 1;

  Future<List<ProductProcessData>> RejectedsByMeListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejectedsByMe?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    RejectedsByMe = ProductProcess.fromJson(json.decode(res.body)).data.toList();

    setState(() {});
    return RejectedsByMe;
  }

  Future<List<ProductProcessData>> RejectedsByMeWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    RejectedsByMe.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejectedsByMe?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    RejectedsByMe = ProductProcess.fromJson(json.decode(res.body)).data.toList();


    for (int i = 0; i < RejectedsByMe.length; i++) {
      RejectedsByMeList.add(RejectedsByMe[i]);


    }


    setState(() {});
    return RejectedsByMeList;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));


    pageNumRejectedsByMe = pageNumRejectedsByMe+1;
    RejectedsByMeWithFilter(pageNumRejectedsByMe, 3, 'Id', false, false);
    print(pageNumRejectedsByMe);
    return true;
  }


  @override
  Widget build(BuildContext context) {


    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        textBuilder: DefaultLoadMoreTextBuilder.turkish,
        isFinish: RejectedsByMe.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(RejectedsByMeList[index].islemAdi.toString()),
                    Text(RejectedsByMeList[index].islemTuru.toString()),
                    Text(RejectedsByMeList[index].islemTarihi.toString()),
                    Text(RejectedsByMeList[index].islemAciklama.toString()),
                    Text(RejectedsByMeList[index].onayiBeklenenUser.toString()),
                    Text(RejectedsByMeList[index].onayIsteyenUser.toString()),
                    Text(RejectedsByMeList[index].anaDepoId.toString()),
                    Text(RejectedsByMeList[index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: RejectedsByMeList.length,
        ),
      ),
    );

  }
}
//endregion
