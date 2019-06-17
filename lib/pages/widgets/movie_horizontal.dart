import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  MovieHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView(
        pageSnapping: false,
        children: _tarjetas(context),
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPoster()),
                placeholder: AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              
              pelicula.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
              )
          ],
        ),
      );
    }).toList();
  }
}
