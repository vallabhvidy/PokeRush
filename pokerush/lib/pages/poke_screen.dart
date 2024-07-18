import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart' as dex;
import 'package:pokerush/pokeservice.dart';
import 'package:provider/provider.dart';

class PokeScreen extends StatelessWidget {
  Pokemon pokemon; 
  PokeScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        centerTitle: true,
      ),
      body: Consumer<PokeService>(
        builder: (context, value, child) {
          if (value.currentPokemon == null) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(imageUrl: pokemon.img),
                  )
                ),
                ListTile(
                  leading: Text("Name:"),
                  //title: Text(value.currentPokemon!.formDescriptions.single.description),
                )
              ],
            );
          }
        },
      ),
    );
  }
}