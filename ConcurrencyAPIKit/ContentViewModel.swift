//
//  ContentViewModel.swift
//  ConcurrencyAPIKit
//
//  Created by Toshiya Kobayashi on 2022/09/16.
//

import APIKit
import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    @Published private(set) var text = "Hello, world!"
    @Published private(set) var isLoading = false

    func load() async {
        do {
            isLoading = true
            defer {
                isLoading = false
            }

            text = "Loading..."
            let response = try await Session.shared.send(DelayRequest())
            text = "Success: \(response.url.absoluteString)"
        } catch {
            text = "Failure: \(error.localizedDescription)"
        }
    }
}
