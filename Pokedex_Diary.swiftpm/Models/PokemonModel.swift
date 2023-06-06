import SwiftUI

class SharedData {
    static let sharedDatabase = SharedData()
    var pokemonDatabase = PokemonViewModel()
}

struct Evolution: Decodable, Identifiable {
    let id: String
    let name: String
}

struct Pokemon: Identifiable, Decodable {
    let pokemonID = UUID() // AKA pokeID
    var isFavorite = false
    
    let id: Int
    let name: String
    let imageUrl: String
    let type: String
    let description: String
    
    let evolutionChain: [Evolution]?
    
    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl
        case type
        case description
        
        case evolutionChain
        
        case attack
        case defense
        case height
        case weight
        
        
    }
    
    var typeColor: Color {
        switch type {
        case "fire":
            return Color(.systemRed)
        case "poison":
            return Color(.systemGreen)
        case "water":
            return Color(.systemTeal)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemPurple)
        case "normal":
            return Color(.systemOrange)
        case "ground":
            return Color(.systemBrown)
        case "flying":
            return Color(.systemBlue)
        case "fairy":
            return Color(.systemPink)
        default:
            return Color(.systemIndigo)
        }
    }
    
}

enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}

class PokemonViewModel: ObservableObject {
    @Published var pokemon = [Pokemon]()
    
    init() {
        async {
            pokemon = try await getPokemon()
        }
    }
    
    func getPokemon() async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json") else { throw FetchError.badURL }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw FetchError.badResponse}
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData}
        
        let mayBePokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        return mayBePokemonData
    }
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String (data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
