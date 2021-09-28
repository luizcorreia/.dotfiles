 -- Base
import XMonad
import System.Directory
-- import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions.
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
--import qualified XMonad.Actions.Search as S
import XMonad.Actions.Minimize
--import XMonad.Actions.UpdatePointer

    -- Data
--import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
--import Data.Maybe (isJust)
--import Data.Tree
import qualified Data.Map as M

    -- Hooks
--import XMonad.Hooks.DynamicLog (filterOutWsPP, dynamicLogWithPP, wrap, xmobarPP, sjanssenPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
--import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
--import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.UrgencyHook
--import XMonad.Hooks.FadeInactive
import XMonad.Hooks.StatusBar (StatusBarConfig, statusBarProp, xmonadPropLog, dynamicSBs)
import XMonad.Hooks.StatusBar.PP

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.Minimize
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
--import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.SpawnOnce
import XMonad.Util.ClickableWorkspaces
import XMonad.Util.Loggers.NamedScratchpad
import XMonad.Util.WorkspaceCompare
import XMonad.Util.NamedWindows (getName)


myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=12:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myAltTerminal :: String
myAltTerminal = "/usr/bin/urxvt"

myBrowser :: String
-- myBrowser = "firefox"  -- Sets qutebrowser as browser
myBrowser = "brave"  -- Sets qutebrowser as browser


myEditor :: String
myEditor = myTerminal ++ " -e nvim "    -- Sets nvim as editor

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String
myNormColor   = "#474646"   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#83a598"   -- Border color of focused windows

screenshot :: String
screenshot = "flameshot screen -p ~/Pictures"

region_screenshot :: String
region_screenshot = "flameshot gui -p ~/Pictures"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
-- windowCount = 2
fixSupportedAtoms :: X ()
fixSupportedAtoms = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    supp <- mapM getAtom [ "_NET_WM_STATE"
                         , "_NET_WM_STATE_DEMANDS_ATTENTION"
                         ]
    io $ changeProperty32 dpy r a c propModeAppend (fmap fromIntegral supp)

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "lxsession &"
    spawnOnce "picom --experimental-backends &"
    spawnOnce "nm-applet &"
    spawnOnce "volumeicon &"
    -- spawnOnce "conky -c $HOME/.config/conky/doomone-xmonad.conkyrc"
    spawnOnce "trayer --edge top --align right --distance 12 --distancefrom top --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34  --height 24 &"
    -- spawnOnce "exec ~/bin/eww daemon"
    spawn "xsetroot -cursor_name left_ptr"
    spawn "exec ~/bin/lock.sh"
    -- spawnOnce "greenclip daemon"
    spawnOnce "dunst"
    -- spawnOnce "urxvtd -q -o -f &"      -- urxvt daemon for better performance
    spawnOnce "nitrogen --restore"   -- if you prefer nitrogen to feh
    spawnOnce "discord"
    spawnOnce "discord-ptb"
    spawnOnce "slack"
    spawnOnce "thunderbird"
    setWMName "LG3D"
    <+> nspTrackStartup myScratchPads
    <+> fixSupportedAtoms

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "mocp" spawnMocp findMocp manageMocp
                , NS "calculator" spawnCalc findCalc manageCalc
                , NS "joplin" spawnJoplin findJoplin manageJoplin
                , NS "taskwarrior" spawnTaskwarrior findTaskwarrior manageTaskwarrior
                , NS "tasks" spawnTasks findTasks manageTasks
                , NS "pavucontrol" spawnPavucontrol findPavucontrol managePavucontrol
                ]
  where
    role = stringProperty "WM_WINDOW_ROLE"

    spawnPavucontrol  = "pavucontrol"
    findPavucontrol   = className =? "Pavucontrol"
    managePavucontrol = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

    spawnTasks  = myTerminal ++ " -t tasks -e tmux_start"
    findTasks   = title =? "tasks"
    manageTasks = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

    spawnTaskwarrior  = myTerminal ++ " -t taskwarrior -e tasksh"
    findTaskwarrior   = title =? "taskwarrior"
    manageTaskwarrior = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

    spawnJoplin  = myTerminal ++ " -t joplin -e joplin"
    findJoplin   = title =? "joplin"
    manageJoplin = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

    spawnTerm  = myTerminal ++ " -t scratchpad -e tmux a -t luizcorreia"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

    spawnMocp  = myTerminal ++ " -t mocp -e mocp"
    findMocp   = title =? "mocp"
    manageMocp = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- - Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ minimize
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
myMagnify  = renamed [Replace "magnify"]
           $ minimize
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ minimize
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ minimize
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ smartBorders
           $ minimize
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ smartBorders
           $ minimize
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ smartBorders
           $ minimize
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme
tallAccordion  = renamed [Replace "tallAccordion"]
           $ Accordion
