using Zendikar.Game.Graphics;

namespace Simulator
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            // Create new game object
            var game = new Simulator(new VideoMode(1280, 720), "Tower Defense", Styles.Titlebar | Styles.Close)
            {
                FramerateLimit = 120
            };

            // Run game
            //game.Closed += (sender, eventArgs) => game.Close();
            game.Start();
        }
    }
}