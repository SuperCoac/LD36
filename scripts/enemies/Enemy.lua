require("scripts/Globals")

Enemy = {}
local enemyImage = lg.newImage(ENEMIES_IMG_DIR .. "enemy.png")

function Enemy:new(_x, _y)
  local o = {
    sprite = enemyImage,
    x = _x,
    y = _y,
    speed =  300,
    angle =  math.angle(_x, _y, WINDOW_W/2, WINDOW_H/2),
    coll = HC.rectangle(_x, _y, enemyImage:getWidth(), enemyImage:getHeight()),
    width = enemyImage:getWidth(),
    height = enemyImage:getHeight(),
    isCollided = false,
    hp = 1,
    scaleX = 1,
    isDead = false,
    opacity = 255
   }
   if o.x > WINDOW_W /2 then
     o.scaleX = -1
   end
   o.coll.name = "Enemy"

   setmetatable(o, self)
   self.__index = self
   return o
end


function Enemy:destroy()
  HC.remove(self.coll)
  self.isDead = true
end


-- Overridable
function Enemy:move(dt)
  self.x = self.x + self.speed * dt * math.cos(self.angle)
  self.y = self.y + self.speed * dt * math.sin(self.angle)
end

function Enemy:update(dt)

  if(self.isCollided and not self.isDead) then
    self:destroy()
    return
  end

  if(self.isDead) then
    self.opacity = self.opacity - 600 * dt
    if(self.opacity <= 0) then
      removeFromList(enemyManager.enemies, self)
    end
    return
  end

  self:move(dt)
  self.coll:moveTo(self.x, self.y)
  for shape, delta in pairs(HC.collisions(self.coll)) do
    if(shape.name == "Arrow") then
      self.hp = self.hp - 1
      if(self.hp < 1) then
      self.isCollided = true
      score = score + 100
      money = money + 10
      end
    end
    if(shape.name == "Train") then
      self.isCollided = true
    end
  end
end

function Enemy:draw()
  lg.setColor(255, 255, 255, self.opacity)
  lg.draw(self.sprite, self.x, self.y, 0, self.scaleX, 1, self.width/2, self.height/2)
  lg.setColor(255, 255, 255)

   --self.coll:draw("fill")
end
