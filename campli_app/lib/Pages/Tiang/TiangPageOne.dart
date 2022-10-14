//import 'package:campli_app/Pages/BottomNavBarPage.dart';
import 'package:flutter/material.dart';
//import 'TiangPageTwo.dart';
//import 'BottomNavBarPage.dart';
import 'TambahTiang.dart';

//shortcut = stful

class TiangPageOne extends StatefulWidget {
  final String id;
  final String jumlahLantai;
  final String namaTiang;

  const TiangPageOne(this.id, this.jumlahLantai, this.namaTiang, {Key key})
      : super(key: key);
  @override
  _TiangPageOneState createState() => _TiangPageOneState();
}

class _TiangPageOneState extends State<TiangPageOne> {
  ScrollController _scrollController = new ScrollController(); //buat controller
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //biar bottom ga overload
      appBar: new AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          "TIANG",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, //style: bisa bold
            fontSize: 20.0,
          ),
        ),
      ),
      extendBodyBehindAppBar: true, //make appbar under background

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/tiang-01.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 60.0,
                  vertical: 130.0), //vertical = mengatur posisi atas ke bawah

              child: Material(
                elevation: 0,
                color: Colors.white54, //color of search bar
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                child: TextField(
                  controller: TextEditingController(),
                  //style: DropdownMenuItemStyle(l),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 15.0),
                    hintText: "Cari tiang",
                    prefixIcon: Material(
                      //letakin posisi icon
                      color: Colors.transparent, //warna search iconnya
                      elevation: 0,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),

                      child: Icon(
                        Icons.search,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              //pasin posisi padding
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Tambah Tiang Sekarang!',
                style: TextStyle(
                    color: Color(0xff004d4f),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),

            SizedBox(
              //pasin posisi padding
              height: 0,
            ),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                  'Kamu belum punya tiang, Yuk lengkapi data \n tiangmu sekarang untuk memantau \n keadaannya ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              //pasin posisi padding
              height: 0,
            ),

            //buat button Mulai
            Container(
              height: 45.0,
              margin: const EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                onPressed: () {
//                  Navigator.push(
//                    context,
//
//                    MaterialPageRoute(builder: (context) => TambahTiang()),
//                  );
                },
                //AlertDialog end
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff5fc08f), Color(0xff4EBF9F)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 80.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Tambah Tiang",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
