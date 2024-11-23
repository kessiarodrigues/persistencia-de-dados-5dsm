import 'package:flutter/material.dart';
import 'package:projetopersistencia/database/app_database.dart';
import 'package:projetopersistencia/screens/dashboard.dart';

class MovieRegistrationScreen extends StatefulWidget {
  @override
  _MovieRegistrationScreenState createState() =>
      _MovieRegistrationScreenState();
}

class _MovieRegistrationScreenState extends State<MovieRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _directorController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _directorController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveMovie() async {
    if (_formKey.currentState!.validate()) {
      await AppDatabase.instance.insertMovie({
        'title': _titleController.text,
        'director': _directorController.text,
        'year': int.parse(_yearController.text),
        'description': _descriptionController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Filme salvo com sucesso!')),
      );
      // Limpar os campos após salvar
      _titleController.clear();
      _directorController.clear();
      _yearController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Filmes'),
      ),
      drawer: MainMenuWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Título do Filme',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o título do filme';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _directorController,
                  decoration: InputDecoration(
                    labelText: 'Diretor',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do diretor';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _yearController,
                  decoration: InputDecoration(
                    labelText: 'Ano de Lançamento',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o ano de lançamento';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um ano válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  maxLines: 4,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: _saveMovie,
                    child: Text('Salvar Filme'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
