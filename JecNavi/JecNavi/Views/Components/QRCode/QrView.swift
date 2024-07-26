import SwiftUI
import CodeScanner
import QRCode

struct QrView: View {
    @ObservedObject var model = ChatRoomsModel.shared
    @ObservedObject var authentication = AuthenticationManager()
    @State var isshowQr = false
    @Binding var isreadQr: Bool
    @State private var scannedCode: String?

    var body: some View {
        NavigationStack{
            VStack {
                ZStack(alignment: .bottom) {
                    ZStack{
                        CodeScannerView(codeTypes: [.qr]) { response in
                            if case let .success(result) = response {
                                scannedCode = result.string
                                if let code = scannedCode, isValidCode(code) {
                                    model.chatRoomExists(otherUserID: code) { exists in
                                        if !exists {
                                            model.createChatRoom(otherUserID: code)
                                        }
                                        isreadQr = false
                                    }
                                } else {
                                    // 無効なコードの場合のエラーハンドリング
                                    print("Invalid QR code: \(scannedCode ?? "")")
                                    scannedCode = nil
                                    isreadQr = false
                                }
                            } else {
                                isreadQr = false
                            }
                        }
                        ScanOverlayView()
                    }.edgesIgnoringSafeArea(.top)
                    
                    Button(action: {
                        isshowQr = true
                    }, label: {
                        HStack {
                            Image(systemName: "qrcode")
                            Text("My QR Code")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Capsule())
                    })
                    .padding()
                }
                
                Text("You can scan the QR code to start chatting.")
                    .frame(height: 200)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isreadQr = false
                    }, label: {
                        Image(systemName:"xmark")
                            .foregroundColor(.white)
                            .scaleEffect(1.25)
                    })
                }
            }
        }
        .sheet(isPresented: $isshowQr) {
            if let qrImage = authentication.QR {
                Image(decorative: qrImage, scale: 1)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .presentationDetents([
                        .fraction(0.7)
                    ])
                    .presentationDragIndicator(.visible)
            } else {
                Text("Could not generate QR code.")
            }
            
        }
    }
    
    private func isValidCode(_ code: String) -> Bool {
        // Firestoreのドキュメントパスとして有効な形式を確認するロジックを追加
        let invalidCharacters = CharacterSet(charactersIn: "/#[]")
        return !code.isEmpty && code.rangeOfCharacter(from: invalidCharacters) == nil
    }
}

