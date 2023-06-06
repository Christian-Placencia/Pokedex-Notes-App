import SwiftUI

struct DiaryView: View {
    
    // @State private var diaryArray: [DiaryModel] = DiaryModel.diaryModels
    @State private var diaryArray = [DiaryModel]()
    private var dataPersistence = DataPersistence()
    @State private var showAddNewEntryView = false
    let data = DataPersistence()
    
    var body: some View {
        VStack {
            NavigationStack {
                List(diaryArray) { entry in
                    VStack (alignment: .leading, content: {
                        Text(entry.content)
                        Text(entry.date.formatted())
                            .font(.footnote)
                    }).swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: {
                            diaryArray.removeAll { $0.id == entry.id }
                        }) {
                            Image(systemName: "trash")
                        }.tint(.red)
                }
                }
                .navigationBarTitle("Diary")
                .navigationBarItems(trailing: NavigationLink(destination: NewDiaryEntryView(handleAdd: addEntry)) {
                    Image(systemName: "plus")
                })
            }
        }.onAppear {
            do {
                diaryArray = try data.loadEntries()
            } catch {
                
            }
        }.onDisappear {
            do {
                try data.saveEntries(entries: diaryArray)
            } catch {
                
            }
        }
    }
    
    func addEntry(entry: DiaryModel) -> Void {
        diaryArray.append(entry)
    }
    
}
