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
        save()
    }
    
    private func save() {
        manager.save()
        getBusinesses()
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

                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
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

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "NA")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
