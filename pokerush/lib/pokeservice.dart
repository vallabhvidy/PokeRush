import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart' as dex;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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
  bool internet = true;
  bool pokemonLoaded = false;
  bool isLoading = true;
  bool isLoadingPokemon = false;
  dex.PokemonSpecies? currentPokemon;
  dex.Pokemon? currPokemon;
  List<Pokemon> pokemons = [];
  List<Pokemon> favourites = [];
  List<Pokemon> allPokemons = [];
  List<Pokemon> caught = [];
  bool showSearchBar = false;

  void getPokemons() async {
    bool result = await InternetConnectionCheckerPlus().hasConnection;
    if (result) {
      var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=1000"));
      List<Map<String, dynamic>> data = List.from(jsonDecode(response.body)['results']);
      allPokemons = data.asMap().entries.map<Pokemon>((element) {
                  element.value['id'] = element.key + 1;
                  element.value['img'] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
                  return Pokemon.fromJson(element.value);
              }).toList();
      print("Done");
      pokemons = allPokemons;
      isLoading = false;
      notifyListeners();
    } else {
      internet = false;
      notifyListeners();
    }

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
  bool result = await InternetConnectionCheckerPlus().hasConnection;
    if (result) {
      final pokedex = Pokedex();
      currentPokemon = await pokedex.pokemonSpecies.get(id: id);
      isLoadingPokemon = false;
      notifyListeners();
    } else {
      internet = false;
      notifyListeners();
    }
  }

  void toggleSearch() {
    showSearchBar = !showSearchBar;
    notifyListeners();
  }

  void runSearch(String keyword) {
    pokemons = [];
    if (keyword.isEmpty) {
      pokemons = allPokemons;
    } else {
      pokemons = allPokemons.where((pokemon) => pokemon.name.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    notifyListeners();
  }
  void addToFavourites() {
    favourites.add(allPokemons[currentPokemon!.id - 1]);

    notifyListeners();
  }
}