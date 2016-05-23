import System.IO
import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout
import XMonad.Layout.DragPane
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts

import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce

import XMonad.Prompt
import XMonad.Prompt.Window

-- Color Setting
colorBlue      = "#9fc7e8"
colorGreen     = "#a5d6a7"
colorRed       = "#ef9a9a"
colorGray      = "#9e9e9e"
colorWhite     = "#ffffff"
colorGrayAlt   = "#eceff1"
colorNormalbg  = "#1c1c1c"
colorfg        = "#9fa8b1"

main :: IO()

main = do
  statusBar <- spawnPipe myStatusBar
  
  xmonad $ ewmh defaultConfig
	  { borderWidth = 2
    , terminal = "urxvt"
    , normalBorderColor = colorGray 
    , focusedBorderColor = colorGreen
    , logHook = myLogHook statusBar
    , layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout }


myLayout = (spacing 18 $ ResizableTall 1 (3/100) (3/5) [])
            ||| (spacing 2 $ (dragPane Horizontal (1/10) (1/2)))
            ||| (dragPane Vertical (1/10) (1/2))

myLogHook h = dynamicLogWithPP $ statusPP { ppOutput = hPutStrLn h }

myStatusBar = "xmobar $HOME/.xmonad/xmobarrc"

statusPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                    , ppCurrent         = xmobarColor colorGreen colorNormalbg . \s -> "X"
                    , ppUrgent          = xmobarColor colorfg    colorNormalbg . \s -> "O"
                    , ppVisible         = xmobarColor colorfg    colorNormalbg . \s -> "O"
                    , ppHidden          = xmobarColor colorfg    colorNormalbg . \s -> "O"
                    , ppHiddenNoWindows = xmobarColor colorfg    colorNormalbg . \s -> "O"
                    , ppTitle           = xmobarColor colorGreen colorNormalbg
                    , ppOutput          = putStrLn
                    , ppWsSep           = " "
                    , ppSep             = "  "
                    }