wideAccordion  = renamed [Replace "wideAccordion"]
           $ Mirror Accordion

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = "xft:Mononoki Nerd Font:pixelsize=11:antialias=true:hinting=true"
                 , activeColor         = "#8ec07c"
                 , inactiveColor       = "#32302f"
                 , activeBorderColor   = "#8ec07c"
                 , inactiveBorderColor = "#1d2021"
                 , activeTextColor     = "#1d2021"
                 , inactiveTextColor   = "#ebdbb2"
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu Nerd Font:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1d2021"
    , swn_color             = "#ebdbb2"
    }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth grid
                                 ||| myMagnify
                                 ||| noBorders monocle
                                 ||| tall
                                 ||| noBorders tabs
                                 ||| floats
                                 ||| spirals
                                 ||| threeCol
                                 ||| threeRow
                                 ||| tallAccordion
                                 ||| wideAccordion

myIndexWorkspaces = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
myExtraWorkspaces = [(xK_0, " ETC ")] -- list of (key, name)
myWorkspaces = [" WWW ", " DEV ", " CHAT ", " MAIL ", " SYS ", " DOC ", " PLACE ", " LAB ", " MEDIA "] ++ (map snd myExtraWorkspaces)
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces myIndexWorkspaces -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = (composeAll . concat $
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [
       [ className =? "confirm"         --> doFloat                            ]
     , [ className =? "file_progress"   --> doFloat                            ]
     , [ className =? "dialog"          --> doFloat                            ]
     , [ className =? "download"        --> doFloat                            ]
     , [ className =? "error"           --> doFloat                            ]
     , [ className =? "Gimp"            --> doFloat                            ]
     , [ className =? "notification"    --> doFloat                            ]
     , [ className =? "pinentry-gtk-2"  --> doFloat                            ]
     , [ className =? "splash"          --> doFloat                            ]
     , [ className =? "toolbar"         --> doFloat                            ]
     , [ className =? "Yad"             --> doCenterFloat                      ]
     , [ title =? "Oracle VM VirtualBox Manager"  --> doFloat                  ]
     , [ title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 0 )      ]
     , [ className =? "brave-browser"   --> doShift ( myWorkspaces !! 0 )      ]
     , [ className =? "qutebrowser"     --> doShift ( myWorkspaces !! 9 )      ]
     , [ className =? "mpv"             --> doShift ( myWorkspaces !! 7 )      ]
     , [ className =? "Gimp"            --> doShift ( myWorkspaces !! 8 )      ]
     , [ className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )  ]
     , [ (className =? "firefox" <&&> resource =? "Dialog") --> doFloat        ] -- Float Firefox Dialog
     , [ isFullscreen -->  doFullFloat                                         ]
     , [ className =? "discord"         --> doShift ( myWorkspaces !! 2 )      ]
     , [ className =? "Slack"           --> doShift ( myWorkspaces !! 2 )      ]
     , [ className =? "Thunderbird"     --> doShift ( myWorkspaces !! 3 )      ]
     ]) <+> namedScratchpadManageHook myScratchPads

