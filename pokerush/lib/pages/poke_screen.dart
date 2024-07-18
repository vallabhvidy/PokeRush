import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pokedex/pokedex.dart' as dex;
import 'package:pokerush/pokeservice.dart';
import 'package:provider/provider.dart';

class PokeScreen extends StatelessWidget {
  Pokemon pokemon; 
  PokeScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300] ,
      appBar: AppBar(
        title: Text(pokemon.name),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Consumer<PokeService>(
        builder: (context, value, child) {
          if (value.currentPokemon == null) {
            if (value.internet) {
              return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.white, size: 100));
            } else {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('lib/images/NoInternet.gif'),
                  const Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("N O  I N T E R N E T", style: TextStyle(fontSize: 20),),
                  )
                ],
              ),); 
            }
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
                  title: Text(value.currentPokemon!.name),
                )
              ],
            );
          }
        },
      ),
    );
  }
}