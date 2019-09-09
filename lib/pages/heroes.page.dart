import 'package:flutter/material.dart';
import 'package:flutter_curso/controller/heroes.controller.dart';
import 'package:flutter_curso/models/hero.model.dart';
import 'package:flutter_curso/pages/cadastro.page.dart';
import 'package:provider/provider.dart';

class HeroApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HeroesController>.value(
          value: HeroesController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHeroPage(),
      ),
    );
  }
}

class MyHeroPage extends StatefulWidget {
  MyHeroPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHeroPage> {
  _buildList(heroesController, heroes) {
    return ListView.builder(
      itemCount: heroes.length,
      itemBuilder: (context, index) {
        return _buildItem(heroes[index], heroesController);
      },
    );
  }

  _buildItem(HeroModel heroModel, HeroesController heroesController) {
    return GestureDetector(
      onTap: () {
        //heroesController.checkFavorito(heroModel);
         Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(model: heroModel),
                ),
              );
      },
      child: Card(
        child: Padding(
          padding: new EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Stack(
            children: <Widget>[
              ListTile(
                title: Text(
                  heroModel.nome,
                  style: TextStyle(fontSize: 22),
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Text(heroModel.cliente),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Text(heroModel.tecnico),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Text(heroModel.data),
                      ),
                      FlatButton(
                        child: Text(
                          'Excluir',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 21,
                          ),
                        ),
                        color: Colors.blue[100],
                        onPressed: () {
                          heroesController.remove(heroModel);
                        },
                      ),
                    ]),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        heroesController.checkFavorito(heroModel);
                      },
                      icon: heroModel.isFavorite
                          ? Icon(
                              Icons.thumb_up,
                              color: Colors.purple,
                            )
                          : Icon(Icons.thumbs_up_down),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Refez a tela");
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
        leading: Icon(
          Icons.gesture,
          color: Colors.purple,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 5),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffc32c37),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: Consumer<HeroesController>(
                          builder: (context, heroController, widget) {
                            return Text(
                              "${heroController.heroes.where((i) => i.isFavorite).length}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<HeroesController>(
        builder: (context, heroesController, whidget) {
          List<HeroModel> heroes = [];
          heroes.addAll(heroesController.heroes.where((i) => i.isFavorite));
          heroes.addAll(heroesController.heroes.where((i) => !i.isFavorite));
          return _buildList(heroesController, heroes);
        },
      ),
      floatingActionButton: Consumer<HeroesController>(
        builder: (context, heroesController, whidget) {
          return FloatingActionButton(
            child: Icon(Icons.plus_one),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(),
                ),
              );
            },
          );
        },
      ),
      // is trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
