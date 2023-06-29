import SwiftUI
import SwiftData

@main
struct SwiftDataExampleApp: App {

    var body: some Scene {
        WindowGroup {
            FamilyList()
                .modelContainer(for: Person.self)
        }
    }
}
