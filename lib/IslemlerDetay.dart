import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loadmore/loadmore.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/ProductProcess.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/model/myData.dart';

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

  late myData<ProductProcess> drafts = myData<ProductProcess>();
  late myData<ProductProcess> draftsList = myData<ProductProcess>();
  int pageNum = 1;

  Future<myData<ProductProcess>> draftsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllDrafts?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    drafts = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return drafts;
  }

  Future<myData<ProductProcess>> draftsListeleWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    // drafts.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllDrafts?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    drafts = myData<ProductProcess>.fromJson(json.decode(res.body),ProductProcess.fromJsonModel);


    for (int i = 0; i < drafts.data!.length; i++) {
        draftsList.data?.add(drafts.data![i]);


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
          isFinish: drafts.data!.length==0,
          onLoadMore: _loadMore,
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            // controller: controller,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: [
                  Text(draftsList.data![index].islemAdi.toString() == null ? '' : draftsList.data![index].islemAdi.toString()),
                  Text(draftsList.data![index].islemTuru.toString() == null ? '' : draftsList.data![index].islemTuru.toString()),
                  Text(draftsList.data![index].islemTarihi.toString() == null ? '' : draftsList.data![index].islemTarihi.toString()),
                  Text(draftsList.data![index].islemAciklama.toString() == null ? '' : draftsList.data![index].islemAciklama.toString()),
                  Text(draftsList.data![index].onayiBeklenenUser.toString() == null ? '' : draftsList.data![index].onayiBeklenenUser.toString()),
                  Text(draftsList.data![index].onayIsteyenUser.toString() == null ? '' : draftsList.data![index].onayIsteyenUser.toString()),
                  Text(draftsList.data![index].anaDepoId.toString() == null ? '' : draftsList.data![index].anaDepoId.toString()),
                  Text(draftsList.data![index].hedefDepoID.toString() == null ? '' : draftsList.data![index].hedefDepoID.toString()),
                ],
              ));
            },
            itemCount: draftsList.data?.length,
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

  late myData<ProductProcess> WaitingForMyConfirmations = myData<ProductProcess>();
  late myData<ProductProcess> WaitingForMyConfirmationsList = myData<ProductProcess>();
  int pageNumWaitingForMyConfirmations = 1;

  Future<myData<ProductProcess>> WaitingForMyConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=true'));
    WaitingForMyConfirmations = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return WaitingForMyConfirmations;
  }

  Future<myData<ProductProcess>> WaitingForMyConfirmationsWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    WaitingForMyConfirmations.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForMyConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Id=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}&includeParents=true&includeChildren=true'));
    WaitingForMyConfirmations = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);
  print(res.body);

    for (int i = 0; i < WaitingForMyConfirmations.data!.length; i++) {
      WaitingForMyConfirmationsList.data!.add(WaitingForMyConfirmations.data![i]);


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
        isFinish: WaitingForMyConfirmations.data!.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(WaitingForMyConfirmationsList.data![index].islemAdi.toString()),
                    Text(WaitingForMyConfirmationsList.data![index].islemTuru.toString()),
                    Text(WaitingForMyConfirmationsList.data![index].islemTarihi.toString()),
                    Text(WaitingForMyConfirmationsList.data![index].islemAciklama.toString()),
                    Text(WaitingForMyConfirmationsList.data![index].onayiBeklenenUser.toString()),
                    Text(WaitingForMyConfirmationsList.data![index].onayIsteyenUser.toString()),
                    Text(WaitingForMyConfirmationsList.data![index].anaDepoId.toString()),
                    Text(WaitingForMyConfirmationsList.data![index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: WaitingForMyConfirmationsList.data!.length,
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

  late myData<ProductProcess> WaitingForConfirmations = myData<ProductProcess>();
  late myData<ProductProcess> WaitingForConfirmationsList = myData<ProductProcess>();
  int pageNumWaitingForConfirmations = 1;

  Future<myData<ProductProcess>> WaitingForConfirmationsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    WaitingForConfirmations = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return WaitingForConfirmations;
  }

  Future<myData<ProductProcess>> WaitingForConfirmationsWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    WaitingForConfirmations.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllWaitingForConfirmations?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    WaitingForConfirmations = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);


    for (int i = 0; i < WaitingForConfirmations.data!.length; i++) {
      WaitingForConfirmationsList.data!.add(WaitingForConfirmations.data![i]);


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
        isFinish: WaitingForConfirmations.data!.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(WaitingForConfirmationsList.data![index].islemAdi.toString()),
                    Text(WaitingForConfirmationsList.data![index].islemTuru.toString()),
                    Text(WaitingForConfirmationsList.data![index].islemTarihi.toString()),
                    Text(WaitingForConfirmationsList.data![index].islemAciklama.toString()),
                    Text(WaitingForConfirmationsList.data![index].onayiBeklenenUser.toString()),
                    Text(WaitingForConfirmationsList.data![index].onayIsteyenUser.toString()),
                    Text(WaitingForConfirmationsList.data![index].anaDepoId.toString()),
                    Text(WaitingForConfirmationsList.data![index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: WaitingForConfirmationsList.data!.length,
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

  late myData<ProductProcess> Rejecteds = myData<ProductProcess>();
  late myData<ProductProcess> RejectedsList = myData<ProductProcess>();
  int pageNumRejecteds = 1;

  Future<myData<ProductProcess>> RejectedsListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejecteds?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    Rejecteds = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return Rejecteds;
  }

  Future<myData<ProductProcess>> RejectedsWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    Rejecteds.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejecteds?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    Rejecteds = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);


    for (int i = 0; i < Rejecteds.data!.length; i++) {
      RejectedsList.data!.add(Rejecteds.data![i]);


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
        isFinish: Rejecteds.data!.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(RejectedsList.data![index].islemAdi.toString()),
                    Text(RejectedsList.data![index].islemTuru.toString()),
                    Text(RejectedsList.data![index].islemTarihi.toString()),
                    Text(RejectedsList.data![index].islemAciklama.toString()),
                    Text(RejectedsList.data![index].onayiBeklenenUser.toString()),
                    Text(RejectedsList.data![index].onayIsteyenUser.toString()),
                    Text(RejectedsList.data![index].anaDepoId.toString()),
                    Text(RejectedsList.data![index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: RejectedsList.data!.length,
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

  myData<ProductProcess> MyConfirmation = myData<ProductProcess>();
  myData<ProductProcess> MyConfirmationList = myData<ProductProcess>();
  int pageNumMyConfirmation = 1;

  Future<myData<ProductProcess>> MyConfirmationListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllMyConfirmation?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    MyConfirmation = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);

    setState(() {});
    return MyConfirmation;
  }

  Future<myData<ProductProcess>> MyConfirmationWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    MyConfirmation.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllMyConfirmation?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    MyConfirmation = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);


    for (int i = 0; i < MyConfirmation.data!.length; i++) {
      MyConfirmationList.data!.add(MyConfirmation.data![i]);


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
        isFinish: MyConfirmation.data!.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(MyConfirmationList.data![index].islemAdi.toString()),
                    Text(MyConfirmationList.data![index].islemTuru.toString()),
                    Text(MyConfirmationList.data![index].islemTarihi.toString()),
                    Text(MyConfirmationList.data![index].islemAciklama.toString()),
                    Text(MyConfirmationList.data![index].onayiBeklenenUser.toString()),
                    Text(MyConfirmationList.data![index].onayIsteyenUser.toString()),
                    Text(MyConfirmationList.data![index].anaDepoId.toString()),
                    Text(MyConfirmationList.data![index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: MyConfirmationList.data!.length,
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

  late myData<ProductProcess> RejectedsByMe = myData<ProductProcess>();
  late myData<ProductProcess> RejectedsByMeList = myData<ProductProcess>();
  int pageNumRejectedsByMe = 1;

  Future<myData<ProductProcess>> RejectedsByMeListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejectedsByMe?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));
    RejectedsByMe = myData<ProductProcess>.fromJson(json.decode(res.body),ProductProcess.fromJsonModel);

    setState(() {});
    return RejectedsByMe;
  }

  Future<myData<ProductProcess>> RejectedsByMeWithFilter(
      int Page,
      int PageSize,
      String Orderby,
      bool Desc,
      bool isDeleted) async {

    RejectedsByMe.data!.clear();
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/ProductProcesses/GetAllRejectedsByMe?AnaDepoIDFilter=0&HedefDepoIdFilter=0&Page=${Page}&PageSize=${PageSize}&Orderby=${Orderby}&Desc=${Desc}&isDeleted=${isDeleted}'));
    RejectedsByMe = myData<ProductProcess>.fromJson(json.decode(res.body), ProductProcess.fromJsonModel);


    for (int i = 0; i < RejectedsByMe.data!.length; i++) {
      RejectedsByMeList.data!.add(RejectedsByMe.data![i]);


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
        isFinish: RejectedsByMe.data!.length==0,
        onLoadMore: _loadMore,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          // controller: controller,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [
                    Text(RejectedsByMeList.data![index].islemAdi.toString()),
                    Text(RejectedsByMeList.data![index].islemTuru.toString()),
                    Text(RejectedsByMeList.data![index].islemTarihi.toString()),
                    Text(RejectedsByMeList.data![index].islemAciklama.toString()),
                    Text(RejectedsByMeList.data![index].onayiBeklenenUser.toString()),
                    Text(RejectedsByMeList.data![index].onayIsteyenUser.toString()),
                    Text(RejectedsByMeList.data![index].anaDepoId.toString()),
                    Text(RejectedsByMeList.data![index].hedefDepoID.toString()),
                  ],
                ));
          },
          itemCount: RejectedsByMeList.data!.length,
        ),
      ),
    );

  }
}
//endregion
