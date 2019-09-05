import 'package:flutter/material.dart';
import 'package:flutter_curso/controller/heroes.controller.dart';
import 'package:flutter_curso/models/hero.model.dart';
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
  _buildList(heroesController) {
    return ListView.builder(
      itemCount: heroesController.heroes.length,
      itemBuilder: (context, index) {
        return _buildItem(heroesController.heroes[index], heroesController);
      },
    );
  }

  _buildItem(HeroModel heroModel, HeroesController heroesController) {
    return ListTile(
      onTap: () {
        heroesController.checkFavorito(heroModel);
      },
      title: Text(heroModel.nome),
      trailing: heroModel.isFavorite
          ? Icon(
              Icons.thumb_up,
              color: Colors.purple,
            )
          : Icon(Icons.thumbs_up_down),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Provider'),
          leading: Icon(
            Icons.gesture,
            color: Colors.purple,
          ),
          actions: <Widget>[
            new Stack(
              children: <Widget>[
                Icon(
                  Icons.ac_unit,
                ),
                // Consumer<HeroesController>(
                //  builder: (context, heroController, widget) {
                //   return Text(
                //    "${heroController.heroes.where((i) => i.isFavorite).length}",
                //    style: TextStyle(color: Colors.red, fontSize: 22),
                //  );
                // },
                // ),
                new Positioned(
                  right: 11,
                  top: 11,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Consumer<HeroesController>(
                      builder: (context, heroController, widget) {
                        return Text(
                          "${heroController.heroes.where((i) => i.isFavorite).length}",
                          style: TextStyle(color: Colors.white, fontSize: 8),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Consumer<HeroesController>(
          builder: (context, heroesController, whidget) {
            return _buildList(heroesController);
          },
        )
        // is trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
