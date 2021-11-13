package login
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import onBoardingHcUi.ColouredButton;
    import onBoardingHcUi.InputField;
    import flash.utils.Timer;
    import flash.events.Event;
    import onBoardingHcUi.LoaderUI;
    import flash.events.TimerEvent;
    import com.sulake.habbo.utils.CommunicationUtils;
    import flash.geom.Rectangle;
    import onBoardingHcUi.Button;

    public class LoginView extends Sprite 
    {

        private var _context:ILoginContext;
        private var _SafeStr_4547:TextField;
        private var _saveButton:ColouredButton;
        private var _cancelButton:ColouredButton;
        private var _SafeStr_4568:InputField;
        private var _loginAreaWidth:int = 640;
        private var _SafeStr_4569:InputField;
        private var _SafeStr_527:Boolean;

        public function LoginView(_arg_1:ILoginContext)
        {
            _context = _arg_1;
            addEventListener("addedToStage", onAddedToStage);
            init();
        }

        public function dispose():void
        {
            _saveButton.dispose();
            _cancelButton.dispose();
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            var _local_2:Timer = new Timer(20, 1);
            _local_2.addEventListener("timerComplete", onAlignElements);
            _local_2.start();
        }

        private function onAlignElements(_arg_1:TimerEvent):void
        {
            LoaderUI.lineUpVertically(_SafeStr_4568, -20, _SafeStr_4569);
            LoaderUI.alignAnchors(_SafeStr_4568, 0, "l", _SafeStr_4569);
            LoaderUI.alignAnchors(_SafeStr_4568, 0, "r", _saveButton);
            LoaderUI.lineUpHorizontallyRevers(_saveButton, 20, _cancelButton);
            Logger.log(("(login) Buttons: " + [_saveButton.x, _saveButton.y, _cancelButton.x, _cancelButton.y]));
        }

        public function init():void
        {
            if (_SafeStr_527)
            {
                return;
            };
            _SafeStr_527 = true;
            addTitleField();
            addInputFields();
            addButtons();
        }

        private function addTitleField():void
        {
            if (!_SafeStr_4547)
            {
                _SafeStr_4547 = LoaderUI.createTextField("${connection.login.title}", 40, 0xFFFFFF, false, true, false, false, "left");
                _SafeStr_4547.x = 0;
                _SafeStr_4547.y = 0;
                _SafeStr_4547.width = 500;
                _SafeStr_4547.multiline = false;
                _SafeStr_4547.thickness = 50;
                addChild(_SafeStr_4547);
            };
        }

        private function addInputFields():void
        {
            _SafeStr_4568 = new InputField(_context, _loginAreaWidth, "${connection.login.email}", CommunicationUtils.readSOLString("login"), "${connection.login.missing_credentials}", "");
            addChild(_SafeStr_4568);
            _SafeStr_4568.x = 0;
            _SafeStr_4568.y = 100;
            _SafeStr_4569 = new InputField(_context, _loginAreaWidth, "${connection.login.password}", CommunicationUtils.restorePassword(), "", "", true);
            addChild(_SafeStr_4569);
        }

        public function addButtons():void
        {
            _cancelButton = new ColouredButton("red", "${generic.cancel}", new Rectangle(0, 300, 0, 40), true, onCancel, 0xD8D8D8);
            addChild(_cancelButton);
            _saveButton = new ColouredButton("gfreen", "${connection.login.play}", new Rectangle(0, 300, 0, 40), true, saveOutfit, 0xD8D8D8);
            _saveButton.active = false;
            addChild(_saveButton);
        }

        private function saveOutfit(_arg_1:Button):void
        {
            _context.initLogin(_SafeStr_4568.text, _SafeStr_4569.text);
        }

        private function onCancel(_arg_1:Button):void
        {
            _context.showScreen(1);
        }

        public function ready():void
        {
            if (_saveButton != false)
            {
                _saveButton.active = true;
            };
        }


    }
}

