if next(SMODS.find_mod("PlayLog")) then
  PlayLog.LogType {
    key = "die_rolled",
    group = "effects",
    get_message = function(self, args)
      return PlayLog.localize("die_rolled", {
        PlayLog.format_object(args.card), args.roll
      })
    end
  }
  PlayLog.LogType {
    key = "die_mod",
    group = "effects",
    get_message = function(self, args)
      return PlayLog.localize("die_mod", {
        PlayLog.format_object(args.card), args.old_roll, args.new_roll
      })
    end
  }
  PlayLog.LogType {
    key = "die_reroll",
    group = "effects",
    get_message = function(self, args)
      return PlayLog.localize("die_reroll", {
        PlayLog.format_object(args.card), args.rerolls
      })
    end
  }
  PlayLog.LogType {
    key = "coin_flipped",
    group = "effects",
    get_message = function(self, args)
      return PlayLog.localize("coin_flipped", {
        PlayLog.format_object(args.card), args.heads and "Heads" or "Tails"
      })
    end
  }
else
  PlayLog = { log = function(...) return end }
end
