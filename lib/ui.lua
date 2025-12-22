-- color definitions
HRLR_UTIL.colors = {
  DICE_BG = G.C.WHITE,
  DICE_TEXT = G.C.UI.TEXT_DARK,
}

-- EVIL FUCKING LOVE.RESIZE HOOK
local resize_ref = love.resize
love.resize = function(w, h)
  resize_ref(w, h)
  for i, v in pairs(G.MOVEABLES) do
    if v.hrlr_uibox then
      local factor = G.TILESIZE * G.TILESCALE
      v.hrlr_uibox = UIBox({
        definition = HRLR_UTIL.dice_ui_function(v.role.draw_major.ability.extra), -- EXTREMELY EVIL
        config = { major = G.ROOM_ATTACH, type = "cm", offset = {
          x = (0.5 * v.canvas:getWidth() / factor) - (G.ROOM_ATTACH.T.w / 2),
          y = (0.225 * v.canvas:getHeight() / factor) - (G.ROOM_ATTACH.T.h / 2)
        } }
      })
      v.hrlr_uibox.draw = function() end
    end
  end
end

-- Dice UIBox
function HRLR_UTIL.dice_ui_function(die_table)
  return { n = G.UIT.ROOT, config = { align = "cm", colour = G.C.CLEAR }, nodes = {
    { n = G.UIT.R, config = { align = "cm" }, nodes = {
      { n = G.UIT.C, config = { align = "cm" }, nodes = {
        { n = G.UIT.T, config = {
          ref_table = die_table,
          ref_value = "render_value",
          colour = G.C.UI.TEXT_DARK,
          scale = (1920/11) / (G.TILESCALE * G.TILESIZE)
        } },
      } },
    } }
  } }
end

-- DrawStep for the number display on dice cards
SMODS.DrawStep {
  key = "hrlr_dice_display",
  order = 41,
  func = function(self, layer)
    if self and self.ability and self.ability.set and self.ability.set == "hrlr_dice" then
      local sprite = self.render_sprite
      local factor = G.TILESIZE * G.TILESCALE

      love.graphics.push()
      love.graphics.origin()
      sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
      if not sprite.hrlr_uibox then
        sprite.hrlr_uibox = UIBox({
          definition = HRLR_UTIL.dice_ui_function(self.ability.extra),
          config = { major = G.ROOM_ATTACH, type = "cm", offset = {
            x = (0.5 * sprite.canvas:getWidth() / factor) - (G.ROOM_ATTACH.T.w / 2),
            y = (0.225 * sprite.canvas:getHeight() / factor) - (G.ROOM_ATTACH.T.h / 2)
          } }
        })
        sprite.hrlr_uibox.draw = function() end
      end
      sprite.canvas:renderTo(UIBox.draw, sprite.hrlr_uibox)
      love.graphics.pop()

      sprite.role.draw_major = self
      sprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
    end
  end
}
