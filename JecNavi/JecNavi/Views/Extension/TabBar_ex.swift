import SwiftUI


extension TabBarView {
    func CustomTabItem(imageName: String, isActive: Bool) -> some View{
        HStack(alignment: .center,spacing: 22){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .green : .gray)
                .frame(width: 25, height: 25)
            Spacer()
        }
    }
}

enum TabbarItem: Int, CaseIterable {
    case home
    case news
    case map
    case timeline
    case chat
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .timeline:
            return "person"
        case .news:
            return "newspaper"
        case .chat:
            return "message"
        case .map:
            return "map"
        }
    }
}

#Preview{
    AppMainView()
}

