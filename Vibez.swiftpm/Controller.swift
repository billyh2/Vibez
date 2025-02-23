import SwiftUI

public struct Controller: View {
    @State var step = 1
    @State var gamemode = ""
    @State var recurse = false
    @State var introText = 1
    @State var page = 1
    
    public init() {}
    
    public var body : some View {
        
        if(step == 1) {
            IntroductionView($recurse, $step, $gamemode, $introText, $page)
        }
        if(step == 2) {
            if(gamemode == "picture")
            {
                NavigationView {
                    ImageGalleryView($recurse, $step, $gamemode, $introText, $page)
                }
                .navigationViewStyle(.stack)
            }
            else if(gamemode == "music")
            {
                StemPlayerView($recurse, $step, $gamemode, $introText, $page)
                if(recurse) {
                    IntroductionView($recurse, $step, $gamemode, $introText, $page)
                }
            }
        }
    }
}
