// snapel.swift <url> <selector> <out.png> <width> [js]: a PNG of the elements a selector matches on a web page, through WebKit.
import AppKit
import WebKit

let args = CommandLine.arguments
let url = URL(string: args[1])!, selector = args[2], out = args[3], width = CGFloat(Double(args[4]) ?? 1280)
// An optional fifth argument is JavaScript run before measuring, e.g. to open a collapsed answer.
let prepare = args.count > 5 ? args[5] : ""

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
            webView.evaluateJavaScript("(function(){var st=document.createElement('style');st.textContent='.fu{opacity:1!important;transform:none!important;transition:none!important}';document.head.appendChild(st);})(); \(prepare); document.documentElement.scrollHeight") { height, _ in
                let h = CGFloat((height as? Double) ?? 2000)
                webView.frame = CGRect(x: 0, y: 0, width: webView.frame.width, height: h)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    let js = "(function(){var l=1e9,t=1e9,r=-1e9,b=-1e9;document.querySelectorAll(\(String(reflecting: selector))).forEach(function(e){var x=e.getBoundingClientRect();l=Math.min(l,x.left);t=Math.min(t,x.top+window.scrollY);r=Math.max(r,x.right);b=Math.max(b,x.bottom+window.scrollY);});return [l,t,r-l,b-t];})()"
                    webView.evaluateJavaScript(js) { value, error in
                        guard let r = value as? [Double] else { print("no element: \(String(describing: error))"); exit(1) }
                        // The matched elements with a 24 pt margin, kept on the page.
                        let config = WKSnapshotConfiguration()
                        config.rect = CGRect(x: r[0] - 24, y: r[1] - 24, width: r[2] + 48, height: r[3] + 48)
                            .intersection(CGRect(x: 0, y: 0, width: webView.frame.width, height: h))
                        webView.takeSnapshot(with: config) { image, error in
                            guard let image, let tiff = image.tiffRepresentation, let rep = NSBitmapImageRep(data: tiff),
                                  let png = rep.representation(using: .png, properties: [:]) else {
                                print("snapshot failed: \(String(describing: error))"); exit(1)
                            }
                            try! png.write(to: URL(fileURLWithPath: out))
                            print("\(out) \(Int(config.rect.width))×\(Int(config.rect.height))")
                            exit(0)
                        }
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
