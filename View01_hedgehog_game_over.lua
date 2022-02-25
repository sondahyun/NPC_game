--hedgehoggame 통과하는 게임 종료된 화면

local composer = require( "composer" )
local scene = composer.newScene()
--local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect("Content/PNG/bear/배경.png",display.contentWidth, display.contentHeight) ---배경
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)

	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000}) -- 배경 어둡게
	sceneGroup:insert(background1)

	--[[local board =display.newImageRect("이미지/미니게임/미니게임_게임완료창.png",display.contentWidth/3.6294896, display.contentHeight/2.83122739)
	board.x , board.y = display.contentWidth/2, display.contentHeight/2
	board.alpha = 0.5
	transition.to(board,{alpha=1,time=1000})
	sceneGroup:insert(board)]]

	local score3 = composer.getVariable("score")

	local function backtogame(event) --실패할 경우 다시 게임으로 돌아가기
		if event.phase == "began" then 
				composer.removeScene("View01_hedgehog_game_over")
				composer.gotoScene("View01_hedgehog")
		end
	end

	local function gomap(event) -- 게임 pass 후 넘어감
		if event.phase == "began" then--view20ring
				composer.removeScene("View01_hedgehog_game_over")
				composer.gotoScene( "story07" )
		end
	end

	local backtomap =display.newImageRect("Content/PNG/클리어창.png",display.contentWidth/1.1,display.contentHeight/1.5) --성공할 경우
	backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(backtomap)
	backtomap:addEventListener("touch",gomap)

	local backgame =display.newImageRect("Content/PNG/fail.png",display.contentWidth/1.1,display.contentHeight/2.5) --실패할 경우
	backgame.x, backgame.y = display.contentWidth/2, display.contentHeight/2
	backgame.alpha = 0
	sceneGroup:insert(backgame)

	if score3 < 0 then
		backgame.alpha = 1
		backtomap.alpha = 0
		backgame:addEventListener("touch",backtogame)
	end

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
		composer.removeScene("view07_chick_game_over")
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
