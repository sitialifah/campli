import 'package:http/http.dart' as http;
import 'package:campli_app/konfigurasi/tulisan.dart';

class hapusLantai {
  //delete
  Future hapusDataLantai(int id) async {
    final response = await http.delete(url + "/lantai/hapus/" + id.toString());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
