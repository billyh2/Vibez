//
//  File.swift
//  Vibez
//
//  Created by Billy Huang on 2022-04-14.
//

import SwiftUI

struct Search: View {
    
    @State var isPlaying = false
    
    var columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 2)
    
    @State private var blocks: [Block] = []
    let colors: [Color] = [.blue, .gray, .red, .orange, .green, .black, .white, .pink]
    
    let gradient = LinearGradient(colors: [.orange, .green],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)

    
    
    @State private var isPresentingBlock: Block? = nil
    @Binding var recurse: Bool
    @Binding var step : Int
    @Binding var gamemode : String
    @Binding var introText: Int
    @Binding var page: Int
    // define a dictionary to find the relationship between short music and added property for all stems, which binding with PlaylistView
    @State private var addedDic = [
        "Blues": false,
        "Campfire": false,
        "Hazard": false,
        "Urgency": false,
        "Horizon": false,
        "Vacation": false,
        "Orchestral": false,
        "Driller": false,
        "Home": false,
        "Spirit": false,
        "Scream": false,
        "Mountain": false,
        "Vibe": false,
        "Soldier": false,
        "Stars": false,
        "Sky": false,
        "Party": false,
        "Player": false,
        "Tammy": false,
        "Bounce": false,
        "Boombap": false,
    ]
    
    // define a dictionary to find relationship between short musci and mood index for all stems.
    let moodDic = [
        "Blues": 1,
        "Campfire": 1,
        "Hazard": 1,
        "Urgency": 2,
        "Horizon": 1,
        "Vacation": 1,
        "Orchestral": 2,
        "Driller": 2,
        "Home": 1,
        "Spirit": 1,
        "Scream": 2,
        "Mountain": 2,
        "Vibe": 1,
        "Soldier": 1,
        "Stars": 1,
        "Sky": 1,
        "Party": 2,
        "Player": 2,
        "Tammy": 1,
        "Bounce": 2,
        "Boombap": 1,
    ]
    
    
    
    @State private var musicList1 =
    [
        "Lofi1",
        "Lofi2",
        "Lofi3",
        "Lofi4",
        "Lofi5",
        "Lofi6",
    ]
    
    @State private var musicList2 =
    [
        "Workout1",
        "Workout2",
        "Workout3",
        "Workout4",
    ]
    
    public init( _ recurse: Binding<Bool>, _ step: Binding<Int>, _ gamemode: Binding<String>, _ introText: Binding<Int>, _ page: Binding<Int>) {
            self._recurse = recurse
            self._step = step
            self._gamemode = gamemode
            self._introText = introText
            self._page = page
    }
    
    var body: some View {
        
        // Search View...
        ScrollView{
            
            VStack(spacing: 18){
                
                HStack{
                    
                    Text("Stem Player")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                    recurse = true
                    step = 1
                    gamemode = ""
                    introText = 2
                    page = 2
                    }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .fill(Color.red)
                            .frame(width: 90, height: 30)
                            .shadow(color: Color(#colorLiteral(red: 0.3294117748737335, green: 0.3294117748737335, blue: 0.3294117748737335, alpha: 0.6899999976158142)), radius: 4, x: 0, y: 3)
                        
                                                        
                        Text("Exit")
                            .fontWeight(.bold)
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    }
                    })
                }
                
                // Grid View Of Songs....
                
                LazyVGrid(columns: columns,spacing: 20){

                    
                    ForEach(blocks, id: \.id) { block in
                        Button (action: {
                            isPresentingBlock = block
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .fill(block.color)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: (UIScreen.main.bounds.height - 50)/3)
                                    .cornerRadius(15)
                                    .ignoresSafeArea()
                                VStack {
                                    Spacer()
                                    Text(block.instrument)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(block.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 200)
                                    Spacer()
                                }
                            }
                        })

                            // two side padding = 30
                            // spacing = 20
                            // total = 50

                    }
                    .sheet(item: $isPresentingBlock) {block in
                        // remember binding addedDic with PlayView at here
                        PlaylistView(instrument: block.instrument, stems: block.stems, addedDic: $addedDic)
                    }
                }
                .padding(.top,10)
            }
            .padding()
            
            // padding miniplayer size as bottom...
            .padding(.bottom)
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.status) {
                Button {
                    if(isPlaying) {
                        isPlaying.toggle()
                        pauseSound()
                    }
                    else {
                        var sum = 0
                        var number = 0
                        for(key, value) in addedDic {
                            if(value == true) {
                                sum += moodDic[key]!
                                number+=1
                            }
                        }
                        let soundIndex = (Float(sum)/Float(number)).rounded()
                        if(sum == 0) {
                            print("Please select stems")
                        }
                        else if (soundIndex == 1.0) {
                            isPlaying.toggle()
                            playSound(key: musicList1[Int.random(in: 0..<musicList1.count)], cnt: 1)
                        } else {
                            isPlaying.toggle()
                            playSound(key: musicList2[Int.random(in: 0..<musicList2.count)], cnt: 1)
                        }
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .fill(gradient)
                            .frame(width: 150, height: 30)
                            .shadow(color: Color(#colorLiteral(red: 0.3294117748737335, green: 0.3294117748737335, blue: 0.3294117748737335, alpha: 0.6899999976158142)), radius: 4, x: 0, y: 3)
                            .ignoresSafeArea()
                            HStack {
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title2)
                                    .foregroundColor(.primary)

                                
                                Text(isPlaying ? "Pause!" : "Done!")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                    .font(.system(size: 18))
                            }
                    }
                }
            }
        }
        .onAppear {
                self.blocks = Block.data
        }
    }
}
