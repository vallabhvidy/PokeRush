import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart' as dex;
import 'package:pokerush/pokeservice.dart';
import 'package:provider/provider.dart';

class PokeScreen extends StatelessWidget {
  Pokemon pokemon; 
  PokeScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
    backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(pokemon.name,
           style: TextStyle(fontWeight: FontWeight.w600,
                  fontSize: 22,
           )
        
        ),
        backgroundColor: Colors.transparent,

        centerTitle: true,
      ),
      body: Consumer<PokeService>(
        builder: (context, value, child) {
          if (value.currentPokemon == null) {
            return CircularProgressIndicator();
          } else {
            return ListView(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(imageUrl: pokemon.img),
                  )
                ),
                // ListTile(
                //   leading: Text("Name:"),
                  //title: Text(value.currentPokemon!.formDescriptions.single.description),
             //   ),\
                  
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Container(
                              width: width * 0.3,
                              child: Text("Name",
                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),
                            Container(
                              width : width * 0.3,
                              child: Text(value.currentPokemon!.name,
                              style: TextStyle(
                                color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold,
                              ),
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
                              width: width * 0.3,
                              child: Text("Happiness",
                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),
                            Container(
                              width : width * 0.3,
                              child: Text(value.currentPokemon!.baseHappiness.toString(),
                              style: TextStyle(
                                color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold,
                              ),
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
                              width: width * 0.3,
                              child: Text("Color",
                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),
                            Container(
                              width : width * 0.3,
                              child: Text(value.currentPokemon!.color.toJson()['name'],
                              style: TextStyle(
                                color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold,
                              ),
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
                              width: width * 0.3,
                              child: Text("Capture rate",
                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),
                            Container(
                              width : width * 0.3,
                              child: Text(value.currentPokemon!.captureRate.toString(),
                              style: TextStyle(
                                color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold,
                              ),
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
                              width: width * 0.3,
                              child: Text("Generation",
                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),
                            Container(
                              width : width * 0.3,
                              child: Text(value.currentPokemon!.generation.toJson()['name'].toString().substring(11),
                              style: TextStyle(
                                color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold,
                              ),
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
                              width: width * 0.3,
                              child: Text("Height",
                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),
                            Container(
                              width : width * 0.3,
                              child: Text((value.currPokemon!.height*10).toString()+" cm",
                              style: TextStyle(
                                color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold,
                              ),
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
                              width: width * 0.3,
                              child: Text("Weight",
                              style: TextStyle(
                                color:Colors.blueGrey, fontSize: 19,
            
            
                              ),
                              ),
                            ),
                            Container(
                              width : width * 0.3,
                              child: Text((value.currPokemon!.weight/10).toString()+" kg",
                              style: TextStyle(
                                color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold,
                              ),
                            ),),
                          ],
                        ),
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