// window creation for menu

Type tButon
	sprite as integer
	sprite1 as integer[]
	img
	textid as integer
	textname$
	x
	y
endtype

Foldstart // constants

// SpriteID for the "window" (yuo can change it by what you need
	#Constant C_sp_win_BG 151
	#Constant C_sp_win_BGTopbar 152
	#Constant C_sp_win_BtnClose 153
	#Constant C_sp_win_BtnOK 154

// color

	#CONSTANT C_COLORUIBTN = 81
	#CONSTANT C_COLORUIBG = 61
	#CONSTANT C_COLORUIBGBARRE = 71


//********** Window *******************//
	#CONSTANT C_EVENT_POINTERPRESSED 1
	#CONSTANT C_EVENT_POINTERSTATE 2
	#CONSTANT C_EVENT_POINTERRELEASED 3

// other
	#CONSTANT C_Depth_Gadget 20
	
	#Constant d$ = chr(44) // to hide in the bycode
Foldend


// *** openwindow
Function Openwindow(x, y, w, h, btnclose, topbar)
	
	/* ****** INFOS ********* //
	This function create the base of a window, to get always the same.
	 
	You have to use the ID of ths sprite : 
	C_sp_win_BG : for the Background
	C_sp_win_BGTopbar : the topbar
	C_sp_win_BtnClose : For the buton close
	
	fr : 
	// je crée la base d‘une fenêtre, pour avoir toujours la même base.
	// attention je dois utilise des id de sprites
	//~ C_sp_win_BG 
	//~ C_sp_win_BGTopbar 
	//~ C_sp_win_BtnClose 
	
	*/
	//First, I close the privous window if it exists // d‘abord je ferme la précédente window (peut etre je créer un systeme pour en avoir plusieurs si je vois que c‘est nécessaire)
	
	closewindow()
	
	// Create the BG of the window // on crée le fond de la fenêtre
	d = C_DEPTH_GADGET-13
	h1 = 40
	
	n = C_sp_win_BG
	AddSprite(n, 0, x, y, d+1, 1)
	SetSpriteSize(n, w, h)
	c = C_COLORUIBG
	SetSpriteColor(n, c, c, c, 255)
	
	// add a topbar
	if topbar
		c = C_COLORUIBGBARRE+5
		n = C_sp_win_BGTopbar
		AddSprite(n, 0, x, y, d, 1)
		SetSpriteSize(n, w, h1)
		SetSpriteColor(n, c, c, c, 255)
	endif
	
	// add the buton close
	if btnclose // you can use 
		n = C_sp_win_BtnClose
		c = C_COLORUIBGBARRE+20
		AddSprite(n, 0, x+w-h1, y, d-1, 1)
		setspritesize(n, -1, h1)
		SetSpriteColor(n, c, c, c, 255)
	endif
	
	// add the buton ok
	if btnclose //you can use a close image
		n = C_sp_win_BtnOK
		c = C_COLORUIBGBARRE+20
		AddSprite(n, 0, x+w*0.5, y+h-h1*1.2, d-1, 1)
		setspritesize(n, -1, h1+5)
		SetSpriteColor(n, c, c, c, 255)
	endif
	
endfunction

Function SetWindowDepth(depth)
	
	// to change the depth of each basic element of the widnow (bg, topbar and btnclose)
	SetSpriteDepth(C_sp_win_BG, depth)
	
	if GetSpriteExists(C_sp_win_BGTopbar)
		SetSpriteDepth(C_sp_win_BGTopbar, depth)
	endif
	
	if GetSpriteExists(C_sp_win_BtnClose)
		SetSpriteDepth(C_sp_win_BtnClose, depth)
	endif
		
Endfunction

Function CloseWindow()
	
	// delete the sprite BG, TopBar and btnclose, if they exists
	DeleteSprite2(C_sp_win_BG)
	DeleteSprite2(C_sp_win_BGTopbar)
	DeleteSprite2(C_sp_win_BtnClose)
	DeleteSprite2(C_sp_win_Btnok)
	
endfunction

Function EventWindow()
	
	// the event of the current window
	
	IF GetPointerPressed()
		event =  C_EVENT_POINTERPRESSED // 1
	elseIF GetPointerState()
		event = C_EVENT_POINTERSTATE // 2
	elseIF GetPointerReleased()
		event = C_EVENT_POINTERRELEASED  // 3
	endif
	
Endfunction event


