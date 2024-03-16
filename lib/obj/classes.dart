class Sujestoes {
  String nome;

  Sujestoes({required this.nome});

  factory Sujestoes.fromJson(String json) {
    return Sujestoes(nome: json);
  }
}

class Livro {
  String titulo;
  String autores;
  String sinopse;
  String tema;

  Livro(
      {required this.titulo,
      required this.autores,
      required this.sinopse,
      required this.tema});

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      titulo: json['titulo'],
      autores: json['autores'],
      sinopse: json['sinopse'],
      tema: json['tema'],
    );
  }
}

class Biblioteca {
  String nome;
  String endereco;
  List livros = [];

  Biblioteca(
      {required this.nome, required this.endereco, required this.livros});
}
