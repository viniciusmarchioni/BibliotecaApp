class Sujestoes {
  String nome;

  Sujestoes({required this.nome});

  factory Sujestoes.fromJson(String json) {
    return Sujestoes(nome: json);
  }
}

class Livro {
  bool isLivro = true;
  String imageUrl = '';
  String titulo;
  String autores;
  String sinopse;
  String tema;

  Livro(
      {required this.isLivro,
      required this.imageUrl,
      required this.titulo,
      required this.autores,
      required this.sinopse,
      required this.tema});

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      titulo: json['titulo'],
      autores: json['autores'],
      sinopse: json['sinopse'],
      tema: json['tema'],
      imageUrl: json['image'],
      isLivro: true,
    );
  }
}

class Biblioteca {
  String nome;
  String endereco;

  Biblioteca({required this.nome, required this.endereco});

  Livro cast() {
    return Livro(
        imageUrl:
            'https://pbs.twimg.com/media/GGxpGBKXAAAkdwf?format=jpg&name=small',
        titulo: nome,
        autores: endereco,
        sinopse: 'Biblioteca',
        tema: '',
        isLivro: false);
  }

  factory Biblioteca.fromJson(Map<String, dynamic> json) {
    return Biblioteca(
      nome: json['nome'],
      endereco: json['endereco'],
    );
  }
}
