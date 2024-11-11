import SwiftUI

struct ProductDetailView: View {
    let product: String

    var body: some View {
        VStack {
            Text("Детали для категории:")
                .font(.headline)
            Text(product)
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle(product)
        .navigationBarTitleDisplayMode(.inline)
    }
}
