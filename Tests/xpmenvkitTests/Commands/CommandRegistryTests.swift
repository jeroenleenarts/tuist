import Foundation
import XCTest
import xpmcore
@testable import xpmcoreTesting
@testable import xpmenvkit

final class CommandRegistryTests: XCTestCase {
    var subject: CommandRegistry!
    var errorHandler: MockErrorHandler!
    var commandRunner: MockCommandRunner!

    override func setUp() {
        super.setUp()
        errorHandler = MockErrorHandler()
        commandRunner = MockCommandRunner()
    }

    func test_run_calls_the_runner_when_the_command_is_not_found() {
        setupSubject(arguments: ["xpm", "command"], commands: [])
        subject.run()
        XCTAssertEqual(commandRunner.runCallCount, 1)
    }

    func test_run_calls_the_right_command() {
        setupSubject(arguments: ["xpm", MockCommand.command], commands: [MockCommand.self])
        subject.run()
        XCTAssertEqual((subject.commands.first! as! MockCommand).runCallCount, 1)
    }

    func test_run_reports_fatal_errors() {
        commandRunner.runStub = MockFatalError()
        setupSubject(arguments: ["xpm", "command"], commands: [])
        subject.run()
        XCTAssertEqual(errorHandler.fatalErrorArgs.count, 1)
    }

    func test_run_reports_unhandled_errors() {
        commandRunner.runStub = NSError(domain: "test", code: 1, userInfo: nil)
        setupSubject(arguments: ["xpm", "command"], commands: [])
        subject.run()
        XCTAssertEqual(errorHandler.fatalErrorArgs.count, 1)
        XCTAssertTrue(type(of: errorHandler.fatalErrorArgs.first!) == UnhandledError.self)
    }

    fileprivate func setupSubject(arguments: [String], commands: [Command.Type]) {
        subject = CommandRegistry(processArguments: { arguments },
                                  errorHandler: errorHandler,
                                  commandRunner: commandRunner,
                                  commands: commands)
    }
}