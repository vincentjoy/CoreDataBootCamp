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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataMVVMView()
}
