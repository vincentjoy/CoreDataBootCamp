// From the tutorial - https://youtu.be/huRKU-TAD3g?si=NJ5N5SXgOORhIQqP

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataBootCamp")
        container.loadPersistentStores { (description, error) in
            if let error {
                print("Error loading core data - \(error)")
            }
        }
        context = container.viewContext
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving data - \(error.localizedDescription)")
        }
    }
}

@Observable final class CoreDataRelationshipViewModel {
    
    @ObservationIgnored let manager = CoreDataManager.instance
}

struct CoreDataRelationshipsBootCamp: View {
    
    @State var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataRelationshipsBootCamp()
}
