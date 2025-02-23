//
//  File.swift
//  Vibez
//
//  Created by Billy Huang on 2022-04-15.
//

import SwiftUI

struct PlaylistView: View {
        

    var columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 2)

    @State var instrument: String
    @State var stems: [String]
    // Binding addedDic
    @Binding var addedDic: [String:Bool]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isPlaying = [
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
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(stems, id: \.self) {stem in
                        HStack(spacing: 20) {
                            Button ( action: {
                                if(isPlaying[stem] == true) {
                                    isPlaying[stem] = false
                                    pauseSound()
                                }
                                else {
                                    isPlaying[stem] = true
                                    playSound(key: stem, cnt: 1)
                                }
                            }, label: {
                                    Text(stem)
                                        .font(.system(size: 18))
                                        .fontWeight(.bold)
                            })
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Spacer()
                            
                            Button (action: {
                                // revise the Bool value in addedDic once click the Button
                                if (addedDic[stem]==false){
                                    addedDic[stem] = true
                                } else {
                                    addedDic[stem] = false
                                }                        }, label: {
                                    if (addedDic[stem]==false){
                                        Image(systemName: "checkmark.circle")
                                    } else {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                            })
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .navigationTitle(instrument)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 13)
                                .fill(Color.red)
                                .frame(width: 90, height: 30)
                                .shadow(color: Color(#colorLiteral(red: 0.3294117748737335, green: 0.3294117748737335, blue: 0.3294117748737335, alpha: 0.6899999976158142)), radius: 4, x: 0, y: 3)
                            
                                                            
                            Text("Done")
                                .fontWeight(.bold)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        }
                    }
                }
            }
        }
        
        
    }
//    func removeIndex(key: String) {
//        if let index = stems.firstIndex(of: key) {
//            stems.remove(at: index)
//        }
//    }
}

//public struct Stem {
//    var name: String
//    var isPlaying: Bool
//    var added: Bool
//}
