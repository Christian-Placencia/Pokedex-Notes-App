import SwiftUI

struct DescriptionView: View {
    let pokemon: Pokemon
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(alignment: .leading) {
                ZStack{
                    Rectangle()
                        //.edgesIgnoringSafeArea(.all)
                        // .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor(pokemon.typeColor)
                    VStack{
                        Text("Description")
                            .font(.headline)
                        Text(pokemon.description)
                            //lo comentado va despues de description. O sea ".description.replacing...
                            //.replacingOccurrences(of: "\n", with: ""))
                            .foregroundColor(.white)
                            .padding()
                        Text("Stats")
                            .font(.headline)
                        StatsViewGroup(pokemon: pokemon)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            .navigationTitle(pokemon.name.capitalized)
        }
    }
}
