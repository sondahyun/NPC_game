-----------------------------------------------------------------------------------------
--
-- view03_dog.lua
--
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--local explosionSound = audio.loadSound( "Content/PNG/script/City Key.mp3" )
	--audio.play( explosionSound )

	local background = display.newImageRect("Content/PNG/dog/배경.png",display.contentWidth, display.contentHeight) ---배경
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)
	
	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000}) -- 배경 어둡게
	sceneGroup:insert(background1)
	
	local ending = display.newText("", display.contentWidth/2, display.contentHeight/2)
	ending.size = 90
	ending:setFillColor(0)

	local result = composer.getVariable("complete")

	--close 버튼
	local clear_close = display.newImageRect("Content/PNG/설정/닫기.png", 150, 150)
	clear_close.x, clear_close.y = 950, 400
	clear_close.alpha = 0


	local function nextlevel(event)
		composer.removeScene("view03_dog_pass")
		composer.gotoScene("view02_dog")
	end

	if result then 
		-- 레벨 통과 글 써주기--
		ending.text = "Level"..result.." pass!!"
		audio.pause( explosionSound )
		composer.removeScene("view03_dog_pass")
		composer.gotoScene("view02_dog_start") 
	else
		-- view02_dog_start로 가야 레벨 2가 시작됨--
		composer.gotoScene("view02_dog_start") 
	end
	timer.performWithDelay(1000, timeAttack, 0)
	background1:addEventListener("tap",nextlevel)

	-- sceneGroup으로 묶어줌--
	sceneGroup:insert(ending)
	sceneGroup:insert(background1)
	sceneGroup:insert(clear_close)
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
		composer.removeScene("view03_dog_pass")
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
