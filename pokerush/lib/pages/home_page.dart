import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pokerush/pages/favourites_page.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:pokerush/widgets/poke_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.all(8),
          child: Image(
            image: AssetImage('lib/images/PokeRush.png'),
            height: 66,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(onPressed: () {
          Provider.of<PokeService>(context, listen: false).toggleSearch();
        },
        icon: const Icon(Icons.search)), const SizedBox(width: 11)],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[300],
          child: ListView(
            children: [
              DrawerHeader(child: Icon(Icons.catching_pokemon, size: 100,),),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text("F A V O U R I T E S", style: TextStyle(fontSize: 20),),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavouritesPage(),));
                },
              )
            ],
          ),
        ),
      ),
      body: Consumer<PokeService>(builder:(context, poke, child) {
        if (poke.isLoading) {
          Provider.of<PokeService>(context, listen: false).getPokemons();
          if (poke.internet) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(color: Colors.white, size: 100),
            );
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
          if (poke.showSearchBar) {
            return Column(children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SearchBar(
                  elevation: WidgetStatePropertyAll(3),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search_rounded),
                  ),
                  onChanged: (value) => poke.runSearch(value),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6.0, crossAxisSpacing: 6.0), 
                padding: const EdgeInsets.all(12.0),
                itemCount: poke.pokemons.length,
                itemBuilder: (context, index) {
                  return PokeCard(pokemon: poke.pokemons[index],);
                },
              ))
            ],);
          } else {
            return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6.0, crossAxisSpacing: 6.0), 
              padding: const EdgeInsets.all(12.0),
              itemCount: poke.pokemons.length,
              itemBuilder: (context, index) {
                return PokeCard(pokemon: poke.pokemons[index],);
              },
            );
          }
        }
      },),
    );
  }
}