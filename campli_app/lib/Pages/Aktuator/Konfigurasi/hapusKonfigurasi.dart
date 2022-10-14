import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:http/http.dart' as http;

class hapusKonfigurasi {
  //delete
  Future hapusDataKonfigurasi(int id) async {
    final response =
        await http.delete(url + "/konfigurasi/hapus/" + id.toString());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
