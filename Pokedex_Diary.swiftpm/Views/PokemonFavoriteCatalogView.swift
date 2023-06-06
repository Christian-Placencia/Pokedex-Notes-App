import SwiftUI

struct PokemonFavoriteCatalogView: View {
    @ObservedObject var pokemonViewModel = SharedData.sharedDatabase.pokemonDatabase
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pokemonViewModel.pokemon.filter({
                    $0.isFavorite
                })) { poke in
                    NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                        HStack{
                            VStack(alignment: .leading, spacing: 5){
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(poke.name.capitalized)
                                            .font(.title)
                                        HStack {
                                            if poke.isFavorite {
                                                Image(systemName: "heart.fill")
                                                    .foregroundColor(poke.typeColor)
                                                    .frame(width: 10, height: 10)
                                            }
                                            else {
                                                Image(systemName: "circle")
                                                    .foregroundColor(poke.typeColor)
                                                    .frame(width: 10, height: 10)
                                            }
                                            
                                            Text(poke.type.capitalized)
                                                .foregroundColor(poke.typeColor)
                                        }
                                        Text(poke.description)
                                            .font(.caption)
                                            .lineLimit(2)
                                    }
                                    
                                }
                            }
                            Spacer()
                            
                            AsyncImage(url: URL(string: poke.imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .interpolation(.none)
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }.swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: {addFavorite(pokemon: poke)}) {
                            Image(systemName: "heart")
                        }.tint(.red)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
    func addFavorite(pokemon: Pokemon) {
        if let index = pokemonViewModel.pokemon.firstIndex(where: {
            $0.id == pokemon.id }) {
            pokemonViewModel.pokemon[index].isFavorite.toggle()
        }       
    }
}

