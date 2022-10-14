import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:campli_app/konfigurasi/tulisan.dart';
import '../../model/dataTiang.dart';
import 'package:async/async.dart';

class hapusTiang {
  //delete
  Future hapusDataTiang(int id) async {
    final response = await http.delete(url + "/tiang/hapus/" + id.toString());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
