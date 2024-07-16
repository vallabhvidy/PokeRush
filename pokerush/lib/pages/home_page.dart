import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokerush/pokeservice.dart';
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
      body: Consumer<PokeService>(builder:(context, poke, child) {
        Provider.of<PokeService>(context, listen: false).getPokemons();
        if (poke.isLoading) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: 10,
            itemBuilder:(context, index) {
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(poke.pokemons[index].img),),
                title: Text(poke.pokemons[index].name));
            },);
        }
      },),
    );
  }
}