
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

class PokeService extends ChangeNotifier{
  bool isLoading = true;
  List<Pokemon> pokemons = [];
  PokemonSpecies? currentPokemon;

  void getPokemons() async {
    var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=-1"));
    List<Map<String, dynamic>> data = List.from(jsonDecode(response.body)['results']);
    pokemons = data.asMap().entries.map<Pokemon>((element) {
                element.value['id'] = element.key + 1;
                element.value['img'] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
                return Pokemon.fromJson(element.value);
            }).toList();
    isLoading = false;
    notifyListeners();
  }

  getPokemonSpecies(int id) async {
    isLoading = true;
    notifyListeners();
    final dex = Pokedex();
    final pokemon = await dex.pokemonSpecies.get(id: id);
    currentPokemon = pokemon;
  }
}