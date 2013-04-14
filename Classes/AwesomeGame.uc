class AwesomeGame extends UTDeathmatch;

var int EnemiesLeft;
var int EnemiesKilled;

simulated function PostBeginPlay()
{
	local TestEnemy TE;

	super.PostBeginPlay();
	GoalScore = 0;

	foreach DynamicActors(class'TestEnemy', TE)
		GoalScore++;

	EnemiesLeft = GoalScore;
}

function ScoreObjective(PlayerReplicationInfo Scorer, Int Score)
{
	EnemiesLeft--;
	EnemiesKilled++;
	super.ScoreObjective(Scorer, Score);
}

DefaultProperties
{
	DefaultInventory(0)=None
	bScoreDeaths=false
	PlayerControllerClass=class'AwesomeGame.AwesomePlayerController'
	DefaultPawnClass=class'AwesomeGame.AwesomePawn'
}