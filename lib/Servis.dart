import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/model/Marka.dart';

class Servis {

  Future<void> markaEkle(String markaAdi) async {
    var url = Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/brands');
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "markaAdi": markaAdi
        }));
    markaAdi = "";

    print(response.body);
    print(response.statusCode);

  }

  Future<List<Marka>> markaListele() async{

    var url = Uri.parse('https://stok.bahcelievler.bel.tr/api/Brands');

    http.Response response = await http.post(url,   headers: {
      'Accept': '*/*',
      'Content-Type': 'application/json'
    } );
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    List<Marka> markalar = parsed
        .map<Marka>((json) => Marka.fromJson(json))
        .toList();


    print(markalar.length);
    return markalar;
  }
}


