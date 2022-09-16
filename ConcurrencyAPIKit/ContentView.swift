//
//  ContentView.swift
//  ConcurrencyAPIKit
//
//  Created by Toshiya Kobayashi on 2022/09/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var task: Task<Void, Never>?

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.text)
            if viewModel.isLoading {
                Button("Cancel") {
                    task?.cancel()
                }
            } else {
                Button("Start") {
                    task = Task {
                        await viewModel.load()
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
