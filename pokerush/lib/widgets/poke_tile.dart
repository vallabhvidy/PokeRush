import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokerush/pokeservice.dart';

class PokeTile extends StatelessWidget {
  final Pokemon pokemon;
  const PokeTile({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,      
      margin: const EdgeInsets.all(2.0),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
            child: CachedNetworkImage(
              imageUrl: pokemon.img,
              height: 100,
            ),
          ),
          const SizedBox(width: 20,),
          Text(pokemon.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50,),),
          const SizedBox(width: 20,),
        ],
      )
    );
  }
}
