package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;

    public class TextFieldManager 
    {

        private var _navigator:IHabboTransitionalNavigator;
        private var _input:ITextFieldWindow;
        private var _includeInfo:Boolean;
        private var _SafeStr_2469:String = "";
        private var _maxTextLen:int;
        private var _onEnter:Function;
        private var _SafeStr_3004:String = "";
        private var _errorPopup:IWindowContainer;
        private var _orgTextBackground:Boolean;
        private var _orgTextBackgroundColor:uint;

        public function TextFieldManager(_arg_1:IHabboTransitionalNavigator, _arg_2:ITextFieldWindow, _arg_3:int=1000, _arg_4:Function=null, _arg_5:String=null)
        {
            _navigator = _arg_1;
            _input = _arg_2;
            _maxTextLen = _arg_3;
            _arg_2.maxChars = _arg_3;
            _onEnter = _arg_4;
            if (_arg_5 != null)
            {
                _includeInfo = true;
                _SafeStr_2469 = _arg_5;
                _input.text = _arg_5;
            };
            Util.setProcDirectly(_input, onInputClick);
            _input.addEventListener("WKE_KEY_DOWN", checkEnterPress);
            _input.addEventListener("WE_CHANGE", checkMaxLen);
            this._orgTextBackground = _input.textBackground;
            this._orgTextBackgroundColor = _input.textBackgroundColor;
        }

        public function dispose():void
        {
            if (_input)
            {
                _input.dispose();
                _input = null;
            };
            if (_errorPopup)
            {
                _errorPopup.dispose();
                _errorPopup = null;
            };
            _navigator = null;
        }

        public function checkMandatory(_arg_1:String):Boolean
        {
            if (!isInputValid())
            {
                displayError(_arg_1);
                return (false);
            };
            restoreBackground();
            return (true);
        }

        public function restoreBackground():void
        {
            _input.textBackground = this._orgTextBackground;
            _input.textBackgroundColor = this._orgTextBackgroundColor;
        }

        public function displayError(_arg_1:String):void
        {
            _input.textBackground = true;
            _input.textBackgroundColor = 4294021019;
            if (this._errorPopup == null)
            {
                this._errorPopup = IWindowContainer(_navigator.getXmlWindow("nav_error_popup"));
                _navigator.refreshButton(this._errorPopup, "popup_arrow_down", true, null, 0);
                IWindowContainer(_input.parent).addChild(this._errorPopup);
            };
            var _local_4:ITextWindow = ITextWindow(this._errorPopup.findChildByName("error_text"));
            _local_4.text = _arg_1;
            _local_4.width = (_local_4.textWidth + 5);
            _errorPopup.findChildByName("border").width = (_local_4.width + 15);
            _errorPopup.width = (_local_4.width + 15);
            var _local_2:Point = new Point();
            _input.getLocalPosition(_local_2);
            this._errorPopup.x = _local_2.x;
            this._errorPopup.y = ((_local_2.y - this._errorPopup.height) + 3);
            var _local_3:IWindow = _errorPopup.findChildByName("popup_arrow_down");
            _local_3.x = ((this._errorPopup.width / 2) - (_local_3.width / 2));
            _errorPopup.x = (_errorPopup.x + ((_input.width - _errorPopup.width) / 2));
            this._errorPopup.visible = true;
        }

        public function goBackToInitialState():void
        {
            clearErrors();
            if (_SafeStr_2469 != null)
            {
                _input.text = _SafeStr_2469;
                _includeInfo = true;
            }
            else
            {
                _input.text = "";
                _includeInfo = false;
            };
        }

        public function getText():String
        {
            if (_includeInfo)
            {
                return (_SafeStr_3004);
            };
            return (_input.text);
        }

        public function setText(_arg_1:String):void
        {
            _includeInfo = false;
            _input.text = _arg_1;
        }

        public function clearErrors():void
        {
            this.restoreBackground();
            if (this._errorPopup != null)
            {
                _errorPopup.visible = false;
            };
        }

        public function get input():ITextFieldWindow
        {
            return (_input);
        }

        private function isInputValid():Boolean
        {
            return ((!(_includeInfo)) && (Util.trim(getText()).length > 2));
        }

        private function onInputClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WE_FOCUSED")
            {
                return;
            };
            if (!_includeInfo)
            {
                return;
            };
            _input.text = _SafeStr_3004;
            _includeInfo = false;
            this.restoreBackground();
        }

        private function checkEnterPress(_arg_1:WindowKeyboardEvent):void
        {
            if (_arg_1.charCode == 13)
            {
                if (_onEnter != null)
                {
                    (_onEnter());
                };
            };
        }

        private function checkMaxLen(_arg_1:WindowEvent):void
        {
            var _local_2:String = _input.text;
            if (_local_2.length > _maxTextLen)
            {
                _input.text = _local_2.substring(0, _maxTextLen);
            };
        }


    }
}

