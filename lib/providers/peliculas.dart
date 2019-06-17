import 'package:peliculas/models/pelicula.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apikey = '3647902eec0ed26db2fbebebb4e83f96';
  String _url = 'api.themoviedb.org';
  String _lenguaje = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    //print(peliculas.items[0]);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'languaje': _lenguaje});

        return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https('api.themoviedb.org', '3/movie/popular',
        {'api_key': _apikey, 'languaje': _lenguaje});

        return await _procesarRespuesta(url);
  }
}
