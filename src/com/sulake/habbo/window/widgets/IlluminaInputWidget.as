package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class IlluminaInputWidget implements IIlluminaInputWidget
    {

        public static const TYPE:String = "illumina_input";
        private static const _SafeStr_4433:String = "illumina_input:button_caption";
        private static const _SafeStr_4434:String = "illumina_input:empty_message";
        private static const MULTILINE_KEY:String = "illumina_input:multiline";
        private static const MAX_CHARS_KEY:String = "illumina_input:max_chars";
        private static const BUTTON_CAPTION_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:button_caption", "${widgets.chatinput.say}", "String");
        private static const EMPTY_MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:empty_message", "", "String");
        private static const MULTILINE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:multiline", false, "Boolean");
        private static const MAX_CHARS_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:max_chars", 0, "int");
        private static const SINGLE_LINE_HEIGHT:int = 28;

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _submitButton:_SafeStr_101;
        private var _SafeStr_1584:ITextFieldWindow;
        private var _emptyMessageLabel:ILabelWindow;
        private var _submitHandler:IIlluminaInputHandler;

        public function IlluminaInputWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("illumina_input_xml").content as XML)) as IWindowContainer);
            _SafeStr_1165.width = _SafeStr_4407.width;
            _submitButton = (_SafeStr_1165.findChildByName("submit") as _SafeStr_101);
            _SafeStr_1584 = (_SafeStr_1165.findChildByName("input") as ITextFieldWindow);
            _emptyMessageLabel = (_SafeStr_1165.findChildByName("empty_message") as ILabelWindow);
            buttonCaption = String(BUTTON_CAPTION_DEFAULT.value);
            emptyMessage = String(EMPTY_MESSAGE_DEFAULT.value);
            multiline = MULTILINE_DEFAULT.value;
            maxChars = int(MAX_CHARS_DEFAULT.value);
            refresh();
            _SafeStr_1165.procedure = widgetProcedure;
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_1584 != null)
                {
                    _SafeStr_1584 = null;
                };
                _submitButton = null;
                _emptyMessageLabel = null;
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(BUTTON_CAPTION_DEFAULT.withValue(buttonCaption));
            _local_1.push(EMPTY_MESSAGE_DEFAULT.withValue(emptyMessage));
            _local_1.push(MULTILINE_DEFAULT.withValue(multiline));
            _local_1.push(MAX_CHARS_DEFAULT.withValue(maxChars));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            if (_disposed)
            {
                return;
            };
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "illumina_input:button_caption":
                        buttonCaption = String(_local_2.value);
                        break;
                    case "illumina_input:empty_message":
                        emptyMessage = String(_local_2.value);
                        break;
                    case "illumina_input:multiline":
                        multiline = _local_2.value;
                        break;
                    case "illumina_input:max_chars":
                        maxChars = int(_local_2.value);
                };
            };
        }

        public function get buttonCaption():String
        {
            return (_submitButton.caption);
        }

        public function set buttonCaption(_arg_1:String):void
        {
            _submitButton.caption = _arg_1;
            _submitButton.visible = ((!(_arg_1 == null)) && (_arg_1.length > 0));
            refresh();
        }

        public function get emptyMessage():String
        {
            return (_emptyMessageLabel.caption);
        }

        public function set emptyMessage(_arg_1:String):void
        {
            _emptyMessageLabel.caption = _arg_1;
        }

        public function get multiline():Boolean
        {
            return (_SafeStr_1584.multiline);
        }

        public function set multiline(_arg_1:Boolean):void
        {
            _SafeStr_1584.multiline = _arg_1;
            _SafeStr_1165.setParamFlag(0x0800, _arg_1);
            _SafeStr_1165.height = ((_arg_1) ? _SafeStr_4407.height : 28);
        }

        public function get maxChars():int
        {
            return (_SafeStr_1584.maxChars);
        }

        public function set maxChars(_arg_1:int):void
        {
            _SafeStr_1584.maxChars = _arg_1;
        }

        public function get message():String
        {
            return (_SafeStr_1584.caption);
        }

        public function set message(_arg_1:String):void
        {
            _SafeStr_1584.caption = _arg_1;
            refresh();
        }

        public function get submitHandler():IIlluminaInputHandler
        {
            return (_submitHandler);
        }

        public function set submitHandler(_arg_1:IIlluminaInputHandler):void
        {
            _submitHandler = _arg_1;
        }

        private function widgetProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WE_CHANGE":
                    if (_arg_2 == _SafeStr_1584)
                    {
                        refresh();
                    };
                    return;
                case "WKE_KEY_DOWN":
                    if ((((_arg_2 == _SafeStr_1584) && (WindowKeyboardEvent(_arg_1).charCode == 13)) && (_submitButton.visible)))
                    {
                        submitMessage();
                    };
                    return;
                case "WME_CLICK":
                    if (_arg_2 == _submitButton)
                    {
                        submitMessage();
                    };
                    return;
            };
        }

        private function submitMessage():void
        {
            if (_submitHandler != null)
            {
                _submitHandler.onInput(_SafeStr_4407, message);
            };
        }

        private function refresh():void
        {
            _emptyMessageLabel.visible = (_SafeStr_1584.length == 0);
            _SafeStr_1584.width = (((_submitButton.visible) ? _submitButton.x : _SafeStr_1165.width) - (_SafeStr_1584.x * 2));
        }


    }
}