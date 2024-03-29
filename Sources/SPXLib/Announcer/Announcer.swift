import Foundation
import Rainbow

struct Announcer {

  func fileCreated(path: String) {
    self.announce("Created `\(path)`")
  }

  func fileModified(path: String) {
    self.announce("Modified `\(path)`")
  }

  func running(target: String) {
    self.announce("Running target named `\(target)`")
  }

  func list(targets: [SwiftPackageDescription.Target]) {
    self.announce("Available targets:")
    for t in targets {
      self.announce("\t\(t.name)")
    }
  }

  func scaffolding(template: Templates, path: String) {
    self.announce("Scaffolding template \(template.rawValue.cyan) in folder `\(path)`")
  }

  func building(path: String) {
    self.announce("Building package at `\(path)`")
  }

  func error(_ error: Error) {
    self.announce(error)
  }
}

private extension Announcer {

  func announce(_ text: String) {
    ("[SPX] ".cyan + text.yellow + "\n")
      .data(using: .utf8)
      .map(FileHandle.standardError.write)
  }

  func announce(_ error: Error) {

    ("[SPX] ".cyan + error.localizedDescription.red + "\n")
      .data(using: .utf8)
      .map(FileHandle.standardError.write)

    if let recovery = (error as? LocalizedError)?.recoverySuggestion {
      self.announce(recovery)
    }
  }
}
