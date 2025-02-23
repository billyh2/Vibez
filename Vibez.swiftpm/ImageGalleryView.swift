//
//  File.swift
//  Vibez
//
//  Created by Billy Huang on 2022-04-16.
//

import SwiftUI

struct ImageGalleryView: View {
    @State private var isAddingSymbol = false
    @State private var isEditing = false
    @State private var isPlaying = false


    @State private var moodIndex: Int?
    private static let initialColumns = 3
    @State private var selectedSymbolName: String?
    @State private var numColumns = initialColumns
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var task = 1
    @State private var coc = false
    
    
    @State private var symbolNames: [String] = []
    @State private var imageIndex: [Int] = []
    
    @State private var musicList1 =
    [
        "Lofi1",
        "Lofi2",
        "Lofi3",
        "Lofi4",
    ]
    
    @State private var musicList2 =
    [
        "Workout1",
        "Workout2",
        "Workout3",
        "Workout4",
    ]

    let gradient = LinearGradient(colors: [.pink, .yellow],
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
            UINavigationBar.changeAppearance(clear: true)
    }

    
    var body: some View {
        
        ZStack {
            gradient
                .opacity(0.3)
                .ignoresSafeArea()
            if(task == 1) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .frame(width: 515, height: 292)
                    .opacity(0.2)

                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.pink, location: 0),
                            .init(color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
                            endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999)), lineWidth: 3)
                    .frame(width: 515, height: 292)
                
                VStack (){
                    Text("Welcome to the Image Filter!")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .offset(y: 50)
                    
                    Text("Select images that match your mood by pressing the + button in the top right corner. These images will be used to compute a playlist for you!")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .frame(width:475, height: 280)
                        .offset(y:-20)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 13)
                            .fill(Color.pink)
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
                    .animation(Animation.easeIn(duration: 2).repeatForever(), value: coc)
                }
                .onAppear {coc = true}
                .frame(width: 500, height: 290)
            }
            
            if(task == 2) {
                VStack {
                    ScrollView {
                        LazyVGrid(columns: gridColumns) {
                            ForEach(symbolNames, id: \.self) { name in
                                ZStack(alignment: .topTrailing) {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .ignoresSafeArea(.container, edges: .bottom)
                                        .cornerRadius(8)
                                    
                                    if isEditing {
                                        Button {
                                            guard let index = symbolNames.firstIndex(of: name) else { return }
                                            withAnimation {
                                                _ = symbolNames.remove(at: index)
                                                _ = imageIndex.remove(at: index)

                                            }
                                        } label: {
                                            Image(systemName: "xmark.square.fill")
                                                        .font(Font.title)
                                                        .symbolRenderingMode(.palette)
                                                        .foregroundStyle(.white, Color.red)
                                        }
                                        .offset(x: 7, y: -7)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .navigationBarTitle("My Images").font(.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $isAddingSymbol, onDismiss: addSymbol) {
                        ImagePicker(name: $selectedSymbolName, index: $moodIndex)
                    }
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.status) {
                            Button {
                                if(isPlaying) {
                                    isPlaying.toggle()
                                    pauseSound()
                                }
                                else {
                                    let sum = Float(imageIndex.reduce(0,+))
                                        // number of images in container
                                    let number = Float(imageIndex.count)
                                        // estimate the user mood
                                    let soundIndex = (sum/number).rounded()
                                        // random pick music from music list1 if soundIndex ==1, elsepick music from music list2
                                    if(sum == 0.0) {
                                        print("Please select images")
                                    }
                                    else if (soundIndex == 1.0) {
                                        isPlaying.toggle()
                                        playSound(key: musicList1[Int.random(in: 0..<musicList1.count)], cnt: 1)
                                    }
                                    else {
                                        isPlaying.toggle()
                                        playSound(key: musicList2[Int.random(in: 0..<musicList2.count)], cnt: 1)
                                    }
                                }
                            } label: {
                                ZStack (alignment: Alignment(horizontal: .center, vertical: .bottom)){
                                    RoundedRectangle(cornerRadius: 13)
                                        .fill(gradient)
                                        .frame(width: 150, height: 30)
                                        .shadow(color: Color(#colorLiteral(red: 0.3294117748737335, green: 0.3294117748737335, blue: 0.3294117748737335, alpha: 0.6899999976158142)), radius: 4, x: 0, y: 3)
                                        .ignoresSafeArea()
                                        HStack {
                                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                            Text(isPlaying ? "Pause!" :  "Play!")
                                                .foregroundColor(Color.white)
                                                .fontWeight(.bold)
                                                .font(.system(size: 18))
                                        }
                                }
                            }
                        }
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isEditing.toggle()
                        } label:  {
                            Text(isEditing ? "Done" : "Edit")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isAddingSymbol = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color.white)
                        }
                        .disabled(isEditing)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            recurse = true
                            step = 1
                            gamemode = ""
                            introText = 2
                            page = 2
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .fill(Color.red)
                                    .frame(width: 90, height: 30)
                                    .shadow(color: Color(#colorLiteral(red: 0.3294117748737335, green: 0.3294117748737335, blue: 0.3294117748737335, alpha: 0.6899999976158142)), radius: 4, x: 0, y: 3)
                                
                                                                
                                Text("Exit")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }
                        }
                    }
                }
            }
        }
}
    
    func addSymbol() {
        guard let name = selectedSymbolName else { return }
        withAnimation {
            symbolNames.insert(name, at: 0)
            imageIndex.insert(moodIndex!, at: 0)
        }
    }
}

extension UINavigationBar {
    static func changeAppearance(clear: Bool) {
        let appearance = UINavigationBarAppearance()
        
        if clear {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