// *** a basic window for choice textbuton
Function CreateWindowMenu(menutitle$)
	
	Foldstart //Create a window with several menu "buton" // creation d'une fenêtre avec menu 
	
		// Create the window and butons  :/ je vais crée la fenêtre et les boutons
		d = C_Depth_Gadget-15
		
		// create the window
		w = 550
		if w>g_width
			w = g_width
		endif
		h1 = 400
		h = 40
		
		nb = CountStringTokens(menutitle$, d$)
		if h1 < (nb+4)*h
			h1 = (nb+4)*h
		endif
		
		// position of the window by default
		x = (g_width-w)*0.5
		y = 150
		
		Openwindow(x, y, w, h1, 1, 1)
		
		
		
		// Sprite selection // je crée le sprite selection
		n = AddSprite(-1, 0, 8+x, y +70-2, d, 1)
		SetSpriteSize(n, w-20+4, h+4)
		SetSpriteColor(n, 255, 0, 0, 100)
		sp_selection = n
		//~ SetSpriteScissor(n, x, y+40, x+w, y+h1-40)
			
		fileId = 0
		
		// Creation of the buttons // On crée les boutons
		Savetxt$ = menutitle$
		nb = FindStringCount(savetxt$, d$)-1
		
		c = C_COLORUIBTN
		Dim tmp_btn[nb] as tButon
		For i=0 to tmp_btn.length
			
			txt$ = GetStringToken(Savetxt$, d$, i+1)
			x1 = 15 +x
			y1 = (h+5)*i +y +70
			n = AddSprite(-1,0, x1, y1, d-1, 1)
			SetSpriteSize(n, w-30, h)
			SetSpriteColor(n, c, c, c, 255)
			tmp_btn[i].sprite = n
			
			SetSpriteScissor(n, x, y+40, x+w, y+h1-40)
			
			n1 = AddText1(-1, x1, y1+3, txt$, 30, 1, d-1)
			tmp_btn[i].textid = n1
			
			
			tmp_btn[i].x = x1
			tmp_btn[i].y = y1
		next
		
		ny=0
		Action_ID=-1	
		
		// Loop to check what action wi choose // on loop pour voir quelle action on choisit
		repeat
			
			quit = GetEsc()
			
			//~ print(str(buton)+"/"+str(C_sp_win_BtnClose))
			
			//~ mx = GetPointerX()
			//~ my = GetPointerY()
			
			mx = ScreenToWorldX(getpointerx())
			my = ScreenToWorldY(getpointery())
			
			event = EventWindow()
			
			//~ print(str((tmp_file.length-1)*h)+"/"+str(h1-100))
			
			if event = c_event_Pointerpressed
				buton = GetSpriteHit(mx, my)
				if buton = C_sp_win_BtnClose or buton = C_sp_win_BtnOK
					SetSpriteClicked(buton, 1)
				else
					sy = my -ny
				endif
			elseif event = c_event_PointerState
				if buton <> C_sp_win_BtnClose and  buton <> C_sp_win_BtnOK
					if (tmp_btn.length-1)*h >= h1-100
						ny = my -sy
						
						if ny>0
							ny=0
						elseif ny< -((tmp_btn.length-1) * h)
							ny = -((tmp_btn.length-1) * h)
						endif
						FOr i=0 to tmp_btn.length
							SetSpritePosition(tmp_btn[i].sprite, x1, tmp_btn[i].y + ny)
							SettextPosition(tmp_btn[i].textid, x1, tmp_btn[i].y + 3+ ny)
						next
						if Action_ID>-1
							SetSpritePosition(sp_selection, 8+x, getspriteY(tmp_btn[Action_ID].sprite)-2)
						endif
					endif
				endif
			elseif event = c_event_PointerReleased
				
				bb = GetSpriteHit(mx, my)
				if buton = C_sp_win_BtnClose  or buton = C_sp_win_BtnOK
					SetSpriteClicked(buton, 0)
				else
					filename$=""
				endif
				if bb=buton
					if bb = C_sp_win_BtnOK
						quit =2
					elseif bb = C_sp_win_BtnClose
						quit =1
					else
						Action_ID=-1
						
						for i=0 to tmp_btn.length
							SetSpriteColorAlpha(tmp_btn[i].sprite, 255)
						next
						
						for i=0 to tmp_btn.length
							if buton = tmp_btn[i].sprite
								//~ filename$=GetTextString(tmp_btn[i].textid)
								Action_ID = i
								SetSpriteColorAlpha(buton, 220)
								SetSpritePosition(sp_selection, 8+x, getspriteY(buton)-2)
								exit
							endif
						next
					endif
				endif
			endif
			
			sync()
		until quit>=1
			
		CloseWindow()
		
		// Delete all  /// on supprime les sprites et images des fichiers
		For i=0 to tmp_Btn.length
			DeleteSprite2(tmp_Btn[i].sprite)
			DeleteText2(tmp_Btn[i].textid)
		next
		
		undim tmp_btn[]
		
		DeleteSprite(sp_selection)
		
		if quit =1 
			action_ID=-1
		endif
		
		Foldend
	
endfunction Action_ID


// *** sprite and text function
function AddSprite(sprite,img,x,y,depth,fix)
	
	if sprite= -1
		sprite = CreateSprite( img)
	else
		if GetSpriteExists(sprite) = 0
			CreateSprite(sprite, img)
		endif
    endif
    FixSpriteToScreen(sprite, fix)
    SetSpritePosition(sprite, x, y)
	SetSpriteDepth(sprite, depth)
	
endfunction sprite

Function AddText1(i, x, y, txt$, size, fix, depth)
	
	if i = -1
		i = CreateText(txt$)
	else
		CreateText(i, txt$)
	endif
	
	SetTextPosition(i, x, y)
	SetTextSize(i, size)
	FixTextToScreen(i, fix)
	if depth > -1
		SetTextDepth(i, depth)
	endif
	
endFunction i 

Function DeleteSprite2(sprite)

	if Sprite > 10000 or GetSpriteExists(sprite)
		DeleteSprite(Sprite)
	endif
	
endFunction

Function DeleteText2(txt)
	if GetTextExists(txt)
		deletetext(txt)
	endif
endfunction
	
// *** file utilities
Function GetEsc()
	IF GetRawKeyReleased(27)
		quit=1
	endif
Endfunction quit 

Function SetSpriteClicked(sp, clic)
	
	// to change when a sprite is clicked
	
	a as float = 0.5
	b = 2
		if GetSpriteExists(sp)
		if clic=1
			SetSpriteColor(sp,GetSpriteColorRed(sp)*a,GetSpriteColorGreen(sp)*a,GetSpriteColorRed(sp)*a,GetSpriteColorAlpha(sp))
		elseif clic = 0
			SetSpriteColor(sp,GetSpriteColorRed(sp)*b,GetSpriteColorGreen(sp)*b,GetSpriteColorRed(sp)*b,GetSpriteColorAlpha(sp))
		endif
	endif
	
Endfunction

