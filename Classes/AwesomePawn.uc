class AwesomePawn extends UTPawn;

var bool bInvulnerable;
var float InvulnerableTime;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if(ArmsMesh[0] != none)
		ArmsMesh[0].SetHidden(true);
	if(ArmsMesh[1] != none)
		ArmsMesh[1].SetHidden(true);
}

event Bump( Actor Other, PrimitiveComponent OtherComp, Vector HitNormal )
{
	if(TestEnemy(Other) != none && !bInvulnerable)
	{
		bInvulnerable = true;
		SetTimer(InvulnerableTime, false, 'BecomeVulnerable');
		TakeDamage(TestEnemy(Other).BumpDamage, none, Location, vect(0,0,0), class'UTDmgType_LinkPlasma');
	}
}

function BecomeVulnerable()
{
	bInvulnerable = false;
}

simulated function SetMeshVisibility(bool bVisible)
{
	super.SetMeshVisibility(bVisible);
	Mesh.SetOwnerNoSee(false);
}

defaultproperties
{
	InvulnerableTime=0.6
}