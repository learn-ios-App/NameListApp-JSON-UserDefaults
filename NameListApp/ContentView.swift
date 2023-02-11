
import SwiftUI

struct ContentView: View {
    @StateObject var people = PersonDate()
    @State var isActive = false
    var body: some View {
        NavigationStack {
            List{
                ForEach(people.people) { person in
                    HStack {
                        Text("名字 : " + person.firstName)
                        Text("      ")
                        Text("名前 : " + person.lastName)
                    }
                }
                .onDelete(perform: people.delete)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    //配列の中身を確認
                    Button(action: {
                        print(people.people)
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isActive = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear() {
                let storePeople = people.getStoreHouse()
                people.people = people.personDecode(personJson: storePeople)
            }
        }
        .sheet(isPresented: $isActive) {
            PlusPersonView(save: { first, last in
                people.people.append(Person(firstName: first, lastName: last))
                isActive = false
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

