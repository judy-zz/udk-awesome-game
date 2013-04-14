class AwesomeHUD extends UTGFxHUDWrapper;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
}

event DrawHUD()
{
	super.DrawHUD();

	Canvas.DrawColor = WhiteColor;
	Canvas.Font = class'Engine'.Static.GetLargeFont();

	if(PlayerOwner.Pawn != none && AwesomeWeapon(PlayerOwner.Pawn.Weapon) != none)
	{
		Canvas.SetPos(Canvas.ClipX * 0.1, Canvas.ClipY * 0.9);
		Canvas.DrawText("Weapon Level:" @ AwesomeWeapon(PlayerOwner.Pawn.Weapon).CurrentWeaponLevel);
	}

	if(AwesomeGame(WorldInfo.Game) != none)
	{
		Canvas.SetPos(Canvas.ClipX * 0.1, Canvas.ClipY * 0.95);
		Canvas.DrawText("Enemies Killed:" @ AwesomeGame(WorldInfo.Game).EnemiesKilled);
	}
}

defaultproperties
{
	
}