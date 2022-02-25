-----------------------------------------------------------------------------------------
--
-- View01_bear.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view
	loadedEnding = loadsave.loadTable( "ending.json" )
	
	local background = display.newImageRect("Content/PNG/stage/스테이지5.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2

	local background2 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background2:setFillColor(0.35, 0.35, 0.35, 0.35)

	local dog = display.newImageRect("Content/PNG/stage/스테이지5강아지.png", 300, 350)
	dog.x, dog.y = display.contentWidth*0.35, display.contentHeight*0.56
	dog.alpha=0.5

	local cat = display.newImageRect("Content/PNG/stage/스테이지5고양이.png", 200, 450)
	cat.x, cat.y = display.contentWidth*0.75, display.contentHeight*0.75
	cat.alpha=0.5

	local arrowleft = display.newImageRect("Content/PNG/stage/왼쪽넘기기.png",80, 80)
	arrowleft.x, arrowleft.y = display.contentWidth*0.1, display.contentHeight/2

	local dcheck=composer.getVariable("dogcheck")

	local function beforemove()
		composer.gotoScene("stage04")
	end

	local function storymove()
		composer.gotoScene("story10")
	end

	if dcheck then
		background2.alpha=0
		dog.alpha=1
		cat.alpha=1
		dog:addEventListener("tap", storymove)
	end

	arrowleft:addEventListener("tap", beforemove)
	
	sceneGroup:insert(background)
	sceneGroup:insert(dog)
	sceneGroup:insert(cat)
	sceneGroup:insert(background2)
	sceneGroup:insert(arrowleft)

	-----음악

   --[[local dMusic = audio.loadStream( "음악/음악샘플.mp3" )
    audio.setVolume( loadedEnding.logValue )
    loadedEnding.bgMusic = "음악/음악샘플.mp3"]] 

   --샘플 볼륨 이미지
    local volumeButton = display.newImage("Content/PNG/설정/설정.png")
    volumeButton.x,volumeButton.y = display.contentWidth * 0.87, display.contentHeight * 0.9
    sceneGroup:insert(volumeButton)

    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    --[[local home = audio.loadStream( "음악/음악샘플.mp3" )
    audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    audio.play(home)]]
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene