import 'package:flutter/material.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:pokerush/widgets/poke_card.dart';
import 'package:pokerush/widgets/poke_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(top: 9),
          child: Image(
            image: AssetImage('lib/images/PokeRush.png'),
            height: 66,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search)), SizedBox(width: 11)],
      ),
      drawer: Drawer(),
      body: Consumer<PokeService>(builder:(context, poke, child) {
        Provider.of<PokeService>(context, listen: false).getPokemons();
        if (poke.isLoading) {
          return CircularProgressIndicator();
        } else {
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6.0, crossAxisSpacing: 6.0), 
            padding: EdgeInsets.all(12.0),
            itemCount: poke.pokemons.length,
            itemBuilder: (context, index) {
              return PokeCard(pokemon: poke.pokemons[index],);
            },
          );
        }
      },),
    );
  }
}