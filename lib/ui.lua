-- color definitions
HRLR_UTIL.colors = {
  DICE_BG = G.C.WHITE,
  DICE_TEXT = G.C.UI.TEXT_DARK,
}

-- DrawStep for the number display on dice cards
SMODS.DrawStep {
  key = "hrlr_dice_display",
  order = 41,
  func = function(self, layer)
    if self and self.ability and self.ability.set and self.ability.set == "hrlr_dice" then
      local sprite = G.shared_dice[self.config.center.key]

      love.graphics.push()
      love.graphics.origin()
      sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
      love.graphics.setColor(love.math.colorFromBytes(79, 99, 103))
      local text = love.graphics.newText(love.graphics.getFont(), self.ability.extra.value or "?")
      sprite.canvas:renderTo(love.graphics.draw, text, 320, 110, 0, 10)
      love.graphics.pop()

      sprite.role.draw_major = self
      sprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
    end
  end
}
