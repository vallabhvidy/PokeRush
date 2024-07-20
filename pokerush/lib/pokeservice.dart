import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  IconData icon = Icons.favorite_border;

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

  List<Pokemon> byColor = [];
  String? colorvalue = "all colors";
  // List<Map<String, Color>> colors = [
  //   {"Colors": Colors.black},
  //   {"Black": Colors.black},
  //   {"Blue": Colors.blue},
  //   {"Brown": Colors.brown},
  //   {"Grey": Colors.grey},
  //   {"Green": Colors.green},
  //   {"Pink": Colors.pink},
  //   {"Purple": Colors.purple},
  //   {"Red": Colors.red},
  //   {"White": Colors.black},
  //   {"Yellow": Colors.yellow},
  // ];
  List<String> colors = [
    "All Colors",
    "Black",
    "Blue",
    "Brown",
    "Gray",
    "Green",
    "Pink",
    "Purple",
    "Red",
    "White",
    "Yellow",
  ];

  List<Pokemon> byGen = [];
  String? genvalue = "all gens";
  List<String> gens = [
    "All Gens",
    "I",
    "II",
    "III",
    "IV",
    "V",
    "VI",
    "VII",
    "VIII",
    "IX",
  ];
  Map<String, int> romtoint = {"i": 1, "ii": 2, "iii": 3, "iv": 4, "v": 5, "vi": 6, "vii": 7, "viii": 8, "ix": 9};

  List<Pokemon> byType = [];
  String? typevalue = "all types";
  List<String> types = [
    "All Types",
    "Fire",
    "Water",
    "Grass",
    "Electric",
    "Dragon",
    "Fairy",
    "Rock",
    "Ground",
    "Normal",
    "Ghost",
    "Bug",
    "Fighting",
    "Poison",
    "Ice",
    "Psychic",
    "Dark",
    "Flying",
    "Steel"
  ];

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
      final pokedex = dex.Pokedex();
      currentPokemon = await pokedex.pokemonSpecies.get(id: id);
      currPokemon = await pokedex.pokemon.get(id: id);
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

  void filterColor() async {
    List<Pokemon> list = pokemons;
    bool result = await InternetConnectionCheckerPlus().hasConnection;
    if (result) {
      if (colorvalue != "all colors") {
        byColor = [];
        var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon-color/${colorvalue!.toLowerCase()}/"));
        List<Map<String, dynamic>> data = List.from(jsonDecode(response.body)["pokemon_species"]);
        for (var i in data) {
          var strid = i['url'].toString().substring(42).replaceAll(new RegExp(r'[^0-9]'),'');
          var id = int.parse(strid);
          if (id > 1000) break;
          if (pokemons.contains(allPokemons[id-1])) {
            byColor.add(allPokemons[id-1]);
          }
        }
        pokemons = byColor;
        notifyListeners();
      } else {
        pokemons = allPokemons;
        notifyListeners();
      }
    } else {
      internet = false;
      notifyListeners();
    }

  }

  void filterGen() async {
    List<Pokemon> list = pokemons;
    bool result = await InternetConnectionCheckerPlus().hasConnection;
    if (result) {
      if (genvalue != "all gens") {
        byGen = [];
        var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/generation/${romtoint[genvalue]}/"));
        List<Map<String, dynamic>> data = List.from(json.decode(response.body)["pokemon_species"]);
        for (var i in data) {
          var strid = i['url'].toString().substring(42).replaceAll(new RegExp(r'[^0-9]'),'');
          var id = int.parse(strid);
          if (id > 1000) break;
          if (pokemons.contains(allPokemons[id-1])) {
            byGen.add(allPokemons[id-1]);
          }
        }
        pokemons = byGen;
        notifyListeners();
      } else {
        pokemons = allPokemons;
        notifyListeners();
      }
    } else {
      internet = false;
      notifyListeners();
    }

  }

  void filterType() async {
    List<Pokemon> list = pokemons;
    bool result = await InternetConnectionCheckerPlus().hasConnection;
    if (result) {
      if (typevalue != "all types") {
        byType = [];
        var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/type/${typevalue}/"));
        List<Map<String, dynamic>> data = List.from(json.decode(response.body)['pokemon']);
        print(data[0]);
        for (var i in data) {
          var strid = i['pokemon']['url'].toString().substring(32).replaceAll(new RegExp(r'[^0-9]'),'');
          var id = int.parse(strid);
          if (id > 1000) break;
          if (pokemons.contains(allPokemons[id-1])) {
            byType.add(allPokemons[id-1]);
          }
        }
        pokemons = byType;
        notifyListeners();
      } else {
        pokemons = allPokemons;
        notifyListeners();
      }
    } else {
      internet = false;
      notifyListeners();
    }

  }

  void toggleFavourite(int id) {
    if (favourites.contains(allPokemons[id-1])) {
      favourites.remove(allPokemons[id-1]);
    } else {
      favourites.add(allPokemons[id-1]);
    }
    notifyListeners();
  }

  IconData favouritesIcon(int id) {
    if (favourites.contains(allPokemons[id-1])) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }
}