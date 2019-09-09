class HeroModel {
  String nome;
  bool isFavorite;
  String data;
  String tecnico;
  String cliente;

  HeroModel({
    this.nome,
    this.isFavorite = false,
    this.data,
    this.tecnico = "anderson",
    this.cliente = 'default',
  });
}
