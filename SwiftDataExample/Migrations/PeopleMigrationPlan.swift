import SwiftData

enum PeopleMigrationPlan: SchemaMigrationPlan {

    static var schemas: [any VersionedSchema.Type] = []
    static var stages: [MigrationStage] = []
}
