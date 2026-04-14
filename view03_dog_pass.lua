-----------------------------------------------------------------------------------------
--
-- view03_dog_pass.lua
-- 강아지 별잡기 레벨1 통과 화면 → 레벨2(view02_dog_start)로 이동
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

	local background = display.newImageRect("Content/PNG/dog/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth / 2, display.contentHeight / 2
	sceneGroup:insert(background)

	local background1 = display.newRect(display.contentWidth / 2, display.contentHeight / 2, display.contentWidth, display.contentHeight)
	background1:setFillColor(0)
	transition.to(background1, { alpha = 0.5, time = 1000 })
	sceneGroup:insert(background1)

	local result = composer.getVariable("complete")

	local ending = display.newText("", display.contentWidth / 2, display.contentHeight / 2)
	ending.size = 90
	ending:setFillColor(1)
	sceneGroup:insert(ending)

	-- close 버튼
	local clear_close = display.newImageRect("Content/PNG/설정/닫기.png", 150, 150)
	clear_close.x, clear_close.y = 950, 400
	clear_close.alpha = 1
	sceneGroup:insert(clear_close)

	local function nextlevel()
		composer.removeScene("view03_dog_pass")
		composer.gotoScene("view02_dog_start")
	end

	if result then
		ending.text = "Level " .. tostring(result) .. " pass!!"
	end

	clear_close:addEventListener("tap", nextlevel)
end

function scene:show(event)
	local phase = event.phase
	if phase == "will" then
	elseif phase == "did" then
	end
end

function scene:hide(event)
	local phase = event.phase
	if phase == "will" then
	elseif phase == "did" then
		composer.removeScene("view03_dog_pass")
	end
end

function scene:destroy(event)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
