import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:http/http.dart' as http;

class Pokemon {
  int id;
  String name;
  String img; 

  Pokemon.fromJson(Map<String, dynamic> data)
    : id = data['id'],
      name = data['name'],
      img = data['img'];    
    
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'img': img};
}

// class PokemonSpecies {

//   int? id;
//   String? name;
//   String? img;
//   int? capture_rate;
//   int? base_happiness;
// }

class PokeService extends ChangeNotifier{
  bool isLoading = true;
  bool isLoadingPokemon = false;
  PokemonSpecies? currentPokemon;
  List<Pokemon> pokemons = [];
  List<Pokemon> favorite = [];
  List<Pokemon> caught = [];

  void getPokemons() async {
    var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=-1"));
    List<Map<String, dynamic>> data = List.from(jsonDecode(response.body)['results']);
    pokemons = data.asMap().entries.map<Pokemon>((element) {
                element.value['id'] = element.key + 1;
                element.value['img'] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
                return Pokemon.fromJson(element.value);
            }).toList();
    print("Done");
    isLoading = false;
    notifyListeners();
  }  

  // void loadPokemon(int id) async {
  //   isLoadingPokemon = true;
  //   notifyListeners();
  //   final dex = Pokedex();
  //   currentPokemon = await dex.pokemonSpecies.get(id: id);
  //   print(currentPokemon!.formDescriptions.isEmpty);
  //   isLoadingPokemon = false;
  //   notifyListeners();
  // }

  void loadPokemon(int id) async {
    isLoadingPokemon = true;
    notifyListeners();

    final pokedex = Pokedex();
    PokemonSpecies poke = await pokedex.pokemonSpecies.get(id: id);
    print(poke.flavorTextEntries.first.flavorText);
    currentPokemon = poke;
    // var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon-species/$id"));
    // Map<String, dynamic> data = jsonDecode(response.body);
    // currentPokemon!.id = data['id'];
    // currentPokemon!.name = data['name'];
    // currentPokemon!.capture_rate = data['capture_rate'];
    // currentPokemon!.base_happiness = data['base_happiness'];
    // // currentPokemon!.description = 
    isLoadingPokemon = false;
    notifyListeners();
  }
}