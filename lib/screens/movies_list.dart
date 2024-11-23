import 'package:flutter/material.dart';
import 'package:projetopersistencia/database/app_database.dart';
import 'package:projetopersistencia/screens/dashboard.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Map<String, dynamic>>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = AppDatabase.instance.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Filmes'),
      ),
      drawer: MainMenuWidget(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os filmes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum filme cadastrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return Card(
                  color: Colors.grey[850],
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      movie['title'],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Diretor: ${movie['director']} - Ano: ${movie['year']}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
