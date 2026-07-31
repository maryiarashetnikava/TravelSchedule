import SwiftUI
import WebKit

struct UserAgreementWebView: UIViewRepresentable {

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        guard let url = URL(string: "https://yandex.ru/legal/practicum_offer") else {
            return webView
        }

        let request = URLRequest(url: url)
        webView.load(request)

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No updates needed.
    }
}

#Preview {
    UserAgreementWebView()
}
