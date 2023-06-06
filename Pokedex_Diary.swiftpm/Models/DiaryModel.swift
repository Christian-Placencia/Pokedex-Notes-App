import Foundation

struct DiaryModel: Identifiable, Codable {
    let id = UUID()
    //let pokemon: Pokemon
    let date: Date
    let content: String
}

extension DiaryModel {
    static let diaryModels = [
        DiaryModel(date: Date(), content: "Saw a Pikachu on Route 3"),
        DiaryModel(date: Date().addingTimeInterval(3600), content: "Heard that Brock has an Onyx")
        //DiaryModel(pokemon: SharedData.sharedDatabase.pokemonDatabase.pokemon[2], date: Date(), content: "Saw a Pikachu on Route 3"),
        //DiaryModel(pokemon: SharedData.sharedDatabase.pokemonDatabase.pokemon[3], date: Date().addingTimeInterval(3600), content: "Heard that Brock has an Onyx")
    ]
}
