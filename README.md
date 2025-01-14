Hammerspoon Setup Guide for Focus Follows Mouse
This guide walks you through the process of setting up focus follows mouse on macOS using Hammerspoon. The goal is to automatically focus a window when the mouse hovers over it, without needing to click. This will work with most applications, except for some Electron-based apps like Discord (for which extra steps may be required).
Prerequisites
macOS (any version that supports Hammerspoon)
Hammerspoon installed
Basic understanding of terminal commands
Step-by-Step Instructions
1. Install Hammerspoon
If you don’t have Hammerspoon installed yet, follow these steps:
Install via Homebrew:
bash
Copy code
brew install --cask hammerspoon

Alternatively, you can download the latest release from the official website:
https://www.hammerspoon.org/
After installation, launch Hammerspoon. You should see the Hammerspoon icon in your menu bar.
2. Grant Accessibility Permissions
Hammerspoon needs Accessibility permissions to interact with windows and input devices.
Open System Preferences → Security & Privacy → Privacy tab.
In the left sidebar, select Accessibility.
Add Hammerspoon to the list by clicking the + button if it isn’t already listed.
Make sure Hammerspoon is checked.
3. Configure Hammerspoon with the Focus Follows Mouse Script
Next, we’ll configure Hammerspoon to use the script for focus follows mouse behavior.
Create the Hammerspoon Configuration File:
Open Hammerspoon and click the Hammerspoon icon in the menu bar.
Select "Open Config". This will open your init.lua configuration file in your default text editor.
Paste the Script into init.lua:
Replace the existing contents (if any) of init.lua with the following code:
lua
Copy code
-- Hammerspoon Script for Focus Follows Mouse (without Discord-specific logic)

hs.window.animationDuration = 0  -- Disable animations for instant focus switching

-- Function to focus the window under the mouse cursor
function focusWindowUnderMouse()
    local mouse = hs.mouse.absolutePosition()  -- Get the mouse position
    local allWindows = hs.window.allWindows()  -- Get all open windows

    -- Debugging: Print window details
    for _, win in ipairs(allWindows) do
        local appName = win:application():name()  -- Get the name of the application
        local frame = win:frame()  -- Get the window's frame
        print("Window Name: " .. win:title(), "App: " .. appName, "Frame: " .. frame.x .. ", " .. frame.y .. ", " .. frame.w .. ", " .. frame.h)
    end

    for _, win in ipairs(allWindows) do
        local appName = win:application():name()  -- Get the name of the application
        local frame = win:frame()  -- Get the window's frame

        -- Check if the mouse is within the window's frame
        if mouse.x >= frame.x and mouse.x <= (frame.x + frame.w) and
           mouse.y >= frame.y and mouse.y <= (frame.y + frame.h) then
            -- Focus the window under the mouse (for any application)
            win:focus()
            hs.application.launchOrFocus(appName)  -- Bring the app to the foreground
            break  -- Exit the loop after focusing the first window under the mouse
        end
    end
end

-- Set a timer to constantly check if the mouse is over a window that should be focused
hs.timer.doEvery(0.1, focusWindowUnderMouse)  -- Run this function every 0.1 seconds

4. Reload Hammerspoon Configuration
After saving the init.lua file with the script:
Click the Hammerspoon icon in the menu bar.
Select Reload Config to apply the changes.
Alternatively, you can restart Hammerspoon to reload the configuration.
5. Test the Functionality
Now that you’ve configured Hammerspoon, you should be able to test the focus follows mouse functionality:
Move your mouse over any window, and that window should automatically be focused.
If the window isn't already the active app, it will be brought to the front as well.
6. (Optional) Debugging
If things aren’t working as expected, try these troubleshooting steps:
Open Hammerspoon’s Console (click the Hammerspoon icon in the menu bar → Console) to view any error messages or logs.
You can add debugging lines to the script by inserting print() statements inside the focusWindowUnderMouse() function to inspect what’s happening.

Troubleshooting
Hammerspoon Isn’t Responding:
If the script doesn’t seem to be running correctly, check Hammerspoon’s Console (from the menu bar) for any errors. Make sure you've granted the correct Accessibility permissions in System Preferences → Security & Privacy → Privacy.
Focus Isn't Working:
Some apps may not immediately respond to the focus behavior. If a specific app is causing issues, try checking for any app-specific settings or consult the Hammerspoon forums for additional tweaks.
Discord Doesn't Work:
Discord may not respond correctly to the focus follows mouse behavior due to it being an Electron-based application. Electron apps like Discord often have custom window management that can override macOS's window focus behavior. Unfortunately, these apps might require more specific interaction methods to work as expected.
You may need to manually click to focus Discord, as it often doesn’t respond well to focus commands sent by external tools like Hammerspoon.

Additional Notes
This script will focus windows under the mouse, but it doesn’t interact with the Electron-based app Discord because it has unique focus behavior that might require additional configuration.
The script runs a check every 0.1 seconds to detect which window the mouse is over, and it ensures that the focused window is brought to the front. If you want to change the check interval, modify the value in hs.timer.doEvery(0.1, focusWindowUnderMouse) (e.g., use 0.5 for a slower check interval).

Conclusion
With this setup, you should now have focus follows mouse working for most of your macOS apps. Hammerspoon gives you fine-grained control over window management, and with this script, your workflow should become much more efficient by removing the need for extra clicks.
If you run into any issues or have further questions, feel free to reach out!
