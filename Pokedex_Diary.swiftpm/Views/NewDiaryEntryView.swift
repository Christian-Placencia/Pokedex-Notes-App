import SwiftUI

struct NewDiaryEntryView: View {
    
    var handleAdd: (DiaryModel) -> Void = {_ in }
    
    @State private var newItemText = ""
    @State private var selectedDate = Date()
    // @State private var selectedPokemon = Pokemon()
    @State private var showAlert = false
    
    //    The presentationMode environment variable is accessed using the @Environment(\.presentationMode) property wrapper. This variable allows the view to control its presentation, such as dismissing itself or presenting a child view.
    //
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Description", text: $newItemText)
                    DatePicker("Date", selection: $selectedDate)
                    //Picker(selection: $selectedPokemon, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                        ///*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        ///*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                    //}
                }
                Section {
                    Button("Add Item") {
                        if newItemText.isEmpty {
                            showAlert = true
                        } else {
                            let entry = DiaryModel(date: selectedDate, content: newItemText)
                            handleAdd(entry)
                            self.presentation.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Ney Entry")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please enter a new item"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
