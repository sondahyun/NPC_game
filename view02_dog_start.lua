-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

----
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	-------------------- 배경구성
	--local explosionSound = audio.loadSound( "Content/PNG/script/City Key.mp3" )
	--audio.play( explosionSound )
	
	local background = display.newImage( "Content/PNG/dog/밤하늘.jpg")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local background1 = display.newImage( "Content/PNG/dog/level2.png")
	background1.x, background1.y = display.contentWidth/2, display.contentHeight/2

	------------------
	local leveltext = display.newText("", display.contentWidth/2, display.contentHeight/2)
	leveltext.size = 90
	leveltext.x, leveltext.y = display.contentWidth/2, display.contentHeight/2 - 200
	leveltext:setFillColor(1)
	local level = 2
	leveltext.text = "Level "..level

	local function tap( event )
		--audio.pause( explosionSound )
		composer.removeScene("view02_dog_start")
		composer.gotoScene("view04_dog")
	end

	background1:addEventListener("tap",tap)
	sceneGroup:insert(background)
	sceneGroup:insert(background1)
	sceneGroup:insert(leveltext)
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