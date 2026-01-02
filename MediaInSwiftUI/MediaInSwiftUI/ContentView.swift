//
//  ContentView.swift
//  MediaInSwiftUI
//
//  Created by Neosoft on 02/01/26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selected: PhotosPickerItem?
    @State private var picture: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: (picture ?? UIImage(named: "noImage"))!)
                    .resizable()
                    .scaledToFit()
                Spacer()
                PhotosPicker(selection: $selected, matching: .images,photoLibrary: .shared()) {
                    Text("Select a photo")
                        .padding()
                        .buttonStyle(.borderedProminent)
                }
            }
            .onChange(of: selected, initial: false) { oldValue, newValue in
                Task(priority: .background) {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        picture = UIImage(data: data)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
