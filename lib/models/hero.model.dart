class HeroModel {
  String nome;
  bool isFavorite;
  String data;
  String tecnico;

  HeroModel(
      {this.nome,
      this.isFavorite = false,
      this.data = '12/09/2222',
      this.tecnico = "anderson"});
}
