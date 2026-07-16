import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Карточка перевозчика")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.ypBlack)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.ypBlack)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        CarrierInfoView()
    }
}
