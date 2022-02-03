#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Regular Window Size
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🔲
// @raycast.packageName Window Management

// Documentation:
// @raycast.description Position frontmost window centered and padded on the screen, with a 5/4 aspect ratio.
// @raycast.author Leo Driesch
// @raycast.authorURL https://github.com/leodr

import AppKit

let aspectRatio = 5.0 / 4.0
let paddingPercentage = 0.032

if let screen = NSScreen.main {
  let visibleFrame = screen.visibleFrame

  let visibleFrameHeight = Double(visibleFrame.height)
  let visibleFrameWidth = Double(visibleFrame.width)

  let padding = visibleFrameHeight * paddingPercentage

  let height = visibleFrameHeight - padding * 2
  let width = height * aspectRatio

  let menuBarHeight =
    screen.frame.height - screen.visibleFrame.height
    - (screen.visibleFrame.origin.y - screen.frame.origin.y)

  let left = (visibleFrameWidth - width) / 2.0
  let top = menuBarHeight + padding

  let appleScript = """
      tell application "System Events" to tell application processes whose frontmost is true
        tell window 1
          set {size, position} to {{\(width), \(height)}, {\(left), \(top)}}
        end tell
      end tell
    """

  var error: NSDictionary?
  if let scriptObject = NSAppleScript(source: appleScript) {
    scriptObject.executeAndReturnError(
      &error
    )
  }
}
