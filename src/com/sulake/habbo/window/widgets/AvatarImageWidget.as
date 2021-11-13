package com.sulake.habbo.window.widgets
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.habbo.avatar.IAvatarImage;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.filters.ColorMatrixFilter;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class AvatarImageWidget implements IAvatarImageWidget, IAvatarImageListener
    {

        public static const TYPE:String = "avatar_image";
        private static const FIGURE_KEY:String = "avatar_image:figure";
        private static const SCALE_KEY:String = "avatar_image:scale";
        private static const _SafeStr_4408:String = "avatar_image:only_head";
        private static const CROPPED_KEY:String = "avatar_image:cropped";
        private static const _SafeStr_4409:String = "avatar_image:direction";
        private static const _SafeStr_4406:Array = ["northeast", "east", "southeast", "south", "southwest", "west", "northwest", "north"];
        private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:figure", "hd-180-1.ch-210-66.lg-270-82.sh-290-81", "String");
        private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:scale", "h", "String", false, ["sh", "h"]);
        private static const ONLY_HEAD_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:only_head", false, "Boolean");
        private static const CROPPED_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:cropped", false, "Boolean");
        private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:direction", _SafeStr_4406[2], "String", false, _SafeStr_4406);

        private const rc:Number = 0.333333333333333;
        private const gc:Number = 0.333333333333333;
        private const bc:Number = 0.333333333333333;

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _bitmap:IBitmapWrapperWindow;
        private var _region:IRegionWindow;
        private var _figure:String = String(FIGURE_DEFAULT.value);
        private var _scale:String = String(SCALE_DEFAULT.value);
        private var _onlyHead:Boolean = ONLY_HEAD_DEFAULT.value;
        private var _cropped:Boolean = CROPPED_DEFAULT.value;
        private var _direction:int = _SafeStr_4406.indexOf(DIRECTION_DEFAULT.value);
        private var _userId:int;

        public function AvatarImageWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("avatar_image_xml").content as XML)) as IWindowContainer);
            _bitmap = (_SafeStr_1165.findChildByName("bitmap") as IBitmapWrapperWindow);
            _region = (_SafeStr_1165.findChildByName("region") as IRegionWindow);
            _region.addEventListener("WME_CLICK", onClick);
            refresh();
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_region != null)
                {
                    _region.removeEventListener("WME_CLICK", onClick);
                    _region.dispose();
                    _region = null;
                };
                _bitmap = null;
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
            _local_1.push(FIGURE_DEFAULT.withValue(_figure));
            _local_1.push(SCALE_DEFAULT.withValue(_scale));
            _local_1.push(ONLY_HEAD_DEFAULT.withValue(_onlyHead));
            _local_1.push(CROPPED_DEFAULT.withValue(_cropped));
            _local_1.push(DIRECTION_DEFAULT.withValue(_SafeStr_4406[_direction]));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "avatar_image:figure":
                        figure = String(_local_2.value);
                        break;
                    case "avatar_image:scale":
                        scale = String(_local_2.value);
                        break;
                    case "avatar_image:only_head":
                        onlyHead = _local_2.value;
                        break;
                    case "avatar_image:cropped":
                        cropped = _local_2.value;
                        break;
                    case "avatar_image:direction":
                        direction = _SafeStr_4406.indexOf(_local_2.value);
                };
            };
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function set figure(_arg_1:String):void
        {
            _figure = cleanupAvatarString(_arg_1);
            refresh();
        }

        public function get scale():String
        {
            return (_scale);
        }

        public function set scale(_arg_1:String):void
        {
            _scale = _arg_1;
            refresh();
        }

        public function get onlyHead():Boolean
        {
            return (_onlyHead);
        }

        public function set onlyHead(_arg_1:Boolean):void
        {
            _onlyHead = _arg_1;
            refresh();
        }

        public function get cropped():Boolean
        {
            return (_cropped);
        }

        public function set cropped(_arg_1:Boolean):void
        {
            _cropped = _arg_1;
            refresh();
        }

        public function get direction():int
        {
            return (_direction);
        }

        public function set direction(_arg_1:int):void
        {
            _direction = _arg_1;
            refresh();
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function set userId(_arg_1:int):void
        {
            _userId = _arg_1;
            _region.visible = (_userId > 0);
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (cleanupAvatarString(_arg_1) == _figure)
            {
                refresh();
            };
        }

        private function refresh():void
        {
            var _local_4:Number;
            var _local_1:IAvatarImage;
            var _local_2:String;
            _bitmap.bitmap = null;
            var _local_3:Boolean;
            var _local_5:String = _figure;
            if (((_local_5 == null) || (_local_5.length == 0)))
            {
                _local_3 = true;
                _local_5 = String(FIGURE_DEFAULT.value);
            };
            if (_windowManager.avatarRenderer != null)
            {
                _local_4 = ((_scale == "h") ? 1 : 0.5);
                _local_1 = _windowManager.avatarRenderer.createAvatarImage(_local_5, "h", null, this);
                if (_local_1 != null)
                {
                    _local_1.setDirection(((_onlyHead) ? "head" : "full"), _direction);
                    if (_cropped)
                    {
                        _bitmap.bitmap = _local_1.getCroppedImage(((_onlyHead) ? "head" : "full"), _local_4);
                    }
                    else
                    {
                        _bitmap.bitmap = _local_1.getImage(((_onlyHead) ? "head" : "full"), true, _local_4);
                    };
                    if (_local_3)
                    {
                        greyBitmap(_bitmap);
                    };
                    _bitmap.disposesBitmap = true;
                    _local_1.dispose();
                };
            };
            if (((_bitmap.bitmap == null) || (_bitmap.bitmap.width < 2)))
            {
                _local_2 = (((("placeholder_avatar" + ((_scale == "sh") ? "_small" : "")) + ((_onlyHead) ? "_head" : "")) + ((_cropped) ? "_cropped" : "")) + "_png");
                _bitmap.bitmap = (_windowManager.assets.getAssetByName(_local_2).content as BitmapData);
                _bitmap.disposesBitmap = false;
                greyBitmap(_bitmap);
            };
            _bitmap.invalidate();
            _SafeStr_4407.width = _bitmap.bitmap.width;
            _SafeStr_4407.height = _bitmap.bitmap.height;
        }

        private function greyBitmap(_arg_1:IBitmapWrapperWindow):void
        {
            _bitmap.bitmap.applyFilter(_bitmap.bitmap, _bitmap.bitmap.rect, new Point(), new ColorMatrixFilter([0.333333333333333, 0.333333333333333, 0.333333333333333, 0, 0, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0, 0, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0, 0, 0, 0, 0, 1, 0]));
        }

        private function cleanupAvatarString(_arg_1:String):String
        {
            return ((_arg_1 == null) ? String(FIGURE_DEFAULT.value) : _arg_1.replace(/NaN/g, ""));
        }

        private function onClick(_arg_1:WindowMouseEvent):void
        {
            if (_userId > 0)
            {
                _windowManager.communication.connection.send(new GetExtendedProfileMessageComposer(_userId));
            };
        }


    }
}