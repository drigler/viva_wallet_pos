import UIKit
import viva_wallet_pos

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url else { return }

    print("✅ SceneDelegate openURL: \(url.absoluteString)")
    _ = VivaWalletPosPlugin.handleCallback(url)
  }
}