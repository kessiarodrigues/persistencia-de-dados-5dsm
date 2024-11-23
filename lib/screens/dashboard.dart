import 'package:flutter/material.dart';
import 'package:projetopersistencia/screens/movies_form.dart';
import 'package:projetopersistencia/screens/movies_list.dart';

class MainMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/moviecom_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.list, color: Theme.of(context).colorScheme.primary),
            title: Text('Listar Filmes'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MovieListScreen()),
              );
            },
          ),
          ListTile(
            leading:
                Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            title: Text('Cadastrar Filme'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieRegistrationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
