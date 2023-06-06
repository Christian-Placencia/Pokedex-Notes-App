import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PokemonCatalogView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Catalog")
                }
            PokemonFavoriteCatalogView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            DiaryView()
                .tabItem { 
                    Image(systemName: "book")
                    Text("Diary")
                }
        }.accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}
