class AwesomeWeapon extends UTWeapon
	abstract;

const MAX_LEVEL = 5;
var int CurrentWeaponLevel;
var float FireRates[MAX_LEVEL];
var float AmmoCounts[MAX_LEVEL];

function UpgradeWeapon()
{
	if(CurrentWeaponLevel < MAX_LEVEL)
	{
		CurrentWeaponLevel++;
	}

	FireInterval[0] = FireRates[CurrentWeaponLevel - 1];
	MaxAmmoCount = AmmoCounts[CurrentWeaponLevel - 1];

	if (IsInState('WeaponFiring'))
	{
		ClearTimer(nameof(RefireCheckTimer));
		TimeWeaponFiring(CurrentFireMode);
	}

	AddAmmo(MaxAmmoCount);
}

defaultproperties
{
	FireRates(0)=1.5
	FireRates(1)=1.0
	FireRates(2)=0.5
	FireRates(3)=0.3
	FireRates(4)=0.1
	AmmoCounts(0)=40
	AmmoCounts(1)=80
	AmmoCounts(2)=160
	AmmoCounts(3)=300
	AmmoCounts(4)=1000
}