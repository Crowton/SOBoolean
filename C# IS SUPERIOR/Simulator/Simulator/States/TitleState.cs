using Zendikar.Game;
using Zendikar.Game.Assets.AssetType;
using Zendikar.Game.Graphics;
using Zendikar.Game.States;

namespace Simulator.States
{
    public class TitleState : GameState
    {
        #region Properties

        public string DisplayedText { get; protected set; }
        public string Title { get; set; }

        public Time TimeBetweenCycles { get; set; } = Time.FromMilliseconds(50);
        public Time TimeAfterCompletion { get; set; } = Time.FromMilliseconds(500);

        public Sound CycleSound { get; set; } = null;

        public Color BackgroundColor { get; set; } = Color.Black;
        public Texture BackgroundTexture { get; set; } = null;

        #endregion

        #region Private Variables

        private readonly char[] _cycleCharacters = { '-', ' ' };
        private string _titleText = "";
        private int _cycle;
        private int _titleIndex;
        private readonly Text _text;
        private Time _timeSinceCycle = Time.Zero;
        private bool _completed;

        #endregion

        #region Constructors

        public TitleState(Game game, StateEngine engine, string name, string title) : base(game, engine, name)
        {
            Title = title;
            _text = new Text("", Simulator.MainFont, 28, Vector2F.Zero(), Color.White, Color.Black, 2);
        }
        public TitleState(StateEngine engine, string name, string title) : base(engine, name)
        {
            Title = title;
            _text = new Text("", Simulator.MainFont, 28, Vector2F.Zero(), Color.White, Color.Black, 2);
        }

        #endregion

        #region Logic

        public override void Draw(IRenderTarget target, RenderStates states)
        {
            // Draw the background color
            if (BackgroundTexture != null)
            {
                var backgroundState = states;
                backgroundState.Texture = BackgroundTexture;
                target.Draw(new[]
                {
                    new Vertex(Vector2F.Zero(), Vector2F.Zero(), BackgroundColor),
                    new Vertex(new Vector2F(target.Size.X, 0), new Vector2F(BackgroundTexture.Size.X, 0), BackgroundColor),
                    new Vertex(new Vector2F(target.Size.X, target.Size.Y), new Vector2F(BackgroundTexture.Size.X, BackgroundTexture.Size.Y), BackgroundColor),
                    new Vertex(new Vector2F(0, target.Size.Y), new Vector2F(0, BackgroundTexture.Size.Y), BackgroundColor)
                }, PrimitiveType.Quads, backgroundState);
            }
            else
            {
                target.Draw(new[]
                {
                    new Vertex(Vector2F.Zero(), BackgroundColor),
                    new Vertex(new Vector2F(target.Size.X, 0), BackgroundColor),
                    new Vertex(new Vector2F(target.Size.X, target.Size.Y), BackgroundColor),
                    new Vertex(new Vector2F(0, target.Size.Y), BackgroundColor)
                }, PrimitiveType.Quads, states);
            }

            // Draw title text at center of screen
            _text.Position = ((Vector2F)target.Size / 2) - (new Vector2F(_text.Bounds.Width / 2, _text.Bounds.Height / 2));
            _text.Draw(target, states);

            base.Draw(target, states);
        }
        public override void Update(GameTime updateTime)
        {
            // Add time since cycle.
            _timeSinceCycle += updateTime.DeltaTime;

            // Check if completed & exit time has passed
            if (_completed && _timeSinceCycle >= TimeAfterCompletion)
            {
                StateExitCompleted();
                return;
            }

            // Check if we need to cycle
            if (_timeSinceCycle >= TimeBetweenCycles && !_completed)
            {
                // Check if we are done
                if (_titleIndex == Title.Length)
                {
                    _completed = true;
                }

                // Check if at end of cycle
                if (_cycle + 1 >= _cycleCharacters.Length)
                {
                    // Reset Cycle
                    _cycle = 0;

                    // Increment character
                    if (_titleIndex < Title.Length)
                    {
                        _titleText += Title[_titleIndex];

                        // Play Cycle Sound
                        CycleSound?.Play();
                    }
                    _titleIndex++;
                }
                else
                {
                    _cycle++;
                }

                // Increment Cycle
                _text.DisplayedText = _titleText + _cycleCharacters[_cycle];

                // Reset Time 
                _timeSinceCycle = Time.Zero;
            }

            base.Update(updateTime);
        }

        #endregion
    }
}
