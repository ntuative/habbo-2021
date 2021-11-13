package onBoardingHcUi
{
    import flash.geom.Rectangle;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;

    public class Button extends LocalizedSprite 
    {

        private static const button_png:Class = HabboButton_button_png;
        private static const button_pressed_png:Class = HabboButton_button_pressed_png;
        private static const button_inactive_png:Class = HabboButton_button_inactive_png;

        private var _label:String;
        private var _localizedText:String;
        protected var _rectangle:Rectangle;
        private var _fitWidthToText:Boolean;
        private var _centred:Boolean;
        private var _action:Function;
        private var _glowColour:uint;
        private var _background:Sprite;
        private var _defaultBackground:DisplayObject;
        private var _editingBackground:DisplayObject;
        private var _pressedBackground:DisplayObject;
        private var _inactiveBackground:DisplayObject;
        private var _rolloverBackground:DisplayObject;
        private var _captionElement:TextField;
        private var _pressed:Boolean;
        private var _hover:Boolean;
        private var _active:Boolean;
        private var _selected:Boolean;
        private var _currentlyEditing:Boolean;
        private var _alignRight:Boolean;
        private var _icon:Bitmap;

        public function Button(_arg_1:String, _arg_2:Rectangle, _arg_3:Boolean, _arg_4:Function, _arg_5:uint=0xFFFFFF)
        {
            removeOldLocalization(_label);
            _label = _arg_1;
            _localizedText = _arg_1;
            checkLocalization(_label);
            _rectangle = _arg_2;
            _fitWidthToText = _arg_3;
            _action = _arg_4;
            _glowColour = _arg_5;
            _icon = icon;
            active = true;
            mouseChildren = false;
            addEventListener("addedToStage", onAddedToStage);
            addEventListener("removedFromStage", onRemovedFromStage);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            stage.removeEventListener("mouseUp", onStageMouseUp);
            removeEventListener("mouseDown", onMouseDown);
            removeEventListener("mouseUp", onMouseUp);
            removeEventListener("mouseOver", onMouseOver);
            removeEventListener("mouseOut", onMouseOut);
        }

        protected function onAddedToStage(_arg_1:Event=null):void
        {
            x = _rectangle.x;
            y = _rectangle.y;
            if (_label != "")
            {
                _captionElement = LoaderUI.createTextField(_localizedText, 18, textColour, true, false, false, italic, "left", false, underline);
                if (etching)
                {
                    LoaderUI.addEtching(_captionElement);
                };
                if (_fitWidthToText)
                {
                    _rectangle.width = (_captionElement.textWidth + padding);
                };
            };
            _defaultBackground = defaultBackground;
            _defaultBackground.width = _rectangle.width;
            _defaultBackground.height = _rectangle.height;
            _editingBackground = currentlyActive;
            _editingBackground.width = _rectangle.width;
            _editingBackground.height = _rectangle.height;
            _pressedBackground = pressedBackground;
            _pressedBackground.width = _rectangle.width;
            _pressedBackground.height = _rectangle.height;
            _inactiveBackground = inactiveBackground;
            _inactiveBackground.width = _rectangle.width;
            _inactiveBackground.height = _rectangle.height;
            _rolloverBackground = rolloverBackground;
            if (_rolloverBackground != null)
            {
                _rolloverBackground.width = _rectangle.width;
                _rolloverBackground.height = _rectangle.height;
            };
            while (numChildren > 0)
            {
                removeChildAt(0);
            };
            _background = new Sprite();
            _background.addChild(_defaultBackground);
            _background.addChild(_pressedBackground);
            _background.addChild(_inactiveBackground);
            _background.addChild(_editingBackground);
            if (_rolloverBackground != null)
            {
                _background.addChild(_rolloverBackground);
            };
            addChild(_background);
            if (_label != "")
            {
                addChild(_captionElement);
                _captionElement.x = (((_rectangle.width - _captionElement.textWidth) / 2) - 2);
                _captionElement.y = (((_rectangle.height - _captionElement.textHeight) / 2) - 2);
            };
            if (icon != null)
            {
                _background.addChild(icon);
                icon.x = 10;
                _icon.y = ((_background.height - icon.height) / 2);
            };
            refresh();
            width = _rectangle.width;
            height = _rectangle.height;
            if (centred)
            {
                x = int(((parent.width - width) / 2));
            };
            if (_alignRight)
            {
                x = (parent.width - width);
            };
            addEventListener("mouseDown", onMouseDown);
            addEventListener("mouseOver", onMouseOver);
            addEventListener("mouseOut", onMouseOut);
        }

        private function onMouseOut(_arg_1:MouseEvent):void
        {
            _hover = false;
            refresh();
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            if (!_active)
            {
                return;
            };
            _hover = true;
            refresh();
        }

        private function onMouseDown(_arg_1:MouseEvent):void
        {
            if (!_active)
            {
                return;
            };
            stage.addEventListener("mouseUp", onStageMouseUp);
            addEventListener("mouseUp", onMouseUp);
            _pressed = true;
            refresh();
        }

        private function onMouseUp(_arg_1:MouseEvent):void
        {
            _arg_1.stopImmediatePropagation();
            stage.removeEventListener("mouseUp", onStageMouseUp);
            removeEventListener("mouseUp", onMouseUp);
            _pressed = false;
            refresh();
            _action(this); //not popped
        }

        private function onStageMouseUp(_arg_1:MouseEvent):void
        {
            stage.removeEventListener("mouseUp", onStageMouseUp);
            removeEventListener("mouseUp", onMouseUp);
            _pressed = false;
            refresh();
        }

        private function refresh():void
        {
            var _local_3:int;
            _local_3 = 1;
            var _local_1:int;
            _local_1 = 2;
            var _local_2:int;
            _local_2 = 3;
            var _local_5:int;
            _local_5 = 4;
            if (_background == null)
            {
                return;
            };
            var _local_4:int = ((_active) ? ((((_pressed) && (_hover)) || (_selected)) ? 2 : 1) : 3);
            if (_currentlyEditing)
            {
                _local_4 = 4;
            };
            _defaultBackground.visible = ((_local_4 == 1) && ((_rolloverBackground == null) || (!(_hover))));
            _pressedBackground.visible = (_local_4 == 2);
            _inactiveBackground.visible = (_local_4 == 3);
            _editingBackground.visible = (_local_4 == 4);
            if (_rolloverBackground != null)
            {
                _rolloverBackground.visible = ((_local_4 == 1) && (_hover));
                filters = [];
            }
            else
            {
                filters = ((_hover) ? [new GlowFilter(_glowColour, 0.7, 10, 10)] : []);
            };
            if (_captionElement)
            {
                _captionElement.textColor = ((_active) ? textColour : 0x999999);
            };
        }

        public function get centred():Boolean
        {
            return (_centred);
        }

        public function set centred(_arg_1:Boolean):void
        {
            _centred = _arg_1;
        }

        override public function set x(_arg_1:Number):void
        {
            super.x = _arg_1;
            _rectangle.x = _arg_1;
        }

        override public function set y(_arg_1:Number):void
        {
            super.y = _arg_1;
            _rectangle.y = _arg_1;
        }

        public function get active():Boolean
        {
            return (_active);
        }

        public function set active(_arg_1:Boolean):void
        {
            _active = _arg_1;
            buttonMode = _active;
            refresh();
        }

        public function unselect():void
        {
            _currentlyEditing = false;
            _selected = false;
            refresh();
        }

        public function currentlyEditing():void
        {
            _currentlyEditing = true;
            refresh();
        }

        public function select():void
        {
            _selected = true;
            refresh();
        }

        public function set alignRight(_arg_1:Boolean):void
        {
            _alignRight = _arg_1;
        }

        protected function get defaultBackground():DisplayObject
        {
            return (LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_png()).bitmapData, new Rectangle(5, 5, 1, 2)));
        }

        protected function get pressedBackground():DisplayObject
        {
            return (LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_pressed_png()).bitmapData, new Rectangle(6, 10, 1, 3)));
        }

        protected function get inactiveBackground():DisplayObject
        {
            return (LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_inactive_png()).bitmapData, new Rectangle(5, 6, 1, 2)));
        }

        protected function get currentlyActive():DisplayObject
        {
            return (LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_png()).bitmapData, new Rectangle(5, 6, 1, 2)));
        }

        protected function get rolloverBackground():DisplayObject
        {
            return (null);
        }

        protected function get icon():Bitmap
        {
            return (_icon);
        }

        protected function get etching():Boolean
        {
            return (true);
        }

        protected function get padding():int
        {
            return (24);
        }

        protected function get textColour():uint
        {
            return (0);
        }

        protected function get italic():Boolean
        {
            return (false);
        }

        protected function get underline():Boolean
        {
            return (false);
        }

        public function get label():String
        {
            return (_label);
        }

        public function get localizedText():String
        {
            return (_localizedText);
        }

        public function set localizedText(_arg_1:String):void
        {
            _localizedText = _arg_1;
            if (_captionElement)
            {
                _captionElement.text = _arg_1;
                onAddedToStage();
            };
        }


    }
}