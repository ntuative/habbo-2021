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
    import flash.events.KeyboardEvent;
    import __AS3__.vec.Vector;
    import flash.geom.Rectangle;
    import onBoardingHcUi.Button;

    public class SsoTokenView extends Sprite 
    {

        private var _context:LoginFlow;
        private var _SafeStr_4547:TextField;
        private var _saveButton:ColouredButton;
        private var _cancelButton:ColouredButton;
        private var _loginAreaWidth:int = 640;
        private var _SafeStr_4570:InputField;
        private var _SafeStr_527:Boolean;

        public function SsoTokenView(_arg_1:LoginFlow)
        {
            _context = _arg_1;
            addEventListener("addedToStage", onAddedToStage);
            init();
        }

        public function dispose():void
        {
            if (_SafeStr_4570)
            {
                _SafeStr_4570.removeEventListener("change", onInputChange);
            };
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            var _local_2:Timer = new Timer(20, 1);
            _local_2.addEventListener("timerComplete", onAlignElements);
            _local_2.start();
        }

        private function onAlignElements(_arg_1:TimerEvent):void
        {
            LoaderUI.alignAnchors(_SafeStr_4570, 0, "r", _saveButton);
            LoaderUI.alignAnchors(_saveButton, (-20 - _cancelButton.width), "l", _cancelButton);
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
            _SafeStr_4570 = new InputField(_context, _loginAreaWidth, "${connection.login.code.prompt}", "", "${connection.login.useTicket}", "", true);
            addChild(_SafeStr_4570);
            _SafeStr_4570.addEventListener("change", onInputChange);
            _SafeStr_4570.addEventListener("keyDown", onInputKeyboardEvent);
            _SafeStr_4570.x = 0;
            _SafeStr_4570.y = 100;
        }

        private function onInputKeyboardEvent(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.charCode == 13)
            {
                if (((_saveButton) && (_saveButton.active)))
                {
                    onLogin(null);
                };
            };
        }

        private function onInputChange(_arg_1:Event):void
        {
            var _local_2:Vector.<String> = new Vector.<String>();
            if (validateToken(_local_2))
            {
                _context.updateEnvironment(_local_2[0], true);
                _saveButton.active = true;
            }
            else
            {
                _saveButton.active = false;
            };
        }

        public function addButtons():void
        {
            _cancelButton = new ColouredButton("red", "${generic.cancel}", new Rectangle(0, 300, 0, 40), true, onCancel, 0xD8D8D8);
            addChild(_cancelButton);
            _saveButton = new ColouredButton("gfreen", "${connection.login.play}", new Rectangle(0, 300, 0, 40), true, onLogin, 0xD8D8D8);
            _saveButton.active = false;
            addChild(_saveButton);
        }

        private function onLogin(_arg_1:Button):void
        {
            var _local_2:Vector.<String> = new Vector.<String>();
            if (validateToken(_local_2))
            {
                _context.initLoginWithSsoToken(_local_2[0], ((_local_2[1] + ".") + _local_2[2]));
            }
            else
            {
                _saveButton.active = false;
            };
        }

        private function validateToken(_arg_1:Vector.<String>):Boolean
        {
            var _local_4:String = _SafeStr_4570.text;
            if (!_local_4)
            {
                return (false);
            };
            if (_local_4.length == 0)
            {
                return (false);
            };
            var _local_3:Array = _local_4.split(".");
            if (_local_3.length != 3)
            {
                return (false);
            };
            var _local_2:String = _local_3[0].replace("hh", "");
            _local_2 = _local_2.replace("br", "pt");
            _local_2 = _local_2.replace("us", "en");
            _arg_1.push(_local_2);
            _arg_1.push(_local_3[1]);
            _arg_1.push(_local_3[2]);
            return (true);
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

