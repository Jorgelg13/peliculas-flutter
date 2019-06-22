import 'package:flutter/material.dart';
import 'package:peliculas/pages/widgets/swiper_page.dart';
import 'package:peliculas/providers/peliculas.dart';
import 'package:peliculas/pages/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final pelisProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    pelisProvider.getPopulares();

    return Scaffold(
        backgroundColor: Colors.white54,
        appBar: AppBar(
          
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: pelisProvider.getEncines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return SwiperPage(
            pelicuas: snapshot.data,
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );

    /*pelisProvider.getEncines();
    return SwiperPage(
      pelicuas: [1,2,3,4,5],
    );*/
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: pelisProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: pelisProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
