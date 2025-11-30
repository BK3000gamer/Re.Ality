extends Node

var player: Player
var pivot: Pivot

var HorizontalPos: float
var VerticalPos: float

func _ready() -> void:
	player = get_node("/root/main/SubViewportContainer/Main/Player")
	pivot = get_node("/root/main/SubViewportContainer/Main/Pivot")

func _process(_delta: float) -> void:
	if pivot.PivotRot == 0.0 and pivot.CurrentView == "Side":
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -45.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (playerA - pivotA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.CurrentView == "Side":
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == -135.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (playerA - pivotA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and pivot.CurrentView == "Side":
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 135.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (pivotA - playerA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 90.0 and pivot.CurrentView == "Side":
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 45.0 and pivot.CurrentView == "Side":
		var playerH = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA = pivotH*cos(deg_to_rad(45))
		HorizontalPos = (pivotA - playerA + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.y - pivot.global_transform.origin.y + 5.625) * 32
	elif pivot.PivotRot == 0.0 and pivot.CurrentView == "Middle":
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		var playerH = player.global_transform.origin.z - player.global_transform.origin.y
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.z - pivot.global_transform.origin.y
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (playerA - pivotA + 5.625) * 32
	elif pivot.PivotRot == -45.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 - player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 - pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (playerB2 - pivotB2 + 5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.CurrentView == "Middle":
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		var playerH = player.global_transform.origin.x + player.global_transform.origin.y
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x + pivot.global_transform.origin.y
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (pivotA - playerA + 5.625) * 32
	elif pivot.PivotRot == -135.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 + player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 + pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (pivotB2 - playerB2 + 5.625) * 32
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and pivot.CurrentView == "Middle":
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		var playerH = player.global_transform.origin.y + player.global_transform.origin.z
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.y + pivot.global_transform.origin.z
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (pivotA - playerA + 5.625) * 32
	elif pivot.PivotRot == 135.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (pivotA1 - playerA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 + player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 + pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (pivotB2 - playerB2 + 5.625) * 32
	elif pivot.PivotRot == 90.0 and pivot.CurrentView == "Middle":
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		var playerH = player.global_transform.origin.x - player.global_transform.origin.y
		var playerA = playerH*cos(deg_to_rad(45))
		var pivotH = pivot.global_transform.origin.x - pivot.global_transform.origin.y
		var pivotA = pivotH*cos(deg_to_rad(45))
		VerticalPos = (playerA - pivotA + 5.625) * 32
	elif pivot.PivotRot == 45.0 and pivot.CurrentView == "Middle":
		var playerH1 = player.global_transform.origin.x - player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x - pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var playerB = playerA2 - player.global_transform.origin.y
		var playerB2 = playerB*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		var pivotB = pivotA2 - pivot.global_transform.origin.y
		var pivotB2 = pivotB*cos(deg_to_rad(45))
		VerticalPos = (playerB2 - pivotB2 + 5.625) * 32
	elif pivot.PivotRot == 0.0 and pivot.CurrentView == "Top":
		HorizontalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 5.625) * 32
	elif pivot.PivotRot == -45.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (playerA2 - pivotA2 +  5.625) * 32
	elif pivot.PivotRot == -90.0 and pivot.CurrentView == "Top":
		HorizontalPos = (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 5.625) * 32
	elif pivot.PivotRot == -135.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (pivotA2 - playerA2 +  5.625) * 32
	elif (pivot.PivotRot == -180.0 or pivot.PivotRot == 180.0) and pivot.CurrentView == "Top":
		HorizontalPos = 640 - (player.global_transform.origin.x - pivot.global_transform.origin.x + 10) * 32
		VerticalPos = 360 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 5.625) * 32
	elif pivot.PivotRot == 135.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.x + player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x + pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (pivotA1 - playerA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z - player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z - pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (pivotA2 - playerA2 +  5.625) * 32
	elif pivot.PivotRot == 90.0 and pivot.CurrentView == "Top":
		HorizontalPos = 640 - (player.global_transform.origin.z - pivot.global_transform.origin.z + 10) * 32
		VerticalPos = (player.global_transform.origin.x - pivot.global_transform.origin.x + 5.625) * 32
	elif pivot.PivotRot == 45.0 and pivot.CurrentView == "Top":
		var playerH1 = player.global_transform.origin.x - player.global_transform.origin.z
		var playerA1 = playerH1*cos(deg_to_rad(45))
		var pivotH1 = pivot.global_transform.origin.x - pivot.global_transform.origin.z
		var pivotA1 = pivotH1*cos(deg_to_rad(45))
		HorizontalPos = (playerA1 - pivotA1 + 10) * 32
		var playerH2 = player.global_transform.origin.z + player.global_transform.origin.x
		var playerA2 = playerH2*cos(deg_to_rad(45))
		var pivotH2 = pivot.global_transform.origin.z + pivot.global_transform.origin.x
		var pivotA2 = pivotH2*cos(deg_to_rad(45))
		VerticalPos = (playerA2 - pivotA2 +  5.625) * 32
