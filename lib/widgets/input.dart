import 'dart:math';

import 'package:flutter/material.dart';

const List<String> livros = [
  "Dom Quixote",
  "Cem Anos de Solidão",
  "1984",
  "O Pequeno Príncipe",
  "O Senhor dos Anéis",
  "A Bíblia",
  "Harry Potter e a Pedra Filosofal",
  "O Alquimista",
  "Orgulho e Preconceito",
  "Matar um Rouxinol",
  "A Revolução dos Bichos",
  "A Divina Comédia",
  "Crime e Castigo",
  "Ensaio sobre a Cegueira",
  "O Grande Gatsby",
  "Ulisses",
  "O Sol é para Todos",
  "Cem Anos de Solidão",
  "Lolita",
  "O Apanhador no Campo de Centeio",
  "Os Miseráveis",
  "Moby Dick",
  "1984",
  "O Leão, a Feiticeira e o Guarda-Roupa",
  "O Código Da Vinci",
  "A Menina que Roubava Livros",
  "Harry Potter e as Relíquias da Morte",
  "O Hobbit",
  "Anna Karenina",
  "O Nome da Rosa",
  "O Senhor das Moscas",
  "O Silmarillion",
  "O Iluminado",
  "O Caçador de Pipas",
  "O Médico e o Monstro",
  "O Retrato de Dorian Gray",
  "O Morro dos Ventos Uivantes",
  "As Crônicas de Nárnia",
  "O Processo",
  "O Velho e o Mar",
  "O Poderoso Chefão",
  "A Metamorfose",
  "Memórias Póstumas de Brás Cubas",
  "O Homem Invisível",
  "O Lobo da Estepe",
  "O Exorcista",
  "O Perfume",
  "O Estrangeiro",
  "O Cão dos Baskervilles",
  "O Coração das Trevas",
];

class AutoCompleteInput extends StatelessWidget {
  const AutoCompleteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return Center(
          child: SizedBox(
            width: 250,
            height: 50,
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: '${livros[Random().nextInt(49)]}...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: const Icon(Icons.clear),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return livros.where((String option) {
          return option.contains(textEditingValue.text);
        });
      },
    );
  }
}
