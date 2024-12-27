// From the tutorial - https://youtu.be/BPQkpxtgalY?si=reskCNj_TJKTodbJ

import SwiftUI
import CoreData

@Observable class CoreDataViewModel {
    
    @ObservationIgnored let container: NSPersistentContainer
    var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "CoreDataBootCamp")
        container.loadPersistentStores { [weak self] description, error in
            if let error {
                print("Error loading core data - \(error)")
            } else {
                self?.fetchFruits()
            }
        }
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching fruits - \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateFruit(_ fruit: FruitEntity) {
        let currentName = fruit.name ?? ""
        let updatedName = currentName + "!"
        fruit.name = updatedName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let fruit = savedEntities[index]
        container.viewContext.delete(fruit)
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch {
            print("Error saving data - \(error)")
        }
    }
}

struct CoreDataMVVMView: View {
   
    @State var vm = CoreDataViewModel()
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
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.pink.opacity(0.75))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { fruit in
                        Text("\(fruit.name ?? "NA")")
                            .onTapGesture {
                                vm.updateFruit(fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataMVVMView()
}
