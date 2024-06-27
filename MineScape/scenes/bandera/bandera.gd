extends StaticBody2D

func _on_bandera_entered(area):
	SignalManager.on_win.emit()
