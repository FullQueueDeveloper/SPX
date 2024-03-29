import XCTest
@testable import SPXLib

final class ExecCommandTests: XCTestCase {

  func testSingleTargetFixture() throws {

    let dir = Fixtures.singleTargetFixture.dir

    let fakeRunner = ParsingFakeRunner()
    try ExecCommand(announcer: nil, runner: fakeRunner, spxDir: dir).exec(targetName: "example", targetArguments: [])

    XCTAssertEqual(fakeRunner.receivedCommands.count, 1)
    XCTAssertEqual(fakeRunner.receivedCommands.first, "swift run --package-path \(dir) example")
  }

  func testSingleTargetFixtureWithArguments() throws {

    let dir = Fixtures.singleTargetFixture.dir

    let fakeRunner = ParsingFakeRunner()
    try ExecCommand(announcer: nil, runner: fakeRunner, spxDir: dir).exec(targetName: "example", targetArguments: ["a", "b", "c"])

    XCTAssertEqual(fakeRunner.receivedCommands.count, 1)
    XCTAssertEqual(fakeRunner.receivedCommands.first, "swift run --package-path \(dir) example a b c")
  }
}
