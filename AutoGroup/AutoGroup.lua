local ADDON_NAME = "AutoGroup"
local ADDON_VERSION = "1.0"
local ADDON_AUTHOR = "Tom Cumbow"


local function LeaveGroup()
	if IsUnitGrouped("player") then
		GroupLeave()
	end
end

local function DisbandIfEmpty()
	if IsUnitGrouped("player") then
		local GroupEmpty = true
		for i = 1, GetGroupSize() do
			local unitTag = GetGroupUnitTagByIndex(i)
			local IsPlayer = (GetUnitType(unitTag) == 1)
			local Online = IsUnitOnline(unitTag)
			local RawUnitName = GetRawUnitName(unitTag)
			local IsNotSelf = (RawUnitName ~= GetRawUnitName("player"))

			if IsPlayer and Online and IsNotSelf then
				GroupEmpty = false
			end
		end

		if GroupEmpty then
			GroupDisband()
		end

	end

end


local function OnEventFriendPlayerStatusChanged(_,PlayerName,_,prevStatus,curStatus)
	
	if PlayerName == "@Samantha.C" and curStatus == PLAYER_STATUS_ONLINE and (IsUnitGroupLeader("player") or not IsUnitGrouped("player")) and GetDisplayName()=="@Tommy.C" then
		GroupInviteByName("@Samantha.C")
	end
	
	if PlayerName == "@Tommy.C" and curStatus == PLAYER_STATUS_ONLINE and (IsUnitGroupLeader("player") or not IsUnitGrouped("player")) and GetDisplayName()=="@Samantha.C" then
		GroupInviteByName("@Tommy.C")
	end

	DisbandIfEmpty()

end

local function OnAddonLoaded(event, name)
	if name == ADDON_NAME then
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, event)
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_LOGOUT_DEFERRED, LeaveGroup)
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_FRIEND_PLAYER_STATUS_CHANGED, OnEventFriendPlayerStatusChanged)
		EVENT_MANAGER:RegisterForUpdate(ADDON_NAME, 5*1000, DisbandIfEmpty)
	end
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)
