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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
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
            return _buildList(heroesController);
          },
        )
        // is trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
