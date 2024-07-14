import 'package:flutter/material.dart';
import 'pokeapi.dart';
import 'pokemon.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Pokemon> poke_list= [];

  Future getPokemon() async {
    poke_list = await PokeAPI.getPokemonByCount(20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pokeDex'),
      ),
      body: FutureBuilder(future: getPokemon(),
      builder: (context, snapshot) {
        // if done loading
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: poke_list.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Text(poke_list[index].name.toString())
            );
          },);
        } else {
          // if still loading
          return CircularProgressIndicator.adaptive();
        }
      },)
    );
  }
}