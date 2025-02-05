import 'package:app1/services/pokemon_service.dart';
import 'package:app1/utils/pokemon_theme.dart';
import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class DetailPage extends StatefulWidget {
  final Pokemon pokemon;

  DetailPage({required this.pokemon});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<PokemonDetails> futurePokemonDetails;
  final PokemonService _pokemonService = PokemonService();

  @override
  void initState() {
    super.initState();
    futurePokemonDetails = _pokemonService.fetchPokemonDetails(widget.pokemon.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name.toUpperCase(), style: TextStyle(color: Colors.white)),
        backgroundColor: PokemonTheme.getColorFromId(widget.pokemon.id),
        elevation: 10,
      ),
      body: FutureBuilder<PokemonDetails>(
        future: futurePokemonDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No se encontraron detalles'));
          } else {
            final pokemonDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: PokemonTheme.getGradientFromId(widget.pokemon.id),
                    ),
                    child: Center(
                      child: Hero(
                        tag: widget.pokemon.id,
                        child: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${widget.pokemon.id}.png',
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${widget.pokemon.id}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Nombre: ${widget.pokemon.name}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Altura: ${pokemonDetails.height / 10} m',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Peso: ${pokemonDetails.weight / 10} kg',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tipos: ${pokemonDetails.types.join(", ")}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estadísticas Simuladas',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              _buildStat('HP', 80),
                              _buildStat('Ataque', 90),
                              _buildStat('Defensa', 70),
                              _buildStat('Velocidad', 60),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStat(String label, int value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(PokemonTheme.getColorFromId(widget.pokemon.id)),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$value',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}