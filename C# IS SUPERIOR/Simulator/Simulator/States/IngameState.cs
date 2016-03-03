using System.Collections.Generic;
using Zendikar.Game;
using Zendikar.Game.Graphics;
using Zendikar.Game.Gui;
using Zendikar.Game.Gui.Components;
using Zendikar.Game.Gui.Elements;
using Zendikar.Game.Gui.Elements.Components;
using Zendikar.Game.Input;
using Zendikar.Game.States;
using Zendikar.Logging;

namespace Simulator.States
{
    public class IngameState : GameState
    {

        #region Properties
        
        // UI
        public List<GuiElement> Gui { get; set; } = new List<GuiElement>();

        #endregion

        #region Private Variables
        #endregion

        #region Constructors

        public IngameState(Game game, StateEngine engine, string name) : base(game, engine, name)
        {
            // Initialize UI
            InitializeUI();
        }
        public IngameState(StateEngine engine, string name) : base(engine, name)
        {
            // Initialize UI
            InitializeUI();
        }

        #endregion

        #region IUpdateable & IDrawable

        // Draw
        public override void Draw(IRenderTarget target, RenderStates states)
        {
            // Draw GUI
            foreach (var element in Gui)
            {
                element.Draw(target, states);
            }

            base.Draw(target, states);
        }

        // Update
        public override void Update(GameTime updateTime)
        {
            foreach (var element in Gui)
            {
                element.Update(updateTime);
            }

            base.Update(updateTime);
        }

        // Handle input
        public override void HandleMouseMove(MouseMoveEventArgs e)
        {
            foreach (var element in Gui)
            {
                element.HandleMouseMove(e);
            }

            base.HandleMouseMove(e);
        }
        public override void HandleMouseInput(MouseButtonEventArgs e)
        {
            foreach (var element in Gui)
            {
                element.HandleMouseInput(e);
            }

            base.HandleMouseInput(e);
        }
        public override void HandleInput(KeyEventArgs e)
        {
            foreach (var element in Gui)
            {
                element.HandleInput(e);
            }

            base.HandleInput(e);
        }

        #endregion

        #region UIs
        
        public void InitializeUI()
        {
        }

        #endregion

    }
}