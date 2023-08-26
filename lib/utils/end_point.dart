class EndPoints {
  static String baseUrl = 'https://pokeapi.co/api/v2';
  static String pokemonCardsUrl = 'https://api.pokemontcg.io/v1/cards/';

  static int pokemonLimit = 10;
  static int pokemonOffset = 0;

  static String pokemonListEndPoint() {
    return '$baseUrl/pokemon?limit=$pokemonLimit&offset=$pokemonOffset';
  }

  static String pokemonEndPoint(int pokemonId) {
    return '$baseUrl/pokemon/$pokemonId';
  }

  static String pokemonSpeciesEndPoint(int speciesId) {
    return '$baseUrl/pokemon-species/$speciesId';
  }

  static String getImage(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png';
  }
}
