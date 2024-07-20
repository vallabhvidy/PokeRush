import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pokerush/pages/favourites_page.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:pokerush/widgets/poke_card.dart';
import 'package:provider/provider.dart';
// import 'package:pokerush/widgets/poke_chip.dart';

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
        icon: const Icon(Icons.search)), const SizedBox(width: 11),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[300],
          child: ListView(
            children: [
              const DrawerHeader(child: Icon(Icons.catching_pokemon, size: 100,),),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text("F A V O U R I T E S", style: TextStyle(fontSize: 20),),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FavouritesPage(),));
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
              child: LoadingAnimationWidget.inkDrop(color: Colors.white, size: 50),
            );
          } else {
            return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('lib/images/NoInternet.gif'),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text("N O  I N T E R N E T", style: TextStyle(fontSize: 20),),
                  )
                ],
              ),); 
          }
        } else {
          if (poke.showSearchBar) {
            return Column(children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(4.0),  // 8
                child: SearchBar(
                  elevation: const WidgetStatePropertyAll(1),
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),       // 8
                    child: Icon(Icons.search_rounded),
                  ),
                  onChanged: (value) => poke.runSearch(value),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Chip(label: DropdownButton<String>(
                      isDense: true,
                      hint: Text("Colors"),
                      value: poke.colorvalue,
                      items: poke.colors.map((String color) {
                        return DropdownMenuItem(child: Text(color), value: color.toLowerCase(),);
                      }).toList(),
                      onChanged: (String? color) {
                        poke.colorvalue = color;
                        poke.filterColor();
                      } ,
                    )),
                    SizedBox(width: 15,),
                    Chip(label: DropdownButton<String>(
                      isDense: true,
                      hint: Text("Generations"),
                      value: poke.genvalue,
                      items: poke.gens.map((String gen) {
                        return DropdownMenuItem(child: Text(gen), value: gen.toLowerCase(),);
                      }).toList(),
                      onChanged: (String? gen) {
                        poke.genvalue = gen;
                        poke.filterGen();
                      } ,
                    )),
                    SizedBox(width: 15,),
                    Chip(label: DropdownButton<String>(
                      isDense: true,
                      hint: Text("Types"),
                      value: poke.typevalue,
                      items: poke.types.map((String type) {
                        return DropdownMenuItem(child: Text(type), value: type.toLowerCase(),);
                      }).toList(),
                      onChanged: (String? type) {
                        poke.typevalue = type;
                        poke.filterType();
                      } ,
                    )),
                  ],
                ),
              ),
              SizedBox(height: 4),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //   FilterChipDropdown(
              //     items: [
              //       FilterChipItem(label: "Black", value: "black"),
              //       FilterChipItem(label: "Blue", value: "blue"),
              //       FilterChipItem(label: "Brown", value: "brown"),
              //       FilterChipItem(label: "Green", value: "green"),
              //       FilterChipItem(label: "Gray", value: "gray"),
              //       FilterChipItem(label: "Pink", value: "pink"),
              //       FilterChipItem(label: "Purple", value: "purple"),
              //       FilterChipItem(label: "Red", value: "red"),
              //       FilterChipItem(label: "White", value: "white"),
              //       FilterChipItem(label: "Yellow", value: "yellow"),
              //     ],
              //     initialLabel: "Color",
              //     unselectedColor: Colors.white,
              //     unselectedLabelColor: Colors.black,
              //     selectedColor: Colors.blue,
              //     selectedLabelColor: Colors.white,
              //     onSelectionChanged: (selected) {
              //       poke.colorvalue = selected;
              //       poke.filterColor();
              //     }
              //     )
              // ],),
              Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6.0, crossAxisSpacing: 6.0), 
                padding: const EdgeInsets.all(12.0),
                scrollDirection: Axis.vertical,
                itemCount: poke.pokemons.length,
                itemBuilder: (context, index) {
                  return PokeCard(pokemon: poke.pokemons[index],);
                },
              ))
            ],);
          } else {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6.0, crossAxisSpacing: 6.0), 
                    padding: const EdgeInsets.all(12.0),      // 12
                    scrollDirection: Axis.vertical,
                    itemCount: poke.pokemons.length,
                    itemBuilder: (context, index) {
                      return PokeCard(pokemon: poke.pokemons[index],);
                    },
                  ),
                ),
              ],
            );
          }
        }
      },),
    );
  }
}