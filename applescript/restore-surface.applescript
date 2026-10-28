on run argv
    if (count of argv) is not 2 then return "invalid"
    set expectedID to item 1 of argv
    set resumeCommand to item 2 of argv

    tell application "Ghostty"
        -- Native window restoration may preserve an app-hidden or minimized
        -- state. Bring Ghostty forward, then focus the exact restored surface
        -- before typing so its containing window is visible without requiring
        -- System Events accessibility permissions.
        activate
        repeat with terminalRef in terminals
            if (id of terminalRef as text) is expectedID then
                focus terminalRef
                delay 0.05
                input text resumeCommand to terminalRef
                delay 0.05
                send key "enter" to terminalRef
                return "restored"
            end if
        end repeat
    end tell

    return "missing"
end run

