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

	local script = display.newText("How to play:\n위에서 내려오는 음식을 받으세요\n쓰레기를 받게 될 시에는 점수가 깎입니다. \n5점을 달성할 시 게임 클리어 입니다.", section.x+30, section.y-100, native.systemFontBold)
	script.size = 45
	script:setFillColor(1)
	
	local background = display.newImageRect("Content/PNG/bear/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2

	local score = 0
	local showScore = display.newText(score, display.contentWidth*0.9, display.contentHeight*0.1)
	showScore:setFillColor(0)
	showScore.size = 50

	local floor = display.newRect(display.contentWidth/2, display.contentHeight*0.9, display.contentWidth, display.contentHeight*0.2)
	floor:setFillColor(0)
	floor.name = 'floor'
	physics.addBody(floor, 'static')

	local bear = display.newImageRect("Content/PNG/bear/갈색곰.png", 200, 350)
	bear.x, bear.y = display.contentWidth*0.4, display.contentHeight*0.8
	physics.addBody(bear, 'static')
	bear.name = 'bear'
	
	local objects = {"딸기", "땅콩", "버섯", "사과", "쓰래기봉지", "콜라캔"}

	local object = { }	
	local i=1
	local objectGroup = display.newGroup()
	local function spawn()
		local objIdx = math.random(#objects)
		local objName = objects[objIdx]
		object[i]= display.newImageRect(objectGroup,"Content/PNG/bear/" .. objName .. ".png", 100, 100)
		object[i].x = display.contentWidth*0.5 + math.random(-490, 490)
		object[i].y = 0
		if objIdx <5 then
			object[i].type="food"
		else
			object[i].type="trash"
		end
		physics.addBody(object[i])
		object[i].name='object'
		i = i+1
	end

	local function bearmove(event)
		if(event.phase == "ended") then
			if bear.x>=60 and bear.x<=960 then
				if event.x < bear.x then
					bear.x=bear.x-40
				elseif event.x>bear.x then
					bear.x = bear.x+40	
				end
			elseif bear.x<60 then
				bear.x = 60
			elseif bear.x >960 then
				bear.x = 960
			end

		end
	end

	local function scriptremove(event)
		section.alpha=0
		script.alpha=0
		timer1=timer.performWithDelay(1000, spawn, 0)
		Runtime:addEventListener( "touch", bearmove)
	end	


	local function pagemove()
		display.remove(objectGroup)
		display.remove(floor)
		Runtime:removeEventListener("touch", bearmove)
		display.remove(bear)
	end

	local function onCollision(e)
		if e.other.name == 'object' then
			if e.other.type == 'food' then
				score = score + 1
				display.remove(e.other)
				showScore.text = score
			else
				score = score-1
				display.remove(e.other)
				showScore.text=score
			end

			if score<0 then
				timer.cancel( timer1 )
				pagemove()
				composer.removeScene("View01_bear")
				composer.gotoScene("View01_bear_fail")

			elseif score == 5 then
				timer.cancel( timer1 )
				pagemove()
				composer.gotoScene( "View01_bear_success" )
			end
		end
	end

	local function onCollision2(e)
		if e.other.name == 'object' then
			display.remove(e.other)
		end
	end

	section:addEventListener("tap", scriptremove)
	bear:addEventListener("collision", onCollision)
	floor:addEventListener("collision", onCollision2)
	

	sceneGroup:insert(background)
	sceneGroup:insert(showScore)
	sceneGroup:insert(floor)
	sceneGroup:insert(bear)
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