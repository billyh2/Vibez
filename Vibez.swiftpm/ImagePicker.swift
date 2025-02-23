//
//  File.swift
//  Vibez
//
//  Created by Billy Huang on 2022-04-17.
//

import SwiftUI

struct ImagePicker: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var name: String?
    @Binding var index: Int?

    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    let pickableItems = [
        "i1",
        "i2",
        "i3",
        "i4",
        "i5",
        "i6",
        "i7",
        "i8",
        "i9",
        "i10",
        "i11",
        "i12",
        "i13",
    ]
    
    let pickableItemsDic = [
        "i1":2,
        "i2":2,
        "i3":2,
        "i4":1,
        "i5":1,
        "i6":1,
        "i7":1,
        "i8":2,
        "i9":2,
        "i10":1,
        "i11":1,
        "i12":1,
        "i13":2,
    ]
//    let pickableItems = [
//        "house.fill",
//        "sun.max.fill",
//        "cloud.rain.fill",
//        "pawprint.fill",
//        "lungs.fill",
//        "face.smiling",
//        "gear",
//        "allergens",
//        "bolt.heart",
//        "ladybug.fill",
//        "bus.fill",
//        "bicycle.circle",
//        "faceid",
//        "gamecontroller.fill",
//        "timer",
//        "eye.fill",
//        "person.icloud",
//        "tortoise.fill",
//        "hare.fill",
//        "leaf.fill",
//        "wand.and.stars",
//        "globe.americas.fill",
//        "globe.europe.africa.fill",
//        "globe.asia.australia.fill",
//        "hands.sparkles.fill",
//        "hand.draw.fill",
//        "waveform.path.ecg.rectangle.fill",
//        "gyroscope",
//
//    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(pickableItems, id: \.self) { item in
                    Button {
                        self.name = item
                        self.index = pickableItemsDic[item]
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(item)
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea(.container, edges: .bottom)
                    }
                    .padding()
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
