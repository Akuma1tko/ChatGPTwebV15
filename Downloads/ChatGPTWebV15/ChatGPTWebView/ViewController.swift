import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    private var webView: WKWebView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let sessionCookie = UserDefaults.standard.string(forKey: "sessionCookie") ?? ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ ViewController loaded (Cookie Inject + Sidebar Fix + Voice OK)")

        // MARK: - WebView Configuration
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.suppressesIncrementalRendering = false

        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        prefs.preferredContentMode = .mobile
        config.defaultWebpagePreferences = prefs

        let userContentController = WKUserContentController()

        // Sidebar collapse script (pre-hydration)
        let preHydrationSidebarFix = WKUserScript(
            source: """
            try {
              localStorage.setItem('sidebar-expanded-state', 'false');
              console.log('💥 Sidebar collapsed via localStorage');
            } catch (e) {
              console.log('⚠️ Sidebar collapse failed:', e);
            }
            """,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
        userContentController.addUserScript(preHydrationSidebarFix)

        // Viewport fix (post DOM)
        let viewportScript = WKUserScript(source: """
            var meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = 'width=device-width, initial-scale=1.0';
            document.head.appendChild(meta);
        """, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        userContentController.addUserScript(viewportScript)

        config.userContentController = userContentController

        // MARK: - Initialize WebView
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .systemBackground
        webView.isOpaque = false
        view.addSubview(webView)

        // Spinner
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        // MARK: - Inject Cookie, Then Load Page
        injectSessionCookie {
            self.loadChatGPT()
        }
    }

    // MARK: - Inject Cookie via WKHTTPCookieStore
    private func injectSessionCookie(completion: @escaping () -> Void) {
        guard !sessionCookie.isEmpty else {
            print("❌ No session cookie found.")
            completion()
            return
        }

        let cookie = HTTPCookie(properties: [
            .domain: "chat.openai.com",
            .path: "/",
            .name: "__Secure-next-auth.session-token",
            .value: sessionCookie,
            .secure: "TRUE",
            .expires: NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 30) // 30 days
        ])!

        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
        cookieStore.setCookie(cookie) {
            print("🍪 Session cookie injected.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion()
            }
        }
    }

    // MARK: - Load ChatGPT Page
    private func loadChatGPT() {
        if let url = URL(string: "https://chat.openai.com") {
            let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 30)
            self.webView.load(request)
        }
    }

    // MARK: - WKWebView Delegates

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        print("✅ Page loaded")

        let voiceBind = """
        setTimeout(() => {
          try {
            const voiceBtn = document.querySelector('[aria-label="Hold to speak"]');
            const micBtn = document.querySelector('[aria-label="Start voice input"]');
            if (voiceBtn && micBtn) {
              voiceBtn.addEventListener('mousedown', () => micBtn.click());
              console.log('🎤 Mic bound');
            }
          } catch (e) {
            console.log('❌ Mic bind failed:', e);
          }
        }, 3000);
        """
        webView.evaluateJavaScript(voiceBind, completionHandler: nil)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        print("❌ Navigation failed: \(error.localizedDescription)")
    }

    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completionHandler() })
        self.present(alert, animated: true, completion: nil)
    }
}
