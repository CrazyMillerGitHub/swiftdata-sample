import SwiftUI
import CoreData
import SwiftData

struct FamilyList: View {

    @Query
    private var relatives: [Person]

    @Environment(\.modelContext)
    private var modelContext

    @State var isPresenting: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(relatives, id: \.id)  { relative in
                    NavigationLink(relative.fullName, value: relative)
                }
                .onDelete(perform: deleteRelative)
            }
            .toolbar {
                Button(Constants.toolbarTitle, systemImage: "plus.circle") {
                    isPresenting = true
                }
            }
            .sheet(isPresented: $isPresenting) {
                AddRelativeView()
            }
            .overlay {
                if relatives.isEmpty {
                    ContentUnavailableView {
                        Label(Constants.unavailableTitle, systemImage: "person.2")
                    } description: {
                        Button(Constants.toolbarTitle, systemImage: "plus.circle") {
                            isPresenting = true
                        }
                    }
                }
            }
            .navigationDestination(for: Person.self) { relative in
                DetailView(
                    model: DetailModel(
                        image: ("photo", .main),
                        name: relative.fullName,
                        description: ""
                    )
                )
            }
            .navigationTitle(Constants.title)
        }
    }

    // MARK: - Private methods

    private func deleteRelative(offsets: IndexSet) {
        withAnimation {
            offsets.forEach { offset in
                modelContext.delete(relatives[offset])
            }
        }
    }
}

private extension FamilyList {

    struct Constants {
        static let unavailableTitle: String = "No relatives found"
        static let title: String = "Family Party"
        static let toolbarTitle: String = "Add Member"
    }
}
