import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ICCCMFocus
import XMonad.StackSet hiding (workspaces)
import XMonad.Actions.SpawnOn
import XMonad.Actions.CopyWindow
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS
import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.RunOrRaise
import Data.List
import Data.Monoid
import Control.Concurrent
import Data.Ratio ((%))

myModMask = mod1Mask  -- rebind Mod to Super key
myTerminal = "urxvt"
myTerminalBig = "xterm -fs 25"
myBorderWidth = 2
myWorkspaces = [ "1:web"
               , "2:term"
               , "3:mail"
               , "4:terms"
               , "5:code"
               , "6:dev"
               , "7:misc"
               , "8:music"
               , "9:vbox"
               , "0:empty"
               , "+:irc" ]

myLayoutHook = onWorkspace "1:web" webLayout
             $ onWorkspace "2:term" fullLayout
             $ onWorkspace "3:mail" webLayout
             $ onWorkspace "4:terms" webLayout
             $ onWorkspace "8:music" verticalLayout
             $ onWorkspace "+:irc" noTitleLayout
             $ layouts
        where layouts = smartBorders $ avoidStruts $ (layoutHook defaultConfig ||| Grid ||| ThreeCol 1 (3/100) (1/2))
              webLayout = smartBorders $ avoidStruts (Tall 1 (3/100) (60/100) ||| Full)
              fullLayout = smartBorders $ noBorders Full
              noTitleLayout = smartBorders $ avoidStruts (Tall 1 (3/100) (1/2) ||| Full)
              verticalLayout = smartBorders $ avoidStruts (Grid ||| Full)

myManageHook = (composeAll
    [isFullscreen                   --> doFullFloat
    , className =? "Firefox"        --> doShift "1:web"
    , className =? "Thunderbird"    --> doShift "3:mail"
    , className =? "Spotify"        --> doShift "8:music"
    , className =? "VirtualBox"     --> doShift "9:vbox"
    , className =? "Pidgin"         --> doShift "+:irc"
    , title     =? "xterm_2"        --> doShift "2:term"
    , title     =? "xterm_4"        --> doShift "4:terms"
    , title     =? "xterm_5"        --> doShift "5:code"
    ]) <+> myFloats <+> manageDocks <+> manageHook defaultConfig

myFloats = composeOne
    [className  =? "XCalc"      -?> doCenterFloat
    , className =? "Gedit"      -?> doCenterFloat
    , className =? "Xmessage"   -?> doCenterFloat
    , className =? "Zenity"     -?> doCenterFloat
    , className =? "feh"        -?> doCenterFloat
    , title     =? "Save As..." -?> doCenterFloat
    , title     =? "Save File"  -?> doCenterFloat
    , return True               -?> insertPosition Below Newer
    ]

myLogHook xmproc = dynamicLogWithPP $ xmobarPP {
                     ppOutput = hPutStrLn xmproc
                   , ppTitle = xmobarColor lightTextColor ""
                   , ppCurrent = xmobarColor focusColor ""
                   , ppVisible = xmobarColor lightTextColor ""
                   , ppHiddenNoWindows = xmobarColor lightBackgroundColor ""
                   , ppUrgent = xmobarColor myUrgentColor ""
                   , ppSep = " :: "
                   , ppWsSep = " "
                   }

focusColor = "#EEEEFF"
textColor = "#0A34BF"
lightTextColor = "#A6A6D1"
backgroundColor = "#5071DE"
lightBackgroundColor = "#241D40"
myUrgentColor = "#ffc000"
myFocusedBorderColor = "#FF0000"

myKeys =
    [ ((myModMask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "scrot -s")
    , ((0, xK_Print), spawn "scrot")
    , ((myModMask .|. shiftMask, xK_s), sendMessage ToggleStruts)
    , ((myModMask .|. shiftMask, xK_p), startupPrograms)
    , ((myModMask .|. shiftMask, xK_f), fullFloatFocused)
    , ((myModMask, xK_p), spawn "dmenu_run -i -fn \'-*-fixed-*-*-*-20-*-*-*-*-*-iso8859-15\'")
    , ((myModMask .|. shiftMask, xK_t), spawn myTerminalBig)
    , ((myModMask .|. shiftMask, xK_b), spawn "ncmpcpp-status")
    , ((myModMask .|. shiftMask, xK_n), spawn "ncmpcpp pause")
    , ((myModMask .|. shiftMask, xK_m), spawn "ncmpcpp play")
    , ((myModMask .|. shiftMask, xK_comma), spawn "ncmpcpp prev")
    , ((myModMask .|. shiftMask, xK_period), spawn "ncmpcpp next")
    , ((myModMask .|. controlMask, xK_x), runOrRaisePrompt myXPConfig)
    , ((myModMask, xK_F1), manPrompt myXPConfig)
    , ((myModMask, xK_u), goToSelected defaultGSConfig)
    , ((0, 0x1008FF11), spawn "amixer -D pulse set Master 5%-") -- XF86XK_AudioLowerVolume
    , ((0, 0x1008FF13), spawn "amixer -D pulse set Master 5%+") -- XF86XK_AudioRaiseVolume
    , ((0, 0x1008FF12), spawn "amixer -D pulse set Master toggle && amixer -D pulse set PCM unmute") -- XF86XK_AudioMute
    -- , ((myModMask, xK_c), kill) -- Close window
    , ((myModMask .|. controlMask, xK_Left), prevWS) -- Shift to previous workspace
    , ((myModMask .|. controlMask, xK_Right), nextWS) -- Shift to next workspace
    , ((myModMask .|. shiftMask, xK_Left), shiftToPrev) -- Shift window to previous workspace
    , ((myModMask .|. shiftMask, xK_Right), shiftToNext) -- Shift window to next workspace
    ]
    ++
    [((m .|. myModMask, k), windows $ f i)
    | (i, k) <- zip myWorkspaces [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0, xK_plus]
    , (f, m) <- [(greedyView, 0), (shift, shiftMask)]]

myXPConfig = defaultXPConfig {
      font = "xft: inconsolata-14"
    , position = Top
    , promptBorderWidth = 0
}

startupPrograms = do
                  spawn (myTerminal ++ " -title xterm_2")
                  spawn (myTerminal ++ " -title xterm_4")
                  spawn (myTerminal ++ " -title xterm_4")
                  spawn (myTerminal ++ " -title xterm_5")
                  spawnOn "1:web" "firefox"
                  spawnOn "3:mail" "thunderbird"
                  spawnOn "8:music" "spotify"
                  spawnOn "+:irc" "pidgin"

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar"
  xmonad $ defaultConfig {
               terminal = myTerminal
             , manageHook = myManageHook
             , layoutHook = myLayoutHook
             , borderWidth = myBorderWidth
             , focusedBorderColor = myFocusedBorderColor
             , modMask = myModMask
             , logHook = myLogHook xmproc >> ewmhDesktopsLogHook >> setWMName "LG3D" >> takeTopFocus
             --, startupHook = setWMName "LG3D" -- Fix Java programs
             , workspaces = myWorkspaces
             } `additionalKeys` myKeys

fullFloatFocused =
    withFocused $ \f -> windows =<< appEndo `fmap` runQuery doFullFloat f
