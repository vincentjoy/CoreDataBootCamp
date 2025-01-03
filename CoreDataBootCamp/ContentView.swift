// From the tutorial - https://youtu.be/nalfX8yP0wc?si=jQrFf4YNPLqrOqHn

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: FruitEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)])
    var fruits: FetchedResults<FruitEntity>
    
    @State var textFieldText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                TextField("Enter Fruit Name", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    addItem()
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                
                List {
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "NA")
                            .onTapGesture {
                                updateItem(fruit: fruit)
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = textFieldText
            saveToCoredata()
            textFieldText = ""
        }
    }
    
    private func updateItem(fruit: FruitEntity) {
        withAnimation {
            let currentName = fruit.name ?? ""
            let updatedName = currentName + "!"
            fruit.name = updatedName
            saveToCoredata()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let fruit = fruits[index]
            viewContext.delete(fruit)
//            offsets.map { fruits[$0] }.forEach(viewContext.delete)
            saveToCoredata()
        }
    }
    
    private func saveToCoredata() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
