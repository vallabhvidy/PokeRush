import 'package:flutter/material.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:pokerush/widgets/poke_card.dart';
import 'package:provider/provider.dart';


class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(top: 9),
          child: Text("F A V O U R I T E S", style: TextStyle(fontSize: 20),)
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<PokeService>(builder: (context, value, child) {
        if (value.favourites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Image.asset("lib/images/EmptyBox.png", height: 225,)),
                const Padding(padding: EdgeInsets.all(8.0), child: Text("E M P T Y", style: TextStyle(fontSize: 24, color: Colors.grey)),)
              ],
            ),
          );
        } else {
          return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6.0, crossAxisSpacing: 6.0), 
              padding: const EdgeInsets.all(12.0),
              itemCount: value.favourites.length,
              itemBuilder: (context, index) {
                return PokeCard(pokemon: value.favourites[index],);
              },
            );
        }
      },)
    );
  }
}
