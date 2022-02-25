-----------------------------------------------------------------------------------------
--
-- View01_bear.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local explosionSound = audio.loadSound( "Content/PNG/script/Tongtong.mp3" )
audio.play( explosionSound )

function scene:create( event )
	local sceneGroup = self.view

	local gametitle = display.newImageRect("Content/PNG/타이틀/미니게임타이틀_고슴도치.png", display.contentWidth, display.contentHeight)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0

	local script = display.newText("How to play:\n 숨어있는 고슴도치를 찾아보세요\n 6번 찾을 시 게임 클리어 입니다.", section.x+30, section.y-100, native.systemFontBold)
	script.size = 45
	script:setFillColor(1)
	script.alpha=0
	
	local background = display.newImageRect("Content/PNG/고슴도치/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2

	local count=0
	local showScore = display.newText(count, display.contentWidth*0.85, display.contentHeight*0.06)
	showScore:setFillColor(0)
	showScore.size = 50

	local countbackground = display.newImageRect("Content/PNG/스코어.png", 300, 150)
	countbackground.x, countbackground.y = display.contentWidth*0.85, display.contentHeight*0.05
	
	local cat = display.newImage("Content/PNG/고슴도치/고양이.png")
	cat.x, cat.y = 263, 1179

	local limit = 20
	local showLimit = display.newText(limit, display.contentWidth*0.85, display.contentHeight*0.16)
	showLimit:setFillColor(0)
	showLimit.size = 60

	local limitbackground = display.newImageRect("Content/PNG/시간.png", 200, 150)
	limitbackground.x, limitbackground.y = display.contentWidth*0.85, display.contentHeight*0.15

	local hedgehog = {"고슴도치1", "고슴도치2", "고슴도치3", "고슴도치4", "고슴도치5", "고슴도치6"}
	local hedx={991.5, 611, 1018, 660.5, 165.5, 118.5}
	local hedy={879.5, 525, 1651, 848, 732.5, 135.5}
	
	local hed= { }	
	local hedIdxs = { }

	local i=1
	local hedGroup = display.newGroup()

	local function spawn()
		local hedIdx = math.random(#hedgehog)
		hedIdxs[i]= hedIdx

		if i~=1 then
			while hedIdxs[i-1] == hedIdx do
				hedIdx = math.random(#hedgehog)
			end
		end
		
		local hedName = hedgehog[hedIdx]
		hed[i] = display.newImage(hedGroup,"Content/PNG/고슴도치/" .. hedName .. ".png")
		hed[i].x = hedx[hedIdx]
		hed[i].y = hedy[hedIdx]
		hed[i].name='hed'

		i = i+1
	end

	local function catch(event)
		count=count+1
		showScore.text=count
		display.remove(hed[count])
		if count == 6 then
			timer.cancel(timer1)
			audio.pause(explosionSound)
			composer.removeScene("View01_hedgehog")
			composer.setVariable("score", 6)
			composer.gotoScene("View01_hedgehog_game_over")
		elseif count<6 then
			spawn()
		end
	end	

	local function time(event)
		limit = limit - 1
		showLimit.text = limit
		if(limit <= 0) then
			timer.cancel(timer1)
			audio.pause(explosionSound)
			composer.removeScene("View01_hedgehog")
			composer.setVariable("score", -1)
			composer.gotoScene("View01_hedgehog_game_over")
		end
	end

	local function scriptremove(event)
		timer1=timer.performWithDelay(1000, time, 0)
		section.alpha=0
		script.alpha=0
		hedGroup:addEventListener("tap", catch)
	end	

	local function titleremove(event)
		gametitle.alpha=0
		section.alpha=1
		script.alpha=1
		section:addEventListener("tap", scriptremove)
	end	

	spawn()
	
	gametitle:addEventListener("tap", titleremove)

	sceneGroup:insert(background)
	sceneGroup:insert(countbackground)
	sceneGroup:insert(showScore)
	sceneGroup:insert(limitbackground)
	sceneGroup:insert(showLimit)
	sceneGroup:insert(cat)
	sceneGroup:insert(hedGroup)
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