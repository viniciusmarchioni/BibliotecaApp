class Sujestoes {
  String nome;

  Sujestoes({required this.nome});

  factory Sujestoes.fromJson(String json) {
    return Sujestoes(nome: json);
  }
}

class Livro {
  String titulos;
  var autores = [];
  String sinopse;
  String tema;

  Livro(
      {required this.titulos,
      required this.autores,
      required this.sinopse,
      required this.tema});
}

class Biblioteca {
  String nome;
  String endereco;
  List livros = [];

  Biblioteca(
      {required this.nome, required this.endereco, required this.livros});
}
