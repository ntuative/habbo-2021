package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.habbo.window.enum._SafeStr_163;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;

    public class BadgeImageWidget implements IBadgeImageWidget
    {

        public static const TYPE:String = "badge_image";
        private static const _SafeStr_4410:String = "badge_image:type";
        private static const _SafeStr_4411:String = "badge_image:badge_id";
        private static const TYPE_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:type", "normal", "String", false, _SafeStr_163.ALL);
        private static const ID_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:badge_id", "", "String");

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_958:Boolean;
        private var _SafeStr_1165:IWindowContainer;
        private var _bitmap:IStaticBitmapWrapperWindow;
        private var _region:IRegionWindow;
        private var _type:String = String(TYPE_DEFAULT.value);
        private var _badgeId:String = String(ID_DEFAULT.value);
        private var _groupId:int;
        private var _SafeStr_4412:GroupDetailsChangedMessageEvent;
        private var _SafeStr_3706:HabboGroupBadgesMessageEvent;

        public function BadgeImageWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("badge_image_xml").content as XML)) as IWindowContainer);
            _bitmap = (_SafeStr_1165.findChildByName("bitmap") as IStaticBitmapWrapperWindow);
            _region = (_SafeStr_1165.findChildByName("region") as IRegionWindow);
            _region.addEventListener("WME_CLICK", onClick);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                groupId = 0;
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
            var _local_2:Array = [];
            if (_disposed)
            {
                return (_local_2);
            };
            _local_2.push(TYPE_DEFAULT.withValue(_type));
            _local_2.push(ID_DEFAULT.withValue(_badgeId));
            for each (var _local_1:PropertyStruct in _bitmap.properties)
            {
                if (_local_1.key != "asset_uri")
                {
                    _local_2.push(_local_1.withNameSpace("badge_image"));
                };
            };
            return (_local_2);
        }

        public function set properties(_arg_1:Array):void
        {
            _SafeStr_958 = true;
            var _local_3:Array = [];
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "badge_image:type":
                        type = String(_local_2.value);
                        break;
                    case "badge_image:badge_id":
                        badgeId = String(_local_2.value);
                };
                if (_local_2.key != "badge_image:asset_uri")
                {
                    _local_3.push(_local_2.withoutNameSpace());
                };
            };
            _bitmap.properties = _local_3;
            _SafeStr_958 = false;
            refresh();
        }

        public function get type():String
        {
            return (_type);
        }

        public function set type(_arg_1:String):void
        {
            _type = _arg_1;
            refresh();
        }

        public function get badgeId():String
        {
            return (_badgeId);
        }

        public function set badgeId(_arg_1:String):void
        {
            _badgeId = _arg_1;
            refresh();
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function set groupId(_arg_1:int):void
        {
            _groupId = _arg_1;
            var _local_2:Boolean = ((_type == "group") && (_groupId > 0));
            if (((!(_windowManager == null)) && (!(_windowManager.communication == null))))
            {
                if (((!(_local_2)) && (!(_SafeStr_3706 == null))))
                {
                    _windowManager.communication.removeHabboConnectionMessageEvent(_SafeStr_4412);
                    _windowManager.communication.removeHabboConnectionMessageEvent(_SafeStr_3706);
                    _SafeStr_4412 = null;
                    _SafeStr_3706 = null;
                }
                else
                {
                    if (((_local_2) && (_SafeStr_3706 == null)))
                    {
                        _SafeStr_4412 = new GroupDetailsChangedMessageEvent(onGroupDetailsChanged);
                        _SafeStr_3706 = new HabboGroupBadgesMessageEvent(onHabboGroupBadges);
                        _windowManager.communication.addHabboConnectionMessageEvent(_SafeStr_4412);
                        _windowManager.communication.addHabboConnectionMessageEvent(_SafeStr_3706);
                    };
                };
            };
        }

        public function get bitmapData():BitmapData
        {
            return (IBitmapDataContainer(_bitmap).bitmapData);
        }

        public function get pivotPoint():uint
        {
            return (_bitmap.pivotPoint);
        }

        public function set pivotPoint(_arg_1:uint):void
        {
            _bitmap.pivotPoint = _arg_1;
            _bitmap.invalidate();
        }

        public function get stretchedX():Boolean
        {
            return (_bitmap.stretchedX);
        }

        public function set stretchedX(_arg_1:Boolean):void
        {
            _bitmap.stretchedX = _arg_1;
            _bitmap.invalidate();
        }

        public function get stretchedY():Boolean
        {
            return (_bitmap.stretchedY);
        }

        public function set stretchedY(_arg_1:Boolean):void
        {
            _bitmap.stretchedY = _arg_1;
            _bitmap.invalidate();
        }

        public function get zoomX():Number
        {
            return (_bitmap.zoomX);
        }

        public function set zoomX(_arg_1:Number):void
        {
            _bitmap.zoomX = _arg_1;
            _bitmap.invalidate();
        }

        public function get zoomY():Number
        {
            return (_bitmap.zoomY);
        }

        public function set zoomY(_arg_1:Number):void
        {
            _bitmap.zoomY = _arg_1;
            _bitmap.invalidate();
        }

        public function get greyscale():Boolean
        {
            return (_bitmap.greyscale);
        }

        public function set greyscale(_arg_1:Boolean):void
        {
            _bitmap.greyscale = _arg_1;
            _bitmap.invalidate();
        }

        public function get etchingColor():uint
        {
            return (_bitmap.etchingColor);
        }

        public function set etchingColor(_arg_1:uint):void
        {
            _bitmap.etchingColor = _arg_1;
            _bitmap.invalidate();
        }

        public function get fitSizeToContents():Boolean
        {
            return (_bitmap.fitSizeToContents);
        }

        public function set fitSizeToContents(_arg_1:Boolean):void
        {
            _bitmap.fitSizeToContents = _arg_1;
            _bitmap.invalidate();
        }

        private function onClick(_arg_1:WindowMouseEvent):void
        {
            if (_groupId > 0)
            {
                _windowManager.communication.connection.send(new GetHabboGroupDetailsMessageComposer(_groupId, true));
            };
        }

        private function refresh():void
        {
            if (_SafeStr_958)
            {
                return;
            };
            _bitmap.assetUri = assetUri;
            _bitmap.invalidate();
        }

        private function get assetUri():String
        {
            var _local_1:String = "";
            if (((!(_badgeId == null)) && (_badgeId.length > 0)))
            {
                switch (_type)
                {
                    case "normal":
                        _local_1 = (("${image.library.url}album1584/" + _badgeId) + ".png");
                        break;
                    case "group":
                        _local_1 = _windowManager.getProperty("group.badge.url").replace("%imagerdata%", _badgeId);
                        break;
                    case "perk":
                        _local_1 = (("${image.library.url}perk/" + _badgeId) + ".png");
                };
            };
            return (_local_1);
        }

        private function forceRefresh(_arg_1:int, _arg_2:String):void
        {
            if (_arg_1 != _groupId)
            {
                return;
            };
            _badgeId = _arg_2;
            _windowManager.resourceManager.removeAsset(assetUri);
            refresh();
        }

        private function onGroupDetailsChanged(_arg_1:GroupDetailsChangedMessageEvent):void
        {
            forceRefresh(_arg_1.groupId, _badgeId);
        }

        private function onHabboGroupBadges(_arg_1:HabboGroupBadgesMessageEvent):void
        {
            if (_arg_1.badges.hasKey(_groupId))
            {
                forceRefresh(_groupId, _arg_1.badges[_groupId]);
            };
        }

        public function get etchingPoint():Point
        {
            return (new Point(0, 1));
        }

        public function get wrapX():Boolean
        {
            return (false);
        }

        public function set wrapX(_arg_1:Boolean):void
        {
        }

        public function get wrapY():Boolean
        {
            return (false);
        }

        public function set wrapY(_arg_1:Boolean):void
        {
        }


    }
}