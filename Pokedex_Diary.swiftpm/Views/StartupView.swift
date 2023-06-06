import SwiftUI

struct StartupView: View {
    @State private var showPokemonList = false
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Welcome to your Pokedex")
                    .font(.largeTitle)
                
                Button(action: {
                    showPokemonList = true
                }) {
                    Text("Go to Pokedex")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showPokemonList, content: {
                    PokemonCatalogView()
                })
                .padding(.top, 20)
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
