import SwiftUI
import SwiftData

struct AddRelativeView: View {
    
    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss: DismissAction

    @State
    private var firstName: String = ""

    @State
    private var lastName: String = ""

    @State
    private var dateOfBirth: Date = Date()

    @State
    private var selectedRelatvies: Person? = nil

    @Query(sort: \Person.lastName) private var relatives: [Person]

    var body: some View {
        NavigationStack {
            Form {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                DatePicker("Date of birth", selection: $dateOfBirth)
                Picker("Relatives", selection: $selectedRelatvies) {
                    Text("Select relative")
                    ForEach(relatives) { relative in
                        Text(relative.fullName)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Constants.title)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(Constants.save) {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled(firstName.isEmpty || lastName.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(Constants.cancel, role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Private methods
private extension AddRelativeView {

    func save() {
        guard firstName.isNotEmpty, lastName.isNotEmpty else {
            return
        }
        withAnimation {
            modelContext.insert(
                Person(
                    firstName: firstName,
                    lastName: lastName,
                    dateOfBirth: dateOfBirth
                )
            )
        }
    }
}

// MARK: - Resources
private extension AddRelativeView {

    enum Constants {
        static let title: String = "Add relative"
        static let save: String = "Save"
        static let cancel: String = "Cancel"
    }
}

private extension String {

    var isNotEmpty: Bool {
        !isEmpty
    }
}
