local ADDON_NAME = "AutoGroup"
local ADDON_VERSION = "1.0"
local ADDON_AUTHOR = "Tom Cumbow"


local function LeaveGroup()
	if IsUnitGrouped("player") then
		GroupLeave()
	end
end

local function OnEventFriendPlayerStatusChanged(PlayerName,prevStatus,curStatus)
	if PlayerName == "@Samantha.C" and (IsUnitGroupLeader("player") or not IsUnitGrouped("player")) then
		GroupInviteByName("@Samantha.C")
	end
	
	if PlayerName == "@Tommy.C" and (IsUnitGroupLeader("player") or not IsUnitGrouped("player")) then
		GroupInviteByName("@Tommy.C")
	end
	
end

local function OnAddonLoaded(event, name)
	if name == ADDON_NAME then
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, event)
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_LOGOUT_DEFERRED, LeaveGroup)
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_FRIEND_PLAYER_STATUS_CHANGED, OnEventFriendPlayerStatusChanged)(string PlayerName,luaindex prevStatus,luaindex curStatus
		
	end
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)
