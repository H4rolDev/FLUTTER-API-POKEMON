// lib/models/pokemon.dart

class Pokemon {
  final String name;
  final String url;
  final String id;

  Pokemon({required this.name, required this.url, required this.id});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final List<String> urlParts = (json['url'] as String).split('/');
    final String id = urlParts[urlParts.length - 2];
    return Pokemon(name: json['name'], url: json['url'], id: id);
  }
}

class PokemonDetails {
  final String name;
  final String id;
  final int height;
  final int weight;
  final List<String> types;

  PokemonDetails({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    final List<String> types = (json['types'] as List)
        .map((type) => type['type']['name'] as String)
        .toList();
    return PokemonDetails(
      name: json['name'],
      id: json['id'].toString(),
      height: json['height'],
      weight: json['weight'],
      types: types,
    );
  }
}