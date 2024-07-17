import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          return ListView.builder(
            itemCount: poke.pokemons.length,
            itemBuilder:(context, index) {
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: poke.pokemons[index].img,
                  progressIndicatorBuilder: (context, url, downloadProgress) => 
                          CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 50,
                ),
                title: Text(poke.pokemons[index].name));
            },);
        }
      },),
    );
  }
}