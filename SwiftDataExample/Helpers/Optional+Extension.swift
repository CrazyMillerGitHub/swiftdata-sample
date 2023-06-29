import Foundation

extension Optional where Wrapped == Date {

    var isNil: Bool {
        self == .none
    }
}

extension Optional where Wrapped == String {

    var isNil: Bool {
        self == .none
    }

    var isNotNil: Bool {
        !isNil
    }
}
