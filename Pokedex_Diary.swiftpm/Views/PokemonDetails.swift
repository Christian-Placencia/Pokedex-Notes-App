import SwiftUI
import Foundation

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            HStack {
                // Favorite icon
                if pokemon.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(pokemon.typeColor)
                }
                Text(pokemon.type.capitalized)
                    .font(.title3)
                    .padding()
                    .foregroundColor(pokemon.typeColor)
            }
            Text(pokemon.description)
                .font(.system(size: 13))
            AsyncImage(url: URL(string: pokemon.imageUrl)) { phase in
                switch phase {
                case.empty:
                    ProgressView()
                case.success(let image):
                    image.resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(height: 200)
                case.failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            NavigationLink(destination: DescriptionView(pokemon: pokemon)) {
                Text("Description & Stats")
                    .font(.headline)
                    .frame(width: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            if let evolutionChain = pokemon.evolutionChain, !evolutionChain.isEmpty {
                NavigationLink(destination: EvolutionChainView(evolutionChain: evolutionChain)) {
                    Text("Evolution Chain")
                        .font(.headline)
                        .frame(width: 200)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(pokemon.name.capitalized)
    }
}
