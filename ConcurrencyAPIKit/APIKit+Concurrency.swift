//
//  APIKit+Concurrency.swift
//  ConcurrencyAPIKit
//
//  Created by Toshiya Kobayashi on 2022/09/16.
//

import APIKit

extension Session {
    private final class Canceller: @unchecked Sendable {
        var task: SessionTask?
    }

    func send<T: Request>(_ request: T) async throws -> T.Response {
        let canceller = Canceller()
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                canceller.task = send(request) { continuation.resume(with: $0) }
            }
        } onCancel: {
            canceller.task?.cancel()
        }
    }
}
