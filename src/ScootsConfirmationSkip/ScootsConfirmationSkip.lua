SCK = {}
SCK.confirmActive = false
SCK.auctionsOpen = false

SCK.frame = CreateFrame('Frame', nil, UIParent)

function SCK.handleEvent(self, event)
	if(event == 'AUCTION_HOUSE_SHOW') then
		SCK.auctionsOpen = true
	elseif(event == 'AUCTION_HOUSE_CLOSED') then
		SCK.auctionsOpen = false
	elseif(SCK.auctionsOpen == false) then
		SCK.confirmActive = true
	end
end

function SCK.loop(self, event)
	if(SCK.confirmActive == true and not UnitAffectingCombat('player')) then
		if(_G['StaticPopup1']:IsVisible() and _G['StaticPopup1Button1']:IsVisible()) then
			SCK.confirmActive = false
			_G['StaticPopup1Button1']:Click()
		end
	end
end

SCK.frame:SetScript('OnUpdate', SCK.loop)

SCK.frame:SetScript('OnEvent', SCK.handleEvent)
SCK.frame:RegisterEvent('EQUIP_BIND_CONFIRM')
SCK.frame:RegisterEvent('AUTOEQUIP_BIND_CONFIRM')
SCK.frame:RegisterEvent('LOOT_BIND_CONFIRM')
SCK.frame:RegisterEvent('AUCTION_HOUSE_SHOW')
SCK.frame:RegisterEvent('AUCTION_HOUSE_CLOSED')
--SCK.frame:RegisterEvent('DELETE_ITEM_CONFIRM')
