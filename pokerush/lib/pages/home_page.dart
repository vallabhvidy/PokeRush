import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<PokemonSpecies> pokemons = [];

  Future getPokemons() async {
    var dex = Pokedex();
    for (int i=0; i < 10; i++) {
      pokemons.add(await dex.pokemonSpecies.get(id: i+1));
      print(pokemons[i].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(top: 11),
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
      body: FutureBuilder(future: getPokemons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder:(context, index) {
            return ListTile(title: Text(pokemons[index].name),);
          },);
        } else {
          return CircularProgressIndicator();
        }},),
    );
  }
}