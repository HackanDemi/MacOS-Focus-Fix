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
hs.timer.doEvery(0.01, focusWindowUnderMouse)  -- Run this function every 0.01 seconds
