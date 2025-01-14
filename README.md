### Step-by-Step Instructions

### 1. Install **Hammerspoon**

If you don't have **Hammerspoon** installed yet, follow these steps:

#### Install via Homebrew:

```bash
brew install --cask hammerspoon
```
Alternatively, you can download the latest release from the official website:

`https://www.hammerspoon.org/`

After installation, **launch** Hammerspoon. You should see the Hammerspoon icon in your menu bar.

### 2\. Grant Accessibility Permissions

Hammerspoon needs **Accessibility permissions** to interact with windows and input devices.

-   **Open System Preferences** → **Security & Privacy** → **Privacy** tab.
-   In the left sidebar, select **Accessibility**.
-   **Add Hammerspoon** to the list by clicking the `+` button if it isn't already listed.
-   Make sure **Hammerspoon** is checked.

### 3\. Configure Hammerspoon with the Focus Follows Mouse Script

Next, we'll configure Hammerspoon to use the script for focus follows mouse behavior.

#### Create the Hammerspoon Configuration File:

1.  **Open Hammerspoon** and click the Hammerspoon icon in the menu bar.
2.  Select **"Open Config"**. This will open your `init.lua` configuration file in your default text editor.

#### Paste the Script into `init.lua`:

Replace the existing contents (if any) of `init.lua` with the following code:


```
-- Hammerspoon Script for Focus Follows Mouse

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
hs.timer.doEvery(0.01, focusWindowUnderMouse)  -- Run this function every 0.01 seconds
```

### 4\. Reload Hammerspoon Configuration

After saving the `init.lua` file with the script:

-   Click the Hammerspoon icon in the menu bar.
-   Select **Reload Config** to apply the changes.

Alternatively, you can **restart Hammerspoon** to reload the configuration.

### 5\. Test the Functionality

Now that you've configured Hammerspoon, you should be able to test the **focus follows mouse** functionality:

-   **Move your mouse** over any window, and that window should automatically be **focused**.
-   If it doesn't work within the first couple clicks, it is normal and will work consistently after that.
-   If the window isn't already the active app, it will be brought to the front as well.

### 6\. (Optional) Debugging

If things aren't working as expected, try these troubleshooting steps:

-   Open Hammerspoon's **Console** (click the Hammerspoon icon in the menu bar → **Console**) to view any error messages or logs.
-   You can add debugging lines to the script by inserting `print()` statements inside the `focusWindowUnderMouse()` function to inspect what's happening.
