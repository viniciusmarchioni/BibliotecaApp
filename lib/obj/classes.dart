class Sujestoes {
  String nome;

  Sujestoes({required this.nome});

  factory Sujestoes.fromJson(String json) {
    return Sujestoes(nome: json);
  }
}
