surface.CreateFont("MGN_Alert", {
	font = "Roboto",
	size = 32,
	outline = true,
	antialias = false
})

local red = Color(255, 0, 0, 255)
function mgn.DrawAlert()
	if GetGlobalBool("MGN_AlertActive") then
		draw.SimpleText("XXXX XXXXXXXX IMMINENT! PLEASE EVACUATE THROUGH THE NEAREST EXIT!", "MGN_Alert", ScrW() / 2, 10, red, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end
hook.Add("HUDPaint", "MGN", mgn.DrawAlert)
