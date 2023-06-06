import SwiftUI

struct EvolutionChainView: View {
    let evolutionChain: [Evolution]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(evolutionChain) { evolution in
                Text(evolution.name.capitalized)
                    .font(.title2)
            }
        }
        .padding()
        .navigationTitle("Evolution Chain")
    }
}