-- START_KEYS
myKeys :: [(String, X ())]
myKeys =
    -- KB_GROUP Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")  -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")    -- Restarts xmonad
        , ("M-S-q", io exitSuccess)              -- Quits xmonad
        , ("M-S-/", spawn "~/.config/xmonad/xmonad_keys.sh")

    -- KB_GROUP Run Prompt
        , ("M-S-<Return>", spawn "dmenu_run -i -p \"Run: \"") -- Dmenu

    -- KB_GROUP Other Dmenu Prompts
    -- In Xmonad and many tiling window managers, M-p is the default keybinding to
    -- launch dmenu_run, so I've decided to use M-p plus KEY for these dmenu scripts.
        , ("M-p a", spawn "dm-sounds")    -- choose an ambient background
        , ("M-p b", spawn "dm-setbg")     -- set a background
        , ("M-p c", spawn "dm-colpick")   -- pick color from our scheme
        , ("M-p e", spawn "dm-confedit")  -- edit config files
        , ("M-p i", spawn "dm-maim")      -- screenshots (images)
        , ("M-p k", spawn "dm-kill")      -- kill processes
        , ("M-p m", spawn "dm-man")       -- manpages
        , ("M-p o", spawn "dm-bookman")   -- qutebrowser bookmarks/history
        , ("M-p p", spawn "passmenu")     -- passmenu
        , ("M-p q", spawn "dm-logout")    -- logout menu
        , ("M-p r", spawn "dm-reddit")    -- reddio (a reddit viewer)
        , ("M-p s", spawn "dm-websearch") -- search various search engines

    -- KB_GROUP Useful programs to have a keybinding for launch
        , ("M-<Return>", spawn (myTerminal))
        , ("M-<F2>", spawn "pcmanfm")
        , ("M-b", spawn (myBrowser))
        , ("M-M1-h", spawn (myTerminal ++ " -e htop"))
        , ("M-y", spawn "youtube-watch.sh")
        , ("M-M1-j", spawn "joplin-desktop")

    -- KB_GROUP screenshots
        , ("M-<KP_Print>", spawn (screenshot))
        , ("M1-S-p", spawn (region_screenshot))

    -- KB_GROUP Copy (terminals)
        , ("M-c", spawn ("xsel | xsel -i -b"))
        , ("M-v", spawn ("xsel -b | xsel"))

    -- KB_GROUP Kill windows
        , ("M-S-c", kill1)     -- Kill the currently focused client
        , ("M-S-a", killAll)   -- Kill all windows on current workspace

    -- KB_GROUP Workspaces
        , ("M-.", nextScreen)  -- Switch focus to next monitor
        , ("M-,", prevScreen)  -- Switch focus to prev monitor
        -- , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next ws
        -- , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to prev ws
        , ("M-0", windows $ W.greedyView " ETC ")
        , ("M-S-0", windows $ W.shift " ETC ")

    -- KB_GROUP Floating windows
        , ("M-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
        , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
        , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    -- KB_GROUP Increase/decrease spacing (gaps)
        , ("C-M1-j", decWindowSpacing 4)         -- Decrease window spacing
        , ("C-M1-k", incWindowSpacing 4)         -- Increase window spacing
        , ("C-M1-h", decScreenSpacing 4)         -- Decrease screen spacing
        , ("C-M1-l", incScreenSpacing 4)         -- Increase screen spacing

    -- KB_GROUP Windows navigation
        , ("M-m", windows W.focusMaster)  -- Move focus to the master window
        , ("M-j", windows W.focusDown)    -- Move focus to the next window
        , ("M-k", windows W.focusUp)      -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
        , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    -- KB_GROUP Layouts
        , ("M-<Tab>", sendMessage NextLayout)           -- Switch to next layout
        , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

    -- KB_GROUP Increase/decrease windows in the master pane or the stack
        , ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane
        , ("M-C-<Up>", increaseLimit)                   -- Increase # of windows
        , ("M-C-<Down>", decreaseLimit)                 -- Decrease # of windows

    -- KB_GROUP Window resizing
        , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M-M1-k", sendMessage MirrorExpand)          -- Expand vert window width

    -- KB_GROUP Window minimize
        , ("M-n", withFocused minimizeWindow)
        , ("M-S-n", withLastMinimized maximizeWindowAndFocus)


    -- KB_GROUP Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
        , ("M-C-h", sendMessage $ pullGroup L)
        , ("M-C-l", sendMessage $ pullGroup R)
        , ("M-C-k", sendMessage $ pullGroup U)
        , ("M-C-j", sendMessage $ pullGroup D)
        , ("M-C-m", withFocused (sendMessage . MergeAll))
        -- , ("M-C-u", withFocused (sendMessage . UnMerge))
        , ("M-C-/", withFocused (sendMessage . UnMergeAll))
        , ("M-C-.", onGroup W.focusUp')    -- Switch focus to next tab
        , ("M-C-,", onGroup W.focusDown')  -- Switch focus to prev tab

    -- KB_GROUP Scratchpads
    -- Toggle show/hide these programs.  They run on a hidden workspace.
    -- When you toggle them to show, it brings them to your current workspace.
    -- Toggle them to hide and it sends them back to hidden workspace (NSP).
        , ("M-s t", namedScratchpadAction myScratchPads "terminal")
        , ("M-s m", namedScratchpadAction myScratchPads "mocp")
        , ("M-s c", namedScratchpadAction myScratchPads "calculator")
        , ("M-s j", namedScratchpadAction myScratchPads "joplin")
        , ("M-s w", namedScratchpadAction myScratchPads "taskwarrior")
        , ("M-s s", namedScratchpadAction myScratchPads "tasks")
        , ("M-s p", namedScratchpadAction myScratchPads "pavucontrol")

    -- KB_GROUP Controls for mocp music player (SUPER-u followed by a key)
        , ("M-u p", spawn "mocp --play")
        , ("M-u l", spawn "mocp --next")
        , ("M-u h", spawn "mocp --previous")
        , ("M-u <Space>", spawn "mocp --toggle-pause")


    -- KB_GROUP Multimedia Keys
        , ("<XF86AudioPlay>", spawn (myTerminal ++ "playerctl play-pause"))
        , ("<XF86AudioPrev>", spawn (myTerminal ++ "playerctl previous"))
        , ("<XF86AudioNext>", spawn (myTerminal ++ "playerctl next"))
        , ("<XF86AudioMute>", spawn "amixer set Master toggle")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        , ("<XF86HomePage>", spawn "qutebrowser https://www.youtube.com/c/DistroTube")
        , ("<XF86Search>", spawn "dmsearch")
        , ("<XF86Mail>", runOrRaise "thunderbird" (resource =? "thunderbird"))
        , ("<XF86Calculator>", runOrRaise "qalculate-gtk" (resource =? "qalculate-gtk"))
        , ("<XF86Eject>", spawn "toggleeject")
        , ("<Print>", spawn "dmscrot")
        ]
    -- The following lines are needed for named scratchpads.
          -- where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
          --      nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))
