import 'package:flutter/widgets.dart';
import 'package:flutter_curso/models/hero.model.dart';

class HeroesController extends ChangeNotifier {
  List<HeroModel> heroes = [
    HeroModel(nome: 'patati', isFavorite: true, data: DateTime.now().toString()),
    HeroModel(nome: 'patata', tecnico: 'anderson', data: DateTime.now().toString()),
    HeroModel(nome: 'pikapau', data: DateTime.now().toString()),
    HeroModel(nome: 'tunizio', data: DateTime.now().toString()),
    HeroModel(nome: 'super chock', data: DateTime.now().toString()),
  ];

  checkFavorito(HeroModel model) {
    model.isFavorite = !model.isFavorite;
    this.notifyListeners();
  }

  add(HeroModel model) {
    heroes.add(model);
    this.notifyListeners();
  }

  remove(HeroModel model) {
    heroes.remove(model);
    this.notifyListeners();
  }
}
