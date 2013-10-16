#pragma strict
 
var speed : float = 10;
private var thisTransform : Transform;
var character : CharacterController;
private var velocity : Vector3;
private var canJump = true;
var leftFingerID;
var leftFingerCenter : Vector2;
var mDiff : Vector2;
var moveStickDiff = 100;
var leftFingerInput : Vector2;
var movePad : GUITexture;
var jumpButton : GUITexture;
var moveDirection : Vector3;
var jump : boolean;
var doubleJump : boolean;
var jumpSpeed : float = 10;
var velocityJ : Vector3;
var doubleJumpingEnabled : boolean = true;
var jumpingEnabled : boolean = true;
var X : float;

function Start (){
    thisTransform = GetComponent(Transform);
    character = GetComponent(CharacterController);
    movePad.transform.position = new Vector2(-1,-1);
    jump = false;
    X = transform.localScale.x;
}


function Update (){
    var moveDiff : Vector2;
    var AT = gameObject.GetComponent(AnimatedTexture);
    for (var touch : Touch in Input.touches){
        if (touch.phase == TouchPhase.Began){
            if (jumpButton.HitTest(touch.position)){
                jump = true;
            }
            else{
                leftFingerID = touch.fingerId;
                leftFingerCenter = touch.position;
                movePad.transform.position.x = touch.position.x / Screen.width;
                movePad.transform.position.y = touch.position.y / Screen.height;
            }
        }
        else if (touch.phase == TouchPhase.Moved){
            if (leftFingerID == touch.fingerId){
                mDiff = touch.position - leftFingerCenter;
                var distPer = mDiff.magnitude * 30 / moveStickDiff;
                if (distPer > 30){
                    distPer = 30;
                }
                leftFingerInput = mDiff.normalized * distPer / 30;
                movePad.transform.position.x = leftFingerCenter.x / Screen.width + mDiff.normalized.x * distPer / 60 * moveStickDiff / Screen.width;
                movePad.transform.position.y = leftFingerCenter.y / Screen.height + mDiff.normalized.y * distPer / 60 * moveStickDiff / Screen.height;
            }
        }
        else if (touch.phase == TouchPhase.Ended || touch.phase == TouchPhase.Canceled){
            if (touch.fingerId == leftFingerID){
                movePad.transform.position = new Vector2(-1,-1);
                leftFingerID = -1;
                leftFingerInput = new Vector2(0, 0);
            }
        }
    }
    if(leftFingerInput.x > 0){
    	transform.localScale.x = -X;
    } else if (leftFingerInput.x < 0) {
    	transform.localScale.x = X;
    } 
    moveDirection = thisTransform.TransformDirection(new Vector3(leftFingerInput.x, 0, 0));
    moveDirection *= speed*2;
    moveDirection += Physics.gravity;
    if (character.isGrounded){
        doubleJump = false;
        if (jump && jumpingEnabled){
            velocityJ = character.velocity / 3;
            velocityJ.y = jumpSpeed;
        }
        else{
            velocityJ = new Vector3(0, 0, 0);
        }
    }
	/*
    else{
        if (!doubleJump && jump && doubleJumpingEnabled){
            velocityJ = character.velocity / 5;
            velocityJ.y = jumpSpeed;
            doubleJump = true;
        }
        
    }*/
	velocityJ.y += Physics.gravity.y * 3 * Time.smoothDeltaTime;
    moveDirection += velocityJ;
    character.Move(moveDirection * Time.smoothDeltaTime);
    if (OnControllerColliderHit(character.collider)){
    	character.velocity.y = 0;
    	character.velocity.z = 0;
    }
    jump = false;
}