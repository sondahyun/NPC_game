-----------------------------------------------------------------------------------------
--
-- View01_bear.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)

	local script = display.newText("How to play:\n 숨어있는 고슴도치를 찾아보세요\n 6번 찾을 시 게임 클리어 입니다.", section.x+30, section.y-100, native.systemFontBold)
	script.size = 45
	script:setFillColor(1)
	
	local background = display.newImageRect("Content/PNG/고슴도치/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2

	local count=0
	local showScore = display.newText(count, display.contentWidth*0.9, display.contentHeight*0.1)
	showScore:setFillColor(0)
	showScore.size = 50
	
	local cat = display.newImageRect("Content/PNG/고슴도치/고양이.png", 400, 800)
	cat.x, cat.y = display.contentWidth*0.2, display.contentHeight*0.6
	
	local box = display.newImageRect("Content/PNG/고슴도치/상자.png", 200, 350)
	box.x, box.y = display.contentWidth*0.9, display.contentHeight*0.5

	local box2 = display.newImageRect("Content/PNG/고슴도치/상자뚜껑열림.png", 200, 350)
	box2.x, box2.y = display.contentWidth*0.5, display.contentHeight*0.35

	local limit = 10
	local showLimit = display.newText(limit, display.contentWidth*0.9, display.contentHeight*0.05)
	showLimit:setFillColor(0)
	showLimit.size = 60

	local hedgehog = {"고슴도치1", "고슴도치2", "고슴도치3", "고슴도치4", "고슴도치5", "고슴도치6"}
	local hedx={0.9, 0.5, 0.9, 0.6, 0.2, 0.1}
	local hedy={0.45, 0.33, 0.9, 0.45, 0.35, 0.1}
	
	local hed= { }	
	local i=1
	local hedGroup = display.newGroup()

	local function spawn()
		local hedIdx = math.random(#hedgehog)
		local hedName = hedgehog[hedIdx]
		hed[i] = display.newImageRect(hedGroup,"Content/PNG/고슴도치/" .. hedName .. ".png", 100, 200)
		hed[i].x = display.contentWidth*hedx[hedIdx]
		hed[i].y = display.contentHeight*hedy[hedIdx]
		hed[i].name='hed'
		i = i+1
	end

	local function catch(event)
		count=count+1
		showScore.text=count
		display.remove(hed[count])
		if count == 6 then
			timer.cancel(timer1)
			composer.gotoScene("View01_hedgehog_success")
		elseif count<6 then
			spawn()
		end
	end	

	local function time(event)
		limit = limit - 1
		showLimit.text = limit
		if(limit <= 0) then
			timer.cancel(timer1)
			composer.removeScene("View01_hedgehog")
			composer.gotoScene("View01_hedgehog_fail")
		end
	end


	local function scriptremove(event)
		timer1=timer.performWithDelay(1000, time, 0)
		section.alpha=0
		script.alpha=0
	end	

	spawn()
	
	hedGroup:addEventListener("tap", catch)
	section:addEventListener("tap", scriptremove)
	
	sceneGroup:insert(background)
	sceneGroup:insert(showScore)
	sceneGroup:insert(showLimit)
	sceneGroup:insert(cat)
	sceneGroup:insert(hedGroup)
	sceneGroup:insert(box)
	sceneGroup:insert(box2)
	sceneGroup:insert(section)
	sceneGroup:insert(script)

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