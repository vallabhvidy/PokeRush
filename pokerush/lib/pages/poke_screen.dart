import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pokerush/pokeservice.dart';
import 'package:provider/provider.dart';
import 'package:pokerush/widgets/poke_button.dart';

class PokeScreen extends StatelessWidget {

  final Pokemon pokemon;
  final TextStyle monospace = TextStyle(fontFamily: "monospace",
  fontFamilyFallback: <String>["Courier"], fontSize: 22, fontWeight: FontWeight.bold);
  PokeScreen({super.key, required this.pokemon});


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
    backgroundColor: Colors.grey[300],
      appBar: AppBar(

        title: Text("${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1).toLowerCase()}",
           style: monospace,

        
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {
              Provider.of<PokeService>(context, listen: false).toggleFavourite(pokemon.id);
            }, 
            icon: Icon(Provider.of<PokeService>(context).favouritesIcon(pokemon.id))),
          )
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Consumer<PokeService>(
        builder: (context, value, child) {
          if (value.currentPokemon == null) {
            if (value.internet) {
              return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.white, size: 50));
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
            return Column(
              children: [
                SizedBox(height:10),
                Expanded(

                  child: Stack(
                    children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('lib/images/pokeball.png', color: Colors.grey[400],),
                    ),
                    Hero(
                      tag: pokemon.img,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                      
                        child: CachedNetworkImage(imageUrl: pokemon.img),
                      ),
                    ),
                    ]

                  )
                ),
                // ListTile(
                //   leading: Text("Name:"),
                  //title: Text(value.currentPokemon!.formDescriptions.single.description),
             //   ),\
                  
                //  Divider(
                //   thickness: 0.8,
                //   color: Colors.grey[500],
                //  ),

                 Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[

                      SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[

                            Container(
                              width: width * 0.46,
                              child: Text("Name",

                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),

                            Container(
                              width : width * 0.35,
                              child: Text("${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1).toLowerCase()}",
                              style: monospace,

                            ),),
                          ],
                        ),
                      ),
            
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[

                            Container(
                              width: width * 0.46,
                              child: Text("Happiness",

                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),

                            Container(
                              width : width * 0.35,
                              child: Text(value.currentPokemon!.baseHappiness.toString(),
                              style: monospace,

                            ),),
                          ],
                        ),
                      ),
            
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[

                            Container(
                              width: width * 0.46,
                              child: Text("Color",

                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),

                            Container(
                              width : width * 0.35,
                              child: Text("${value.currentPokemon!.color.toJson()['name'][0].toUpperCase()}${value.currentPokemon!.color.toJson()['name'].toUpperCase().substring(1).toLowerCase()}",
                              style: monospace,

                            ),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[

                            Container(
                              width: width * 0.46,
                              child: Text("ID",

                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),

                            Container(
                              width : width * 0.35,
                              child: Text(value.currentPokemon!.id.toString(),
                              style: monospace,

                            ),),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[

                            Container(
                              width: width * 0.46,
                              child: Text("Generation",

                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),

                            Container(
                              width : width * 0.35,
                              child: Text(value.currentPokemon!.generation.toJson()['name'].toString().substring(11).toUpperCase(),
                              style: monospace,

                            ),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[

                            Container(
                              width: width * 0.46,
                              child: Text("Height",

                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),

                            Container(
                              width : width * 0.35,
                              child: Text((value.currPokemon!.height*10).toString()+" cm",
                              style: monospace,
                            ),),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[

                            Container(
                              width: width * 0.46,
                              child: Text("Weight",

                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),

                            Container(                     
                              width : width * 0.35,
                              child: Text((value.currPokemon!.weight/10).toString()+" kg",
                              style: monospace,
                            ),),

                            // SizedBox(
                            //   width : width * 0.3,
                            //   child: Text("${value.currPokemon!.weight/10} kg",
                            //   style:monospace
                            // ),),

                          ],
                        ),
                      ),
                      
                      SizedBox(height:4),

                      MyButton(
                        onTap: () {} 
                      ),
                    ],
                  ),
                  
                 ),
              ],
            );
          }
        },
      ),
    );
  }
}