#pragma strict

var character : CharacterController;

function Start () {
	character = GetComponent(CharacterController);
}

function Update () {
	var at = gameObject.GetComponentInChildren(AnimatedTexture);
	var velocity : float = character.velocity.x;
	if(velocity > 0 || velocity < 0){
		at.rowNumber = 1;
	}
	else {
		at.rowNumber = 0;
	}
}