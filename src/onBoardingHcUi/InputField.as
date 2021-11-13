package onBoardingHcUi
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class InputField extends Sprite 
    {

        private var _style:int = 2;
        private var _disposed:Boolean;
        private var _context:IUIContext;
        private var _frame:Sprite;
        private var _promptField:TextField;
        private var _field:TextField;
        private var _submitButton:Button;
        private var _skipButton:Button;
        private var _background:Bitmap;
        private var _inputClickedAlready:Boolean;
        private var _inputDefaultString:String;
        private var _dialogWidth:int;
        private var _isPassword:Boolean;
        private var _caption:String;
        private var _subCaption:String;
        private var _maxWidth:Number;
        private var _prompt:String;

        public function InputField(_arg_1:IUIContext, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:Boolean=false)
        {
            _context = _arg_1;
            _dialogWidth = _arg_2;
            _prompt = _arg_3;
            _inputDefaultString = ((_arg_4 == null) ? "" : _arg_4);
            _caption = _arg_5;
            _subCaption = _arg_6;
            _isPassword = _arg_7;
            init();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_frame)
            {
                removeChild(_frame);
            };
            _field = null;
            _promptField = null;
            _submitButton = null;
            _skipButton = null;
            _background = null;
            _frame = null;
            _context = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function init():void
        {
            _frame = LoaderUI.createFrame(_caption, _subCaption, new Rectangle(0, 0, _dialogWidth, 1), _style);
            addChild(_frame);
            var _local_2:int;
            var _local_1:Sprite = new Sprite();
            _background = NineSplitSprite.INPUT_FIELD_HITCH.render(_dialogWidth, 31);
            _local_1.addChild(_background);
            _frame.addChild(_local_1);
            _local_1.x = _local_2;
            _maxWidth = (_local_1.width - 30);
            _promptField = LoaderUI.createTextField(_prompt, 18, 0x666666, true, false, false, false);
            _promptField.alpha = 0.8;
            _promptField.x = (_local_1.x + 16);
            _promptField.y = (_local_1.y + int(((_local_1.height - _promptField.height) / 2)));
            _promptField.width = _maxWidth;
            _promptField.visible = ((_inputDefaultString == null) || (_inputDefaultString.length == 0));
            _frame.addChild(_promptField);
            _field = LoaderUI.createTextField(_inputDefaultString, 18, 0x666666, true, false, true, false);
            _field.displayAsPassword = _isPassword;
            _frame.addChild(_field);
            _field.x = (_local_1.x + 16);
            _field.y = (_local_1.y + int(((_local_1.height - _field.height) / 2)));
            _field.width = _maxWidth;
            _field.addEventListener("click", onInputClicked);
            _field.addEventListener("change", onInputChange);
            if (((!(_inputDefaultString)) || (_inputDefaultString.length == 0)))
            {
                _field.autoSize = "none";
                _field.width = _maxWidth;
            };
            _local_1.addEventListener("click", onInputBackgroundClicked);
            var _local_3:int = -50;
            _frame.y = -(int((_local_3 / 2)));
        }

        private function onInputChange(_arg_1:Event):void
        {
            _promptField.visible = (_field.text.length == 0);
            if (_field.width > _maxWidth)
            {
                _field.autoSize = "none";
                _field.width = _maxWidth;
            };
            if (_arg_1 != null)
            {
                dispatchEvent(_arg_1.clone());
            };
        }

        private function onInputBackgroundClicked(_arg_1:MouseEvent):void
        {
            _context.stage.focus = _field;
            onInputClicked(null);
        }

        private function onInputClicked(_arg_1:Event):void
        {
            if (_inputClickedAlready)
            {
                return;
            };
            _promptField.visible = false;
            _inputClickedAlready = true;
            _field.textColor = ((_style == 2) ? 0x666666 : 0);
            _field.removeEventListener("click", onInputClicked);
            onInputChange(null);
        }

        public function get text():String
        {
            return (_field.text);
        }


    }
}