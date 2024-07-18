import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokerush/pages/poke_screen.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:provider/provider.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokeCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PokeService>(context, listen: false).loadPokemon(pokemon.id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokeScreen(pokemon: pokemon)
          )
        );
      },
      child: Card(
        surfaceTintColor: const Color.fromRGBO(255, 253, 208, 1.0),
        // color: Color.fromRGBO(255, 253, 208, 1.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                child: CachedNetworkImage(imageUrl: pokemon.img, ),
              ),
            ),
            Text("${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1).toLowerCase()}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6,)
          ],
        ),
      ),
    );
  }
}
