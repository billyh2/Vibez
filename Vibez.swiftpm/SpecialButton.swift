import SwiftUI

public struct SpecialButton: View {
    
    var active = false
    
    public var body : some View {
        
        let circle = Image(systemName: "circle.circle.fill")
        if(active) {
            circle.foregroundColor(Color.purple)
        }
        else {
            circle.foregroundColor(Color.white)
                .opacity(0.5)
        }

    }
}