-- END_KEYS
--

myPP :: PP
myPP = xmobarPP
              -- the following variables beginning with 'pp' are settings for xmobar.
              { ppCurrent = xmobarColor "#e78a4e" "" . wrap "[" "]"         -- Current workspace
              , ppVisible = xmobarColor "#e78a4e" "" . clickable              -- Visible but not current workspace
              , ppHidden = xmobarColor "#ebdbb2" "" . clickable -- Hidden workspaces
              , ppHiddenNoWindows = xmobarColor "#a9b665" ""  . clickable     -- Hidden workspaces (no windows)
              , ppTitle = xmobarColor "#d3869b" "" . shorten 60               -- Title of active window
              , ppSep =  "<fc=#b16286> | </fc>"                    -- Separator character
              , ppUrgent = xmobarColor "#fb4934" "" . wrap "!" "!" . clickable    -- Urgent workspace
              , ppExtras  = [windowCount]                                     -- # of windows current workspace
              -- do not show NSP at end of workspace list
              , ppSort = fmap (.filterOutWs[scratchpadWorkspaceTag]) $ ppSort def
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
              }


xmobarRight :: StatusBarConfig
xmobarRight    = statusBarProp "xmobar -x 0 ~/.config/xmobar/xmobarrc"
                (clickablePP myPP)
xmobarLeft :: StatusBarConfig
xmobarLeft    = statusBarProp "xmobar -x 1 ~/.config/xmobar/xmobarrc1"
                (clickablePP myPP)

barSpawner :: ScreenId -> IO StatusBarConfig
barSpawner 0 = pure $ xmobarRight
barSpawner 1 = pure $ xmobarLeft
barSpawner _ = mempty -- nothing on the rest of the screens

main :: IO ()
main = do
    -- the xmonad, ya know...what the WM is named after.!
    -- xmonad $ withSB (xmobarRight <> xmobarLeft) $ ewmh $ def
    xmonad $ dynamicSBs barSpawner $ ewmh $ withUrgencyHook LibNotifyUrgencyHook $ def
        { manageHook         = myManageHook <+> manageDocks
        , handleEventHook    = handleEventHook def <+> docksEventHook
                               -- Uncomment this line to enable fullscreen support on things like YouTube/Netflix.
                               -- This works perfect on SINGLE monitor systems. On multi-monitor systems,
                               -- it adds a border around the window if screen does not have focus. So, my solution
                               -- is to use a keybinding to toggle fullscreen noborders instead.  (M-<Space>)
                               -- <+> fullscreenEventHook
        , logHook            = dynamicLogString myPP >>= xmonadPropLog
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        } `additionalKeysP` myKeys
