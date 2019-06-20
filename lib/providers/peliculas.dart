
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:peliculas/models/pelicula.dart';

class PeliculasProvider {
  String _apikey = '3647902eec0ed26db2fbebebb4e83f96';
  String _url = 'api.themoviedb.org';
  String _lenguaje = 'es-ES';
  int _page = 0;

  List<Pelicula> _populares = new List();
  //inicial el stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //definir dos getters 
  Function(List<Pelicula>)get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

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
    _page++;

    final url = Uri.https('api.themoviedb.org', '3/movie/popular',
        {'api_key': _apikey, 'languaje': _lenguaje,'page':_page.toString()});

    final respuesta = await _procesarRespuesta(url);
    _populares.addAll(respuesta);
    popularesSink(_populares);

    return respuesta;
  }
}
