require("scripts/Globals")
require("scripts/enemies/Enemy")

Enemy7 = {}

local enemyImage = lg.newImage(ENEMIES_IMG_DIR .. "enemy7.png")

function Enemy7:new(_x, _y)
  o = Enemy:new(_x, _y)
  o.sprite = enemyImage
  o.hp = 5
  o.speed = 150
  return o
end
