import SwiftUI

struct ProductListView: View {
    @State private var categories: [Category] = []
    @State private var searchText = ""

    var filteredCategories: [Category] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { $0.strCategory.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            TextField("Поиск категории", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            List(filteredCategories) { category in
                NavigationLink(destination: ProductDetailView(product: category.strCategory)) {
                    Text(category.strCategory)
                }
            }
        }
        .navigationTitle("Категории")
        .onAppear(perform: fetchCategories)
    }

    func fetchCategories() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?c=list") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(CategoryResponse.self, from: data)
                    DispatchQueue.main.async {
                        categories = decodedResponse.meals
                    }
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            } else if let error = error {
                print("Ошибка загрузки данных: \(error)")
            }
        }.resume()
    }
}
