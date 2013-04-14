class AwesomePlayerController extends UTPlayerController;

var vector CurrentCameraLocation, DesiredCameraLocation;
var vector PlayerViewOffset;
var rotator CurrentCameraRotation;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	bNoCrosshair = true;
}

reliable client function ClientSetHUD(class<HUD> newHUDType)
{
	if(myHUD != none)
		myHUD.Destroy();

	myHUD = spawn(class'AwesomeHUD', self);
}

function NotifyChangedWeapon( Weapon PreviousWeapon,  Weapon NewWeapon )
{
	super.NotifyChangedWeapon(PreviousWeapon, NewWeapon);
	NewWeapon.SetHidden(true);
	if(Pawn == none)
		return;
	if(UTWeap_RocketLauncher(NewWeapon) != none)
		Pawn.SetHidden(true);
	else
		Pawn.SetHidden(false);
}

exec function StartFire(optional byte FireModeNum)
{
	super.StartFire(FireModeNum);
}

function PlayerTick(float DeltaTime)
{
	super.PlayerTick(DeltaTime);
	if(Pawn != none)
	{
		DesiredCameraLocation = Pawn.Location + (PlayerViewOffset >> Pawn.Rotation);
		CurrentCameraLocation += (DesiredCameraLocation - CurrentCameraLocation) * DeltaTime * 3;
	}
}

simulated event GetPlayerViewPoint( out vector out_Location,  out Rotator out_Rotation )
{
	super.GetPlayerViewPoint(out_Location, out_Rotation);

	if (Pawn != none)
	{
		out_Location = CurrentCameraLocation;
		out_Rotation = rotator((out_Location * vect(1,1,0)) - out_Location);
	}

	CurrentCameraRotation = out_Rotation;
}

state PlayerWalking
{
	function ProcessMove(float DeltaTime, vector newAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
	{
		local vector X, Y, Z, AltAccel;

		GetAxes(CurrentCameraRotation, X, Y, Z);
		AltAccel = PlayerInput.aForward * Z + PlayerInput.aStrafe * Y;
		AltAccel.Z = 0;
		AltAccel = Pawn.AccelRate * Normal(AltAccel);
		super.ProcessMove(DeltaTime, AltAccel, DoubleClickMove, DeltaRot);
	}
}

function Rotator GetAdjustedAimFor( Weapon W,  vector StartFireLoc )
{
	return Pawn.Rotation;
}

DefaultProperties
{
	PlayerViewOffset = (X = 384, Y = 0, Z = 1024)
}