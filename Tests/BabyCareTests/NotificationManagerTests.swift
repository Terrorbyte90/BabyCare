// Tests/BabyCareTests/NotificationManagerTests.swift
import XCTest
@testable import Ljusglimt

final class NotificationManagerTests: XCTestCase {

    func test_notificationIdentifier_hasCorrectPrefix() {
        let id = NotificationManager.identifier(for: .wakeWindow, childName: "Luna")
        XCTAssertTrue(id.hasPrefix("ljusglimt."), "Identifier saknar prefix: \(id)")
    }

    func test_allNotificationTypes_haveUniqueIdentifiers() {
        let ids = NotificationType.allCases.map {
            NotificationManager.identifier(for: $0, childName: "Test")
        }
        let unique = Set(ids)
        XCTAssertEqual(ids.count, unique.count, "Duplicerade notification identifiers")
    }

    func test_notificationContent_includesChildName() {
        let content = NotificationManager.content(for: .wakeWindow, childName: "Luna")
        XCTAssertTrue(content.title.contains("Luna") || content.body.contains("Luna"))
    }
}
