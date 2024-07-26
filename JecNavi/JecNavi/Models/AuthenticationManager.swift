import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import Combine
import QRCode

class AuthenticationManager: ObservableObject {
    @Published var isSignIn: Bool = false
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var userPhotoURL: URL?
    @Published var QR: CGImage?
    
    private var handle: AuthStateDidChangeListenerHandle!
    
    init() {
        // 認証状態の変化を監視するリスナーを設定する
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            if let user = user {
//                if user.email?.contains("@jec.ac.jp") == false {
//                    self.signOut()
//                }
                print("Sign-in")
                self.isSignIn = true
                self.userName = user.displayName ?? ""
                self.userEmail = user.email ?? ""
                self.userPhotoURL = user.photoURL
                if let user = Auth.auth().currentUser {
                    self.registerUserInFirestore(user)
                    self.QR = try! self.GenerateQRCode(user)
                }
            } else {
                print("Sign-out")
                self.isSignIn = false
                self.userName = ""
                self.userEmail = ""
                self.userPhotoURL = nil
            }
        }
    }
    
    deinit {
        // 監視していた認証状態の変化のリスナーを解除する
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func startListening() {
        // 認証状態の変化をリスナーで監視開始する
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            if let user = user {
//                if user.email?.contains("@jec.ac.jp") == false {
//                    self.signOut()
//                }
                print("Sign-in")
                self.isSignIn = true
                self.userName = user.displayName ?? ""
                self.userEmail = user.email ?? ""
                self.userPhotoURL = user.photoURL
                if let user = Auth.auth().currentUser {
                    self.registerUserInFirestore(user)
                    self.QR = try! self.GenerateQRCode(user)
                }
            } else {
                print("Sign-out")
                self.isSignIn = false
                self.userName = ""
                self.userEmail = ""
                self.userPhotoURL = nil
            }
        }
    }
    
    func stopListening() {
        // 認証状態の変化をリスナーで監視停止する
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    private func registerUserInFirestore(_ user: User) {
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(user.uid)
        
        userRef.setData([
            "name": user.displayName ?? "",
            "email": user.email ?? "",
            "profilePictureURL": user.photoURL?.absoluteString ?? "",
        ]) { error in
            if let error = error {
                print("Error registering user in Firestore: \(error.localizedDescription)")
            } else {
                print("User successfully registered in Firestore")
            }
        }
    }
    
    func GenerateQRCode(_ user: User) throws -> CGImage {
        let white = CGColor(srgbRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
        let black = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        let doc = try QRCode.Document(utf8String: user.uid)
        doc.design.style.backgroundFractionalCornerRadius = 3.0
        doc.design.shape.onPixels = QRCode.PixelShape.Circle()
        doc.design.style.onPixels = QRCode.FillStyle.Solid(black)
        doc.design.shape.eye = QRCode.EyeShape.Circle()
        doc.design.shape.pupil = QRCode.PupilShape.Circle()
        doc.design.shape.offPixels = QRCode.PixelShape.Circle()
        doc.design.style.offPixels = QRCode.FillStyle.Solid(white)
        doc.design.style.background = QRCode.FillStyle.Image(image:UIImage(named: "qrBackground")!)

        let qrcode = try doc.cgImage(CGSize(width: 1000, height: 1000))
        return qrcode
    }
}
