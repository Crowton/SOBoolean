using System;
using System.IO;
using Simulator.States;
using Zendikar.Game;
using Zendikar.Game.Assets;
using Zendikar.Game.Assets.AssetType;
using Zendikar.Game.Audio;
using Zendikar.Game.Graphics;
using Zendikar.Game.Input;
using Zendikar.IO.Files;
using Zendikar.Logging;

namespace Simulator
{
    internal sealed class Simulator : Game
    {
        #region Constants

        public const string SettingsFilePath = @"config.ini";
        public const string LogFilePath = @"Logs\{0}.log";
        public const string AssetPath = @"Assets\";
        public const string TilePath = @"Assets\Tiles\";
        public const string FontPath = @"Assets\Fonts\";
        public const string MapPath = @"Assets\Maps\";
        public const string SoundPath = @"Assets\Sounds\";
        public const string UiSoundPath = @"Assets\Sounds\UI\";

        #endregion

        #region Static Variables

        // Assets
        public static Font MainFont;

        #endregion

        #region Game GameSettings

        public static class GameSettings
        {
            // Sound
            public static float EffectVolume { get; set; } = 1f;

            // Graphics
            public static uint CirclePointCount { get; set; } = 100;
        }

        #endregion

        #region Properties

        // Logging
        public static LogHandler Logger { get; set; }

        // GameSettings
        public IniHandler SettingsFile { get; set; }

        // Debug
        public bool DisplayDebugInfo { get; set; }

        #endregion

        #region Constructors

        public Simulator(VideoMode mode, string title) : base(mode, title)
        {
            Console.Title = title;
            CommonInitialization();
        }

        public Simulator(VideoMode mode, string title, Styles style) : base(mode, title, style)
        {
            Console.Title = title;
            CommonInitialization();
        }

        public Simulator(VideoMode mode, string title, Styles style, ContextSettings settings)
            : base(mode, title, style, settings)
        {
            Console.Title = title;
            CommonInitialization();
        }

        public Simulator(IntPtr handle) : base(handle)
        {
            CommonInitialization();
        }

        public Simulator(IntPtr handle, ContextSettings settings) : base(handle, settings)
        {
            CommonInitialization();
        }

        #endregion

        #region Constructor Initialization Methods

        /// <summary>
        ///     Handles common initialization used for all different constructors.
        /// </summary>
        private void CommonInitialization()
        {
            // Create Log Directory
            if (!Directory.Exists("Logs"))
                Directory.CreateDirectory("Logs");

            // Create LogHandler
            Logger = new LogHandler(LogHandler.LogLevels.Error, false,
                string.Format(LogFilePath, DateTime.Now.ToString("yyyy-MM-dd_hh-mm-ss-tt")));
            Logger.Log("Starting game...", LogHandler.LogTags.Info);

            // Set Window Icon & Console Window Icon
            Logger.Log("Loadeding window icon", LogHandler.LogTags.System);
            var icon = new Image($"{AssetPath}Icon.png");
            SetIcon(icon.Pixels, (uint)icon.Size.X, (uint)icon.Size.Y);

            // Load GameSettings
            LoadSettings();
            Logger.Log("Loaded settings", LogHandler.LogTags.System);

            // Register Event Handlers
            RegisterEventHandlers();
            Logger.Log("Registered Eventshandlers", LogHandler.LogTags.System);


            // Load "global" texture & "global" font
            Logger.Log("Loading global assets", LogHandler.LogTags.System);
            //MainFont = BaseAsset<Font>.Load($"{FontPath}tahoma");
            MainFont = new Font($"{FontPath}tahoma.ttf");

            // Create Starting States
            Logger.Log("Loading IntroState", LogHandler.LogTags.System);
            var titleState = new TitleState(this, StateEngine, "IntroState", "Boolean Algebra")
            {
                CycleSound = new Sound(new SoundBuffer($"{UiSoundPath}click1.wav")) { Volume = GameSettings.EffectVolume },
                BackgroundColor = Color.Black
            };

            // Create ingamestate and load it
            Logger.Log("Loading IngameState", LogHandler.LogTags.System);
            var igs = new IngameState(this, StateEngine, "Ingame State");
            StateEngine.SetState(titleState);
            StateEngine.ExitState(igs);
        }

