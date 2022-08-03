module Config where

-- XMonad modules
import XMonad


-- GUI

font         = "Consolas-9:rgba=rgb"
defaultBG    = "#dbdbdb"
defaultFG    = "#000000"
hilightBG    = "#5e8eba"
hilightFG    = "#ffffff"


-- PANEL

wTrayer = 100
wConky  = 140
wHbar   = 280 -- width of piped dzen
height  = "18"

hbar    =  "hbar -cmbdt | "
conkyrc = "/home/mntnoe/.conkyrc-dzen"

-- KEYS

i  = mod5Mask -- (I)SO_LEVEL5_SHIFT
u  = mod4Mask -- S(U)PER
s  = shiftMask
m  = mod1Mask
c  = controlMask
is = i .|. s
im = i .|. m
ic = i .|. c
us = u .|. s

-- APP

-- | Workspace containing "hidden" windows. Treated specially by workspace handling commands.
hiddenWorkspaceTag :: String
hiddenWorkspaceTag = "H"

-- | Workspace containing "summoned" windows. Treated specially by workspace handling commands.
summonWorkspaceTag :: String
summonWorkspaceTag = "S"
