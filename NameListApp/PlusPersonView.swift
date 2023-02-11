
import SwiftUI

struct PlusPersonView: View {
    @State var first = ""
    @State var last = ""
    let save: (String, String) -> Void
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Text("FirstName")
                CustomField(text: $first)
            }
            HStack {
                Text("LastName")
                CustomField(text: $last)
            }
            Button(action: {
                save(first, last)
            }) {
                Text("保存")
            }
        }
    }
}

struct CustomField: View {
    @Binding var text: String
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 150)
    }
}

struct PlusPersonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusPersonView(save: { _ , _ in })
    }
}
