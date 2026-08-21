local darkblack = "{color0.rgba}"
local black = "{color8.rgba}"
local darkred = "{color1.rgba}"
local red = "{color9.rgba}"
local darkgreen = "{color2.rgba}"
local green = "{color10.rgba}"
local darkyellow = "{color3.rgba}"
local yellow = "{color11.rgba}"
local darkblue = "{color4.rgba}"
local blue = "{color12.rgba}"
local darkmagenta = "{color5.rgba}"
local magenta = "{color13.rgba}"
local darkcyan = "{color6.rgba}"
local cyan = "{color14.rgba}"
local darkwhite = "{color7.rgba}"
local white = "{color15.rgba}"

local foreground = "{foreground.rgba}"
local background = "{background.rgba}"

hl.config({
    ["general"] = {
        ["col.active_border"] = darkyellow,
        ["col.inactive_border"] = darkblack,
    },
    ["misc"] = {
        ["background_color"] = background
    }
})
