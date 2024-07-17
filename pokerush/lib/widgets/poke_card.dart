import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:pokerush/pokeservice.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokeCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Color.fromRGBO(255, 253, 208, 1.0),
      // color: Color.fromRGBO(255, 253, 208, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
              child: CachedNetworkImage(imageUrl: pokemon.img,),
            ),
          ),
          Text("${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1).toLowerCase()}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6,)
        ],
      ),
    );
  }
}
