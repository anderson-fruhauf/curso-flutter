import 'package:flutter/widgets.dart';
import 'package:flutter_curso/models/hero.model.dart';

class HeroesController extends ChangeNotifier {
  List<HeroModel> heroes = [
    HeroModel(nome: 'patati', isFavorite: true),
    HeroModel(nome: 'patata', tecnico: 'anderson'),
    HeroModel(nome: 'pikapau'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'super chock'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'tunizio'),
    HeroModel(nome: 'tunizio'),
  ];

  checkFavorito(HeroModel model) {
    model.isFavorite = !model.isFavorite;
    this.notifyListeners();
  }
}
