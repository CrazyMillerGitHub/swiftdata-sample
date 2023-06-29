import SwiftUI

struct DetailView: View {

    private let image: (name: String, bundle: Bundle?)
    private let name: String
    private let description: String

    init(
        model: DetailModel
    ) {
        self.image = model.image
        self.name = model.name
        self.description = model.description
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(image.name, bundle: image.bundle)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(50)
                Spacer()
            }
            Text(name)
            Spacer()
            Text(description)
        }.padding()
    }
}

private struct DetailView_Preview: PreviewProvider {

    static var previews: some View {
        DetailView(model: .fixture)
    }
}

private extension DetailModel {
    static let fixture = Self(
        image: ("photo", .main),
        name: "John Johnson",
        description: ""
    )
}
