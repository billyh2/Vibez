import SwiftUI

public struct IntroductionView: View {
    
    @Binding var recurse: Bool
    @Binding var step : Int
    @Binding var gamemode : String
    @Binding var introText: Int
    @Binding var page: Int

    
    @State var animation = false
    @State var animationTriangle = false
    @State var animationCard = false
    @State var delay = false
    @State var button1Active = false
    @State var button2Active = false
    
    public init( _ recurse: Binding<Bool>, _ step: Binding<Int>, _ gamemode: Binding<String>, _ introText: Binding<Int>, _ page: Binding<Int>) {
            self._recurse = recurse
            self._step = step
            self._gamemode = gamemode
            self._introText = introText
            self._page = page
    }
    
    public var body : some View {
        ZStack {
            Image("nature (1)")
//                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            if(page == 1) {
                VStack{
                    Image("logo_transparent_background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:720, height: 400)
                        

                        Button(action: {
                            page = 2
                        }, label: {
                            Text("~ tap to start ~").fontWeight(.bold).font(.system(size: 18)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .opacity(animation ? 1 : 0)
                                .animation(Animation.easeInOut(duration: 1).repeatForever(), value: animation)
                                    })
                }
                    //VStack
            }
            if(page == 2) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .frame(width: 515, height: 292)
                        .opacity(0.2)

                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.purple, location: 0),
                                .init(color: Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), location: 1)]),
                                startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
                                endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999)), lineWidth: 3)
                        .frame(width: 515, height: 292)
                    if(introText == 1) {
                        if(delay) {
                            VStack (spacing: 6){
                                Text("This app runs optimally under landscape mode, please turn to landscape mode if you haven't")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 18))
                                    .fontWeight(.light)
                                    .padding([.leading, .bottom, .trailing], 30)
                                Text("This program is designed to help you focus on what you are doing by algorithmically designing a lofi playlist that will enhance your performance; whether that is studying, sleeping, excercising, or just chilling.")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .padding([.leading, .bottom, .trailing], 30)
                            }
                            Button(action: {
                                    introText = 2
                                    delay = false
                                    }, label: {
                                        triangleSVG()
                                            .foregroundColor(Color.purple)
                                            .shadow(color: Color(#colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 0.69)), radius: 1, x: 0, y: 2)
                                            .opacity(animationTriangle ? 1 : 0.5)
                                            .animation(Animation.easeInOut(duration: 1).repeatForever(), value: animationTriangle)
                                            .onAppear{
                                                animationTriangle = true
                                            }
                                    }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomTrailing)
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 30)
                        }
                    }
                    if(introText == 2) {
                        VStack(spacing: 30) {
                            Text("Please select the algorithm you would like to use: ")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .padding([.leading, .bottom, .trailing], 30)
                                .onAppear(perform: executeDelay)
                            HStack (spacing: 120) {
                                Button(action: {
                                    gamemode = "picture"
                                    self.button1Active = true
                                    if(button2Active) {
                                        self.button2Active = false
                                    }
                                }, label: {
                                    VStack (spacing: 15) {
                                        Text("Image Filter")
                                            .foregroundColor(Color.white)
                                            .fontWeight(.bold)
                                        Image(systemName: "photo")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 60))
                                            .opacity(button1Active ? 1: 0.7)
                                        SpecialButton(active: button1Active)
                                    }
                                    .offset(y:-15)
                                    })
                                Button(action: {
                                    gamemode = "music"
                                    self.button2Active = true
                                    if(button1Active) {
                                        self.button1Active = false
                                    }
                                }, label: {
                                    VStack (spacing: 15){
                                        Text("Stem Player")
                                            .foregroundColor(Color.white)
                                            .fontWeight(.bold)
                                        Image(systemName: "music.quarternote.3")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 60))
                                            .opacity(button2Active ? 1: 0.7)
                                        SpecialButton(active: button2Active)
                                    }
                                    .offset(y:-15)
                                    
                                })
                             }
                        }
                        .offset(y:-20)
                        if(delay && gamemode != ""){
                            Button(action: {
                            step = 2
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .fill(Color.purple)
                                    .frame(width: 90, height: 30)
                                    .shadow(color: Color(#colorLiteral(red: 0.3294117748737335, green: 0.3294117748737335, blue: 0.3294117748737335, alpha: 0.6899999976158142)), radius: 4, x: 0, y: 3)
                                
                                                                
                                Text("Let's Go!")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }
                        }).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(.bottom, 25)
                        .padding(.trailing, 30)
                        .offset(x: -179.5)
                        }
                    }
                }
                .frame(width: animationCard ? 375 : 2, height: animationCard ? 204.64 : 2)
                .animation(.spring(response: 1, dampingFraction: 1, blendDuration: 10), value: animationCard)
                .onAppear(perform: executeDelay)
                .onAppear {
                    animationCard = true
                }
            }
        }
        //ZStack
        .frame(width: 700, height:490)
        .onAppear {
            animation = true
            recurse = false
            playSound(key: "Lofi5", cnt: -1)
        }
    }
    
    private func executeDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            delay = true
        }
    }
    
}
    
