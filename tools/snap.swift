// snap.swift <url> <out.png> <width>: a full-page PNG of a web page, through WebKit.
import AppKit
import WebKit

let args = CommandLine.arguments
let url = URL(string: args[1])!, out = args[2], width = CGFloat(Double(args[3]) ?? 1280)

final class Snapper: NSObject, WKNavigationDelegate {
    let web: WKWebView
    init(width: CGFloat) {
        web = WKWebView(frame: CGRect(x: 0, y: 0, width: width, height: 900))
        super.init()
        web.navigationDelegate = self
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Let fonts, images and the changelog's fetch settle, then measure the page.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            // The site fades sections in on scroll (.fu → .fu.in); a snapshot never scrolls, so show them all.
            webView.evaluateJavaScript("(function(){var st=document.createElement('style');st.textContent='.fu{opacity:1!important;transform:none!important;transition:none!important}';document.head.appendChild(st);})(); document.documentElement.scrollHeight") { height, _ in
                let h = CGFloat((height as? Double) ?? 2000)
                webView.frame = CGRect(x: 0, y: 0, width: webView.frame.width, height: h)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    let config = WKSnapshotConfiguration()
                    config.rect = CGRect(x: 0, y: 0, width: webView.frame.width, height: h)
                    webView.takeSnapshot(with: config) { image, error in
                        guard let image, let tiff = image.tiffRepresentation, let rep = NSBitmapImageRep(data: tiff),
                              let png = rep.representation(using: .png, properties: [:]) else {
                            print("snapshot failed: \(String(describing: error))"); exit(1)
                        }
                        try! png.write(to: URL(fileURLWithPath: out))
                        print("\(out) \(Int(webView.frame.width))×\(Int(h))")
                        exit(0)
                    }
                }
            }
        }
    }
}

let app = NSApplication.shared
let snapper = Snapper(width: width)
snapper.web.load(URLRequest(url: url))
app.run()
