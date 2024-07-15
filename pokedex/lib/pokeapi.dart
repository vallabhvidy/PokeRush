// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:digidex/pokemon.dart';

// class PokeAPI {

//   static Future<List<Pokemon>> getPokemonByCount(int count) async {
//     var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=$count"));
//     List<Map<String, dynamic>> data = List.from(jsonDecode(response.body)['results']);
//     List<Pokemon> poke_list = data.asMap().entries.map<Pokemon>((element) {
//       element.value['id'] = element.key + 1;
//       element.value['img'] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
//       return Pokemon.fromJson(element.value);
//       }).toList();

//     print(poke_list[0].ability);
//     return poke_list;
//   }
  
//   static Future<Pokemon> getPokemonInfo(Pokemon pokemon) async {
//     var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/${pokemon.id}"));
//     int weight = int.parse();
//   }

// }