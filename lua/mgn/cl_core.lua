surface.CreateFont("MGN_Alert", {
	font = "Roboto",
	size = 32,
	outline = true,
	antialias = false
})

local red = Color(255, 0, 0, 255)
hook.Add("HUDPaint", "mgn.HUDPaint", function()
	if GetGlobalBool("MGN_AlertActive") then
		draw.SimpleText("XXXX XXXXXXXX IMMINENT! PLEASE EVACUATE THROUGH THE NEAREST EXIT!", "MGN_Alert", ScrW() / 2, 10, red, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end)
