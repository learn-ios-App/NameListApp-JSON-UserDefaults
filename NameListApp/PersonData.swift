
import Foundation

struct Person: Identifiable, Codable {
    var id = UUID()
    var firstName: String
    var lastName: String
}

class PersonDate: ObservableObject {
    @Published var people: [Person] = [Person(firstName: "野原", lastName: "しんのすけ")]
    let userDefault = UserDefaults.standard
    
    func delete(offset: IndexSet) {
        self.people.remove(atOffsets: offset)
        let person = personEncode(person: people)
        serStoreHouse(person: person)
    }
    
    func add(firstName: String, lastName: String) {
        self.people.append(Person(firstName: firstName, lastName: lastName))
        let person = personEncode(person: people)
        serStoreHouse(person: person)
    }
    
    func personEncode(person: [Person]) -> String {
        do {
            let jsonDate = try JSONEncoder().encode(person)
            let jsonPerson = String(data: jsonDate, encoding: .utf8)!
            return jsonPerson
        } catch {
            return ""
        }
    }
    
    func personDecode(personJson: String) -> [Person] {
        do {
            let jsonData = personJson.data(using: .utf8)!
            let people = try JSONDecoder().decode([Person].self, from: jsonData)
            return people
        } catch {
            return []
        }
    }
    
    func serStoreHouse(person: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(person, forKey: "Person_Key")
    }
    
    func getStoreHouse() -> String {
        let userDefaults = UserDefaults.standard
        let result = userDefaults.string(forKey: "Person_Key") ?? ""
        return result
    }
}
