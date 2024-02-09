import SwiftUI

struct ConfirmationView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo.badge.checkmark.fill")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.vertical, 2)
            Text("Saved!")
                .font(.title3)
                .fontDesign(.rounded)
                .foregroundColor(.white)
                .padding(.horizontal, 4)
        }
        .padding(.all, 10)
        .background(Color.black.opacity(0.55))
        .cornerRadius(4)
    }
}

#Preview {
    ConfirmationView()
}
