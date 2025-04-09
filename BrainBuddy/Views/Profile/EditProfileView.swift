import SwiftUI

struct EditProfileView: View {
    @Binding var name: String
    @Binding var email: String
    @State private var tempName: String = ""
    @State private var tempEmail: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $tempName)
                        .accessibilityLabel("Name input field")
                    
                    TextField("Email", text: $tempEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .accessibilityLabel("Email input field")
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    name = tempName
                    email = tempEmail
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .onAppear {
                tempName = name
                tempEmail = email
            }
        }
    }
}