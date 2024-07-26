import Network
import SwiftUI

class NetworkStatus: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    @Published var isConnected = false
    
    init() {
        setUp()
    }
    
    deinit {
        monitor.cancel()
    }
    
    func setUp() {
        //パスモニター開始
        monitor.start(queue: queue)
        
        //ネットワークパスが更新されたら行いたい処理を記述
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }
    }
}
