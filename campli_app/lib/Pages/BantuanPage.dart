import 'package:campli_app/widget/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/navigationDrawer/navigationDrawer.dart';
import 'Home.dart';
import 'package:campli_app/konfigurasi/color.dart';

class BantuanPage extends StatefulWidget {
  static const String routeName = '/BantuanPage';
  @override
  _BantuanPageState createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentColor,
        elevation: 0,
        title: Text(
          "Bantuan",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      drawer: navigationDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height + 320,
        child: Stack(
          children: <Widget>[
            ClipPathHeader(),
            Container(
              padding:
                  EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
              margin: EdgeInsets.only(top: 150),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height + 320),
              decoration: BoxDecoration(
                color: Color(0xfff6f8fb),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  new BoxShadow(
                    offset: Offset(3.0, 3.0),
                    color: Colors.grey,
                    blurRadius: 20.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/img/bantuan.png", width: 350)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200, bottom: 50.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) =>
                    EntryItem(data[index]),
                itemCount: data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Bagaimana cara menambah tiang campli?',
    <Entry>[
      Entry(
        "Penambahan tiang campli dilakukan dengan cara masuk ke halaman daftar tiang dan kemudian menekan tombol tambah pada halaman tersebut. Pastikan untuk menekan tombol simpan agar data tiang yang ditambah dapat tersimpan dan muncul pada halaman daftar tiang.",
      ),
    ],
  ),
  Entry(
    'Bagaimana cara mengatur jadwal penyiraman tanaman?',
    <Entry>[
      Entry(
        'Menggunakan Fitur Konfigurasi',
        <Entry>[
          Entry(
              "Fitur konfigurasi digunakan untuk mengatur jadwal aktuator bekerja. Aktuator terdiri dari tiga jenis yaitu aktuator penyiraman air, penambahan pupuk dan pemutaran tiang. Untuk masuk ke halaman konfigurasi, anda harus memilih tiang terlebih dahulu, kemudian pilih tabbar aktuator. Pilih salah satu aktuator, misalnya penyiraman air. Pada halaman konfigurasi terdapat daftar konfigurasi yang sudah ditambahkan dan akan dikerjakan. Untuk menambah jadwal konfigurasi, dapat menekan tombol tambah dan pilih jadwal konfigurasinya. "),
        ],
      ),
    ],
  ),
  Entry(
    'Bagaimana cara memantau kondisi tanaman ?',
    <Entry>[
      Entry(
        'Melihat pada halaman beranda',
        <Entry>[
          Entry(
              "Pemantauan kondisi tanaman pada aplikasi CAMPLI dapat dilihat pada halaman beranda. Di beranda, anda dapat melihat nilai rata-rata sensor suhu, kelembaban udara, dan kelembaban tanah pada tiang CAMPLI. Anda juga dapat melihat persentase keadaan tanaman dalam bentuk grafik."),
        ],
      ),
      Entry(
        'Melihat pada halaman detail tiang',
        <Entry>[
          Entry(
              "Pilih salah satu tiang yang ada pada halaman daftar tiang untuk melihat informasi keadaan tanaman dengan nilai bacaan sensor suhu dan sensor kelambaban udara."),
        ],
      ),
      Entry(
        'Melihat pada halaman pot',
        <Entry>[
          Entry(
              "Untuk melihat kondisi terkini keadaan tanaman (kering, basah, normal), anda dapat melihatnya pada halaman pot. Caranya adalah dengan masuk ke halaman lantai dengan memilih tiang terlebih dahulu. Kemudian, pilih salah satu lantai untuk masuk ke halaman pot. Kondisi tanaman dapat dilihat pada daftar pot dengan bacaan sensor kelembaban tanah"),
        ],
      ),
    ],
  ),
  Entry(
    'Bagaimana cara memantau dan mengawasi perangkat CAMPLI?',
    <Entry>[
      Entry(
          "Dengan CAMPLI APP anda bisa melakukan pengawan terhadap perangkat CAMPLI dengan memanfaatkan fitur PING. Di fitur PING, anda dapat mengecek kondisi komponen sensor dan komponen aktuator yang ada pada tiang anda"),
    ],
  ),
  Entry(
    'Bagaimana cara melihat konfigurasi yang sudah selesai?',
    <Entry>[
      Entry(
          "Dengan fitur riwayat anda dapat melihat jadwal konfigurasi yang sudah selesai. Pada fitur riwayat, akan muncul daftar konfigurasi yang telah selesai yang diuruti dari paling terkini"),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(BantuanPage());
}
