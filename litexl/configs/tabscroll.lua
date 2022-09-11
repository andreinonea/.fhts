-- mod-version:3 -- lite-xl 2.1
local core = require "core"
local RootView = require "core.rootview"
-- local on_mouse_wheel = RootView.on_mouse_wheel

function RootView:on_mouse_wheel(...)
  local x, y = self.mouse.x, self.mouse.y
  local node = self.root_node:get_child_overlapping_point(x, y)
  local tab_idx = node:get_tab_overlapping_point(x, y)
  -- core.log(node.tab_offset)
  if tab_idx then
    -- core.log("hmm " .. tab_idx)
    if node.tab_offset > 1 then
      node.tab_offset = node.tab_offset - 1
    end
    return true
  end
  return node.active_view:on_mouse_wheel(...)
end

