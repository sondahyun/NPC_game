-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

----
local composer = require( "composer" )
local scene = composer.newScene()

local explosionSound = audio.loadSound( "Content/PNG/script/City Key.mp3" )
audio.play( explosionSound )

function scene:create( event )
	local sceneGroup = self.view
	-------------------- 배경구성
	local background = display.newImage( "Content/PNG/타이틀/미니게임타이틀_강아지.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	
	------------------

	local function tap( event )
		composer.removeScene("view00_dog_start")
		composer.gotoScene("view01_dog")
	end

	background:addEventListener("tap",tap)

	sceneGroup:insert(background)
	------
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