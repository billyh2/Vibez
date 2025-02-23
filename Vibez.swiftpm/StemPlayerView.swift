//
//  File.swift
//  Vibez
//
//  Created by Billy Huang on 2022-04-13.
//

import SwiftUI

struct StemPlayerView: View {
    // Selected Tab Index...
    // Default is third...
    @State var current = 2
    
    // Miniplayer Properties...
    @State var task = 1
    
    @Namespace var animation
    
    @State var coc = false
    
    let gradient = LinearGradient(colors: [.orange, .green],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
    
    @Binding var recurse: Bool
    @Binding var step : Int
    @Binding var gamemode : String
    @Binding var introText: Int
    @Binding var page: Int
    
    public init( _ recurse: Binding<Bool>, _ step: Binding<Int>, _ gamemode: Binding<String>, _ introText: Binding<Int>, _ page: Binding<Int>) {
            self._recurse = recurse
            self._step = step
            self._gamemode = gamemode
            self._introText = introText
            self._page = page
    }
    
    
    var body: some View {
    
        if(task == 1) {
            ZStack {
                gradient
                    .ignoresSafeArea()
                    .opacity(0.3)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .frame(width: 515, height: 292)
                    .opacity(0.2)

                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.green, location: 0),
                            .init(color: Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
                            endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999)), lineWidth: 3)
                    .frame(width: 515, height: 292)
                
                VStack (){
                    Text("Welcome to the Stem Player!")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .offset(y: 50)
                    
                    Text("Click instruments that you would like in your playlist to open up their stems - a short melodic loop. Find stems that fit the mood of what you want to listen to, and the algorithm will compute a playlist consisting these stems!")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .frame(width:475, height: 280)
                        .offset(y:-20)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 13)
                            .fill(Color.green)
                            .frame(width: 160, height: 30)
                            .shadow(color: Color(#colorLiteral(red: 0.3294117748737335, green: 0.3294117748737335, blue: 0.3294117748737335, alpha: 0.6899999976158142)), radius: 4, x: 0, y: 3)
                        
                        Button(action: {
                            task = 2
                        }, label: {
                            Text("~ Tap to Start ~").fontWeight(.bold).font(.system(size: 18)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    })
                    }
                    .offset(y:-50)
                    .opacity(coc ? 1 : 0.25)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(), value: coc)
                }
                .frame(width: 500, height: 290)
            }
            .onAppear {
                coc = true
            }
        }
        // Bottom Mini Player...
    
        if(task == 2) {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                        gradient
                            .ignoresSafeArea()
                            .opacity(0.5)
                        Search($recurse, $step, $gamemode, $introText, $page)
                        
                    
                })
        }
    }
}
