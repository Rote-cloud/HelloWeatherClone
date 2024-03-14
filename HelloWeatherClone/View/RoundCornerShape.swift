import SwiftUI

struct RoundCornerShape: Shape {
    var rect: CGRect
    var byRoundingCorners: UIRectCorner
    var cornerRadii: CGSize
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: byRoundingCorners, cornerRadii: cornerRadii)
        return Path(path.cgPath)
    }
}
