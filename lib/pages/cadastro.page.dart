import 'package:flutter/material.dart';
import 'package:flutter_curso/controller/heroes.controller.dart';
import 'package:flutter_curso/models/hero.model.dart';
import 'package:provider/provider.dart';

class Cadastro extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Cadastro> {
  TextEditingController nome = TextEditingController();
  TextEditingController cliente = TextEditingController();
  TextEditingController tecnico = TextEditingController();

  String _value = 'teste';
  DateTime data = new DateTime.now();
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de dados'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Nome: '),
                    TextField(
                      controller: nome,
                      autocorrect: true,
                      autofocus: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Tecnico: '),
                    TextField(
                      controller: tecnico,
                      autocorrect: true,
                      autofocus: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Cliente: '),
                    TextField(
                      controller: cliente,
                      autocorrect: true,
                      autofocus: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Favoritar: '),
                    Checkbox(
                      value: favorite,
                      onChanged: (bool value) {
                        setState(() {
                          this.favorite = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(32.0),
                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new Text(data.toString()),
                      new RaisedButton(
                        //onPressed: _selectDate,
                        onPressed: () async {
                          final data = await showDatePicker(
                            context: context,
                            firstDate: new DateTime(2000),
                            lastDate: new DateTime(2050),
                            initialDate: new DateTime.now(),
                          );
                          if (data != null) {
                            setState(() {
                              this.data = data;
                            });
                            print(data.toString());
                          }
                        },
                        child: new Text('Alterar data'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: Consumer<HeroesController>(
        builder: (context, heroesController, whidget) {
          return FloatingActionButton(
            child: Icon(Icons.control_point_duplicate),
            onPressed: () {
              heroesController.add(
                new HeroModel(
                    cliente: cliente.text,
                    nome: nome.text,
                    data: data.toString(),
                    isFavorite: favorite,
                    tecnico: tecnico.text),
              );
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