        private void LoadSettings()
        {
            // Check if the settings file exists, if not create it
            if (!File.Exists(SettingsFilePath))
            {
                // Create settingsfile
                Logger.Log("GameSettings file not found, creating default settings file", LogHandler.LogTags.Warning);
                File.CreateText(SettingsFilePath).Close();

                // Load IniHandler and write default values
                SettingsFile = new IniHandler(SettingsFilePath);

                // Graphics
                Logger.Log("Writing default settings", LogHandler.LogTags.System);
                SettingsFile.WriteValue("Graphics", "width", 1280);
                SettingsFile.WriteValue("Graphics", "height", 720);
                SettingsFile.WriteValue("Graphics", "x", 0);
                SettingsFile.WriteValue("Graphics", "y", 0);
                SettingsFile.WriteValue("Graphics", "frameLimit", 120);
                SettingsFile.WriteValue("Graphics", "vsync", true);

                // Input
                SettingsFile.WriteValue("Input", "joystickThreshold", 0f);
                SettingsFile.WriteValue("Input", "keyRepeat", true);

                // Debug
                SettingsFile.WriteValue("Debug", "debugMode", true);
                SettingsFile.WriteValue("Debug", "logLevel", (int)LogHandler.LogLevels.Error);

                // Sound
                SettingsFile.WriteValue("Sound", "effectVolume", 100f);
            }
            else
            {
                // Load IniHandler
                Logger.Log("Loading settings", LogHandler.LogTags.System);
                SettingsFile = new IniHandler(SettingsFilePath);
            }

            Logger.Log("Applying settings", LogHandler.LogTags.System);

            // Apply Sound GameSettings
            GameSettings.EffectVolume = float.Parse(SettingsFile.ReadValue("Sound", "effectVolume", 100));

            // Apply Graphics GameSettings
            Size = new Vector2U(uint.Parse(SettingsFile.ReadValue("Graphics", "width", 1280)), uint.Parse(SettingsFile.ReadValue("Graphics", "height", 720)));
            Position = new Vector2I(int.Parse(SettingsFile.ReadValue("Graphics", "x", 0)), int.Parse(SettingsFile.ReadValue("Graphics", "y", 0)));
            FramerateLimit = uint.Parse(SettingsFile.ReadValue("Graphics", "frameLimit", 120));
            Vsync = bool.Parse(SettingsFile.ReadValue("Graphics", "vsync", true));

            // Apply Input settings
            JoystickThreshold = float.Parse(SettingsFile.ReadValue("Input", "joystickThreshold", 0f));
            KeyRepeat = bool.Parse(SettingsFile.ReadValue("Input", "keyRepeat", true));

            // Apply Debug GameSettings
            Logger.LogLevel = (LogHandler.LogLevels)int.Parse(SettingsFile.ReadValue("Debug", "logLevel", 1));
            DisplayDebugInfo = bool.Parse(SettingsFile.ReadValue("Debug", "debugMode", true));

            if (DisplayDebugInfo)
                Logger.Log($"Debug mode is enabled, current loglevel is: {Logger.LogLevel} ({(int)Logger.LogLevel})",
                    LogHandler.LogTags.Info);
        }

        private void RegisterEventHandlers()
        {
            // Game Events
            Closed += OnClose;
            SizeChanged += OnSizeChanged;

            // StateEngine Events
            StateEngine.OnStateChange +=
                (sender, state, currentState) =>
                    Logger.Log($"Transfering state from \"{currentState?.Name}\" to \"{state?.Name}\"",
                        LogHandler.LogTags.System);
            StateEngine.OnStateExit +=
                (sender, state, currentState) =>
                    Logger.Log($"Exiting state \"{currentState?.Name}\" next state \"{state?.Name}\"",
                        LogHandler.LogTags.System);
        }

        #endregion

        #region Windows Event Handling

        private void OnSizeChanged(object sender, SizeEventArgs e)
        {
            // Update size of view
            var v = GetView();
            v.Size = new Vector2F(e.Width, e.Height);
            v.Center = new Vector2F(e.Width / 2, e.Height / 2);
            SetView(v);

            // Save change to settings
            SettingsFile.WriteValue("Graphics", "width", e.Width);
            SettingsFile.WriteValue("Graphics", "height", e.Height);
        }

        private void OnClose(object sender, EventArgs args)
        {
            // Log
            Logger.Log("Game closing...", LogHandler.LogTags.Info);

            // Close LogHandler
            Logger.Dispose();

            // Closes
            Close();
        }

        #endregion

        #region Overriden Drawing

        private Text _fpsText;
        private Text _updateFpsText;

        public override void OnDraw()
        {
            base.OnDraw();

            // Draw debug info
            if (DisplayDebugInfo)
            {
                if (_fpsText == null)
                {
                    _fpsText = new Text($"Draw   FPS: 0", 14, MainFont, new Vector2F(10, 10));
                    _updateFpsText = new Text($"Update FPS: 0", 14, MainFont, new Vector2F(10, 25));
                }

                // Draw FPS
                _fpsText.DisplayedText = $"Draw   FPS: {GameTime.GetFps().ToString("F")}";
                _updateFpsText.DisplayedText = $"Update   FPS: {UpdateTime.GetFps().ToString("F")}";
                _fpsText.Draw(this, RenderStates.Default);
                _updateFpsText.Draw(this, RenderStates.Default);
            }
        }

        #endregion
    }
}