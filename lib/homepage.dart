import 'package:dio/dio.dart';
import 'package:firstapp/detail_berita.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List artikel = [];

  var dio = Dio();
  void ambilArtikel() async {
    var result = await dio.get(
        'https://my-json-server.typicode.com/dapealfy/artikel_berita/data');
    setState(() {
      artikel = result.data;
    });
  }

  @override
  void initState() {
    ambilArtikel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar'),
      ),
      body: ListView.builder(
        itemCount: artikel.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailBerita(
                          dataArtikel: artikel[index],
                        )),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.yellow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.network(
                          artikel[index]['thumbnail'],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    artikel[index]['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    artikel[index]['description'],
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
