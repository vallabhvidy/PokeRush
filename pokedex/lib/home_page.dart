import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'pokemon.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<PokemonSpecies> poke_list= [];

  Future getPokemon() async {
    final pokedex = Pokedex();
    final aegislash = await pokedex.pokemonSpecies.get(name: 'aegislash');
    print(aegislash.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pokeDex'),
      ),
      body: FutureBuilder(future: getPokemon(),
      builder: (context, snapshot) {
        return Center(child: Text("Hello World"),);
      },)
    );
  }
}