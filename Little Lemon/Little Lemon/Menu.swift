//
//  Menu.swift
//  Little Lemon
//
//  Created by Youssef Al-Hassan on 30/09/2024.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            TextField("Search Menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title!) - $\(dish.price!)")
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            } .frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }.onAppear(perform: getMenuData)
    }
    func getMenuData() {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let menuItems = try JSONDecoder().decode(MenuList.self, from: data)
                PersistenceController.shared.clear()
                for menuItem in menuItems.menu {
                    let dish = Dish(context: viewContext)
                    dish.title = menuItem.title
                    dish.price = menuItem.price
                    dish.image = menuItem.image
                }
                try viewContext.save()
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key:"title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        ]
    }
    func buildPredicate() -> NSPredicate {
        return searchText.isEmpty
        ? NSPredicate(value: true)
        : NSPredicate(format: "title CONTAINS[c] %@", searchText)
    }
}

#Preview {
    Menu()
}
