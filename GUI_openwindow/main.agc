
// Project: GUI_openwindow 
// Created: 2023-11-28

// show all errors
SetErrorMode(2)

// set window properties
Global G_width, G_height
G_width = 1024
G_height = 768
SetWindowTitle( "GUI_openwindow" )

SetWindowSize( G_width, G_height, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution(G_width, G_height ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

#include "gui_openwindow.agc"

CreateSprite(1, 0)
SetSpritePosition(1, (g_width-200)*0.5, 100)
SetSpriteColor(1, 150, 150, 150, 255)
SetSpriteSize(1, 200, 50)

do
    
	
    Print("Clic on the buton to open a window with a menu" )
    if GetPointerReleased()
		if GetSpriteHit(getpointerx(), getpointery()) = 1
			menu = CreateWindowMenu("New game,Load game,Credits,Options,")
			if menu>-1
				message("you choose the menu : "+str(menu))
			endif
		endif
	endif
    Sync()
loop


