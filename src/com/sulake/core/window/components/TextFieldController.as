package com.sulake.core.window.components
{
    import flash.filters.DropShadowFilter;
    import flash.text.TextField;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Point;
    import flash.events.TextEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.IInputEventTracker;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import com.sulake.core.window.utils.PropertyStruct;

    public class TextFieldController extends TextController implements ITextFieldWindow 
    {

        private static const _WORD_DELIMS:RegExp = /[~%&!\\;:"',<>?#\s\.\-()=\[\]\{\}\^_]/g;

        private var _SafeStr_956:DropShadowFilter = new DropShadowFilter(1, 90, 0xFFFFFF, 1, 0, 0);
        protected var _SafeStr_915:uint = 500;
        protected var _toolTipCaption:String = "";
        protected var _SafeStr_916:Boolean = false;
        protected var _SafeStr_914:Boolean = false;
        protected var _SafeStr_527:Boolean = false;
        protected var _filters:Array = [];
        protected var _SafeStr_957:Boolean;

        public function TextFieldController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 & (~(0x10)));
            _arg_4 = (_arg_4 | 0x01);
            _SafeStr_954 = _arg_6.x;
            _SafeStr_955 = _arg_6.y;
            _SafeStr_908 = _arg_6.width;
            _SafeStr_909 = _arg_6.height;
            _field = TextField(getGraphicContext(true).getDisplayObject());
            _field.antiAliasType = "advanced";
            _field.gridFitType = "pixel";
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _field.addEventListener("textInput", onTextInputEvent);
            _field.addEventListener("keyDown", onKeyDownEvent);
            _field.addEventListener("keyUp", onKeyUpEvent);
            _field.addEventListener("change", onChangeEvent);
            _field.addEventListener("focusIn", onFocusEvent);
            _field.addEventListener("focusOut", onFocusEvent);
            _field.addEventListener("removedFromStage", onRemovedEvent);
            antiAliasType = "advanced";
            gridFitType = "pixel";
            _SafeStr_899 = false;
            _SafeStr_527 = true;
        }

        public static function getWordPositions(_arg_1:String):Array
        {
            var _local_3:Object;
            var _local_2:Array = [];
            _local_2.push(0);
            while ((_local_3 = _WORD_DELIMS.exec(_arg_1)) != null)
            {
                if (_local_3.index < _arg_1.length)
                {
                    _local_2.push((_local_3.index + 1));
                };
            };
            return (_local_2);
        }


        public function get focused():Boolean
        {
            if (_field)
            {
                if (_field.stage)
                {
                    return (_field.stage.focus == _field);
                };
            };
            return (false);
        }

        override public function enable():Boolean
        {
            if (super.enable())
            {
                _field.type = "input";
                return (true);
            };
            _field.type = "dynamic";
            return (false);
        }

        override public function disable():Boolean
        {
            if (super.disable())
            {
                _field.type = "dynamic";
                return (true);
            };
            _field.type = "input";
            return (false);
        }

        public function get editable():Boolean
        {
            return (_field.type == "input");
        }

        public function set editable(_arg_1:Boolean):void
        {
            _field.type = ((_arg_1) ? "input" : "dynamic");
        }

        public function get selectable():Boolean
        {
            return (_field.selectable);
        }

        public function set selectable(_arg_1:Boolean):void
        {
            _field.selectable = _arg_1;
        }

        public function set displayAsPassword(_arg_1:Boolean):void
        {
            _field.displayAsPassword = _arg_1;
        }

        public function get displayAsPassword():Boolean
        {
            return (_field.displayAsPassword);
        }

        public function set mouseCursorType(_arg_1:uint):void
        {
        }

        public function get mouseCursorType():uint
        {
            return (0);
        }

        public function set toolTipCaption(_arg_1:String):void
        {
            _toolTipCaption = ((_arg_1 == null) ? "" : _arg_1);
        }

        public function get toolTipCaption():String
        {
            return (_toolTipCaption);
        }

        public function set toolTipDelay(_arg_1:uint):void
        {
            _SafeStr_915 = _arg_1;
        }

        public function get toolTipDelay():uint
        {
            return (_SafeStr_915);
        }

        public function setMouseCursorForState(_arg_1:uint, _arg_2:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }

        public function getMouseCursorByState(_arg_1:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }

        public function showToolTip(_arg_1:IToolTipWindow):void
        {
            throw (new Error("Unimplemented method!"));
        }

        public function hideToolTip():void
        {
            throw (new Error("Unimplemented method!"));
        }

        override public function set autoSize(_arg_1:String):void
        {
            super.autoSize = _arg_1;
            refreshAutoSize();
        }

        override public function set background(_arg_1:Boolean):void
        {
            _field.background = _arg_1;
            _background = _arg_1;
            _fillColor = ((_background) ? (_fillColor | _alphaColor) : (_fillColor & 0xFFFFFF));
        }

        public function setSelection(_arg_1:int, _arg_2:int):void
        {
            _field.setSelection(_arg_1, _arg_2);
        }

        public function get selectionBeginIndex():int
        {
            return (_field.selectionBeginIndex);
        }

        public function get selectionEndIndex():int
        {
            return (_field.selectionEndIndex);
        }

        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_897))))
            {
                _SafeStr_897 = new GraphicContext((("GC {" + _name) + "}"), 2, rectangle);
            };
            return (_SafeStr_897);
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                _context.getWindowServices().getFocusManagerService().removeFocusWindow(this);
                _SafeStr_914 = false;
                if (_field)
                {
                    if (focused)
                    {
                        unfocus();
                    };
                    _field.removeEventListener("keyDown", onKeyDownEvent);
                    _field.removeEventListener("keyUp", onKeyUpEvent);
                    _field.removeEventListener("change", onChangeEvent);
                    _field.removeEventListener("focusIn", onFocusEvent);
                    _field.removeEventListener("focusOut", onFocusEvent);
                    _field.removeEventListener("removedFromStage", onRemovedEvent);
                };
                super.dispose();
            };
        }

        override public function set text(_arg_1:String):void
        {
            super.text = _arg_1;
            refreshAutoSize();
        }

        override public function focus():Boolean
        {
            var _local_1:Boolean = super.focus();
            if (_local_1)
            {
                if (_field)
                {
                    if (_field.stage)
                    {
                        if (_field.stage.focus != _field)
                        {
                            _field.stage.focus = _field;
                        };
                    };
                };
            };
            return (_local_1);
        }

        override public function unfocus():Boolean
        {
            if (_field)
            {
                if (_field.stage)
                {
                    if (_field.stage.focus == _field)
                    {
                        _field.stage.focus = null;
                    };
                };
            };
            return (super.unfocus());
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            switch (_arg_2.type)
            {
                case "WE_ACTIVATED":
                case "WME_DOWN":
                    focus();
                    break;
                case "WE_RESIZED":
                    if (_arg_1 == this)
                    {
                        _field.width = this.width;
                        _field.height = this.height;
                    };
            };
            if (_arg_1 == this)
            {
                InteractiveController.processInteractiveWindowEvents(this, _arg_2);
            };
            return (_local_3);
        }

        protected function refreshAutoSize():void
        {
            var _local_2:Point;
            var _local_1:Point;
            if (((_SafeStr_527) && (!(autoSize == "none"))))
            {
                if (((!(_SafeStr_908 == _field.width)) || (!(_SafeStr_909 == _field.height))))
                {
                    _local_2 = _field.localToGlobal(new Point(_field.x, _field.y));
                    var _local_3:Point = new Point();
                    getGlobalPosition(_local_3);
                    _local_1 = new Point((_local_2.x - _local_3.x), (_local_2.y - _local_3.y));
                    setRectangle((_SafeStr_954 + _local_1.x), (_SafeStr_955 + _local_1.y), _field.width, _field.height);
                };
            };
        }

        override public function set filters(_arg_1:Array):void
        {
            _SafeStr_957 = true;
            _filters = _arg_1;
            updateFilters();
        }

        override public function get filters():Array
        {
            return (_filters);
        }

        override public function set etchingColor(_arg_1:uint):void
        {
            _SafeStr_957 = true;
            super.etchingColor = _arg_1;
        }

        private function updateFilters():void
        {
            var _local_1:Array;
            if (!_SafeStr_957)
            {
                return;
            };
            _SafeStr_957 = false;
            if ((_etchingColor & 0xFF000000) != 0)
            {
                _SafeStr_956.color = (_etchingColor & 0xFFFFFF);
                _SafeStr_956.alpha = (((_etchingColor >> 24) & 0xFF) / 0xFF);
                _local_1 = _filters.slice();
                _local_1.push(_SafeStr_956);
                getGraphicContext(true).filters = _local_1;
            }
            else
            {
                getGraphicContext(true).filters = _filters;
            };
        }

        override protected function refreshTextImage(_arg_1:Boolean=false):void
        {
            var _local_3:WindowEvent;
            var _local_2:Boolean;
            updateFilters();
            if (_SafeStr_908 != _field.width)
            {
                if (autoSize != "none")
                {
                    width = _field.width;
                    _local_2 = true;
                }
                else
                {
                    _field.width = width;
                };
            };
            if (_SafeStr_909 != _field.height)
            {
                if (autoSize != "none")
                {
                    height = _field.height;
                    _local_2 = true;
                }
                else
                {
                    _field.height = height;
                };
            };
            if ((((!(_local_2)) && (!(_arg_1))) && (_SafeStr_913)))
            {
                _local_3 = WindowEvent.allocate("WE_RESIZED", this, null);
                _SafeStr_913.dispatchEvent(_local_3);
                _local_3.recycle();
            };
        }

        private function onTextInputEvent(_arg_1:TextEvent):void
        {
            if (hasTooManyLines(_arg_1.text))
            {
                _arg_1.preventDefault();
            };
        }

        private function hasTooManyLines(_arg_1:String):Boolean
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:Boolean;
            if (((multiline) && (maxLines > 0)))
            {
                _local_4 = (numLines > maxLines);
                if (_arg_1 != null)
                {
                    _local_2 = _field.text;
                    _local_3 = _field.caretIndex;
                    _field.text = ((_local_2.substring(0, _local_3) + _arg_1) + _local_2.substring(_local_3, _local_2.length));
                    if (numLines > maxLines)
                    {
                        _local_4 = true;
                    };
                    _field.text = _local_2;
                };
            };
            return (_local_4);
        }

        private function onKeyDownEvent(_arg_1:KeyboardEvent):void
        {
            var _local_3:WindowKeyboardEvent;
            try
            {
                _local_3 = WindowKeyboardEvent.allocate("WKE_KEY_DOWN", _arg_1, this, null);
                update(this, _local_3);
                if (disposed)
                {
                    return;
                };
                for each (var _local_2:IInputEventTracker in _context.inputEventTrackers)
                {
                    _local_2.eventReceived(_local_3, this);
                };
                _local_3.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(5, e);
            };
        }

        private function onKeyUpEvent(_arg_1:KeyboardEvent):void
        {
            var _local_3:WindowKeyboardEvent;
            try
            {
                _caption = _field.text;
                _local_3 = WindowKeyboardEvent.allocate("WKE_KEY_UP", _arg_1, this, null);
                update(this, _local_3);
                if (disposed)
                {
                    return;
                };
                for each (var _local_2:IInputEventTracker in _context.inputEventTrackers)
                {
                    _local_2.eventReceived(_local_3, this);
                };
                _local_3.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(5, e);
            };
        }

        public function requestChangeEvent():void
        {
            onChangeEvent(null);
        }

        private function onChangeEvent(_arg_1:Event):void
        {
            var _local_2:WindowEvent;
            try
            {
                refreshAutoSize();
                _local_2 = WindowEvent.allocate("WE_CHANGE", this, null);
                update(this, _local_2);
                _local_2.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(5, e);
            };
        }

        private function onFocusEvent(_arg_1:FocusEvent):void
        {
            try
            {
                if (_arg_1.type == "focusIn")
                {
                    if (!getStateFlag(2))
                    {
                        focus();
                    };
                }
                else
                {
                    if (_arg_1.type == "focusOut")
                    {
                        if (getStateFlag(2))
                        {
                            unfocus();
                        };
                    };
                };
            }
            catch(e:Error)
            {
                _context.handleError(5, e);
            };
        }

        private function onRemovedEvent(_arg_1:Event):void
        {
            try
            {
                if (getStateFlag(2))
                {
                    unfocus();
                };
            }
            catch(e:Error)
            {
                _context.handleError(5, e);
            };
        }

        override public function get properties():Array
        {
            var _local_1:Array = InteractiveController.writeInteractiveWindowProperties(this, super.properties);
            _local_1.push(createProperty("editable", (_field.type == "input")));
            _local_1.push(createProperty("focus_capturer", _SafeStr_914));
            _local_1.push(createProperty("selectable", _field.selectable));
            _local_1.push(createProperty("display_as_password", _field.displayAsPassword));
            _local_1.push(createProperty("display_raw", _SafeStr_905));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            InteractiveController.readInteractiveWindowProperties(this, _arg_1);
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "focus_capturer":
                        _SafeStr_914 = (_local_2.value as Boolean);
                        if (_SafeStr_914)
                        {
                            _context.getWindowServices().getFocusManagerService().registerFocusWindow(this);
                        };
                        break;
                    case "selectable":
                        _field.selectable = (_local_2.value as Boolean);
                        break;
                    case "editable":
                        _field.type = ((_local_2.value) ? "input" : "dynamic");
                        break;
                    case "display_as_password":
                        _field.displayAsPassword = (_local_2.value as Boolean);
                        break;
                    case "display_raw":
                        _SafeStr_905 = (_local_2.value as Boolean);
                };
            };
            super.properties = _arg_1;
        }

        public function set toolTipIsDynamic(_arg_1:Boolean):void
        {
            _SafeStr_916 = _arg_1;
        }

        public function get toolTipIsDynamic():Boolean
        {
            return (_SafeStr_916);
        }

        public function set displayRaw(_arg_1:Boolean):void
        {
            _SafeStr_905 = _arg_1;
        }

        public function get displayRaw():Boolean
        {
            return (_SafeStr_905);
        }

        override public function set localization(_arg_1:String):void
        {
            super.localization = limitStringLength(((_SafeStr_905) ? _caption : _arg_1));
        }

        public function getWordAt(_arg_1:int, _arg_2:int):String
        {
            var _local_5:int;
            var _local_8:int;
            var _local_9:int;
            var _local_3:int = getCharIndexAtPoint(_arg_1, _arg_2);
            var _local_6:String = _field.text;
            var _local_4:Array = getWordPositions(_local_6);
            var _local_7:String = "";
            _local_5 = 0;
            while (_local_5 < _local_4.length)
            {
                _local_8 = _local_4[_local_5];
                _local_9 = _local_6.length;
                if ((_local_5 + 1) < _local_4.length)
                {
                    _local_9 = (_local_4[(_local_5 + 1)] - 1);
                };
                if (((_local_3 >= _local_8) && (_local_3 <= _local_9)))
                {
                    _local_7 = _local_6.substring(_local_8, _local_9);
                    break;
                };
                _local_5++;
            };
            return (_local_7);
        }


    }
}

