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
    
    func save() {
        do {
            try container.viewContext.save()
            print("Saved successfully!")
        } catch {
            print("Error saving data - \(error.localizedDescription)")
        }
    }
}

@Observable final class CoreDataRelationshipViewModel {
    
    @ObservationIgnored let manager = CoreDataManager.instance
    var businesses: [BusinessEntity] = []
    
    init() {
        getBusinesses()
    }
    
    func getBusinesses() {
        let request: NSFetchRequest<BusinessEntity> = NSFetchRequest(entityName: "BusinessEntity")
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error fetching businesses - \(error.localizedDescription)")
        }
    }
    
    func addBusinesses() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        manager.save()
    }
}

struct CoreDataRelationshipsBootCamp: View {
    
    @State var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        vm.addBusinesses()
                    } label: {
                        Text("Add Business")
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }

                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

#Preview {
    CoreDataRelationshipsBootCamp()
}
