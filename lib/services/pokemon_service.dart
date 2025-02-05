// lib/services/pokemon_service.dart

import 'package:dio/dio.dart';
import '../models/pokemon.dart';

class PokemonService {
  final Dio _dio = Dio();

  Future<List<Pokemon>> fetchPokemons() async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon');
      final List<dynamic> results = response.data['results'];
      return results.map((json) => Pokemon.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<PokemonDetails> fetchPokemonDetails(String url) async {
    try {
      final response = await _dio.get(url);
      return PokemonDetails.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load pokemon details');
    }
  }
}