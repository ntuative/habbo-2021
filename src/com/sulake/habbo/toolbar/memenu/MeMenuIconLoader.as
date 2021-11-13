package com.sulake.habbo.toolbar.memenu
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class MeMenuIconLoader implements IAvatarImageListener 
    {

        private static const MAX_ICON_HEIGHT:int = 50;
        private static const HEAD_MARGIN:int = 3;

        private var _toolbar:HabboToolbar;
        private var _SafeStr_3800:String;
        private var _SafeStr_3801:BitmapData;
        private var _SafeStr_3802:BitmapData;
        private var _SafeStr_2351:UserObjectEvent;
        private var _SafeStr_2352:UserChangeMessageEvent;

        public function MeMenuIconLoader(_arg_1:HabboToolbar)
        {
            _toolbar = _arg_1;
            _SafeStr_2351 = new UserObjectEvent(onUserObject);
            _SafeStr_2352 = new UserChangeMessageEvent(onUserChange);
            _toolbar.communicationManager.addHabboConnectionMessageEvent(_SafeStr_2351);
            _toolbar.communicationManager.addHabboConnectionMessageEvent(_SafeStr_2352);
            setMeMenuToolbarIcon();
        }

        private function setMeMenuToolbarIcon(_arg_1:String=null):void
        {
            var _local_3:BitmapData;
            var _local_5:BitmapData;
            var _local_7:String;
            var _local_4:String;
            var _local_8:IAvatarImage;
            var _local_6:BitmapData;
            var _local_9:BitmapData;
            var _local_2:Rectangle;
            if (_toolbar.avatarRenderManager != null)
            {
                _local_7 = ((_arg_1 == null) ? _toolbar.sessionDataManager.figure : _arg_1);
                if (_local_7 != _SafeStr_3800)
                {
                    _local_4 = _toolbar.sessionDataManager.gender;
                    _local_8 = _toolbar.avatarRenderManager.createAvatarImage(_local_7, "h", _local_4, this);
                    if (_local_8 != null)
                    {
                        _local_8.setDirection("full", 2);
                        _local_3 = _local_8.getCroppedImage("full");
                        _local_5 = _local_8.getCroppedImage("head");
                        _local_8.dispose();
                    };
                    _SafeStr_3800 = _local_7;
                    if (_SafeStr_3801 != null)
                    {
                        _SafeStr_3801.dispose();
                    };
                    _SafeStr_3801 = _local_3;
                    if (_SafeStr_3802 != null)
                    {
                        _SafeStr_3802.dispose();
                    };
                    _SafeStr_3802 = _local_5;
                }
                else
                {
                    _local_3 = _SafeStr_3801;
                    _local_5 = _SafeStr_3802;
                };
            };
            if (_toolbar != null)
            {
                if (((!(_local_3 == null)) && (!(_local_5 == null))))
                {
                    if (_local_3.height > 50)
                    {
                        _local_9 = new BitmapData(_local_3.width, 50, true, 0);
                        _local_2 = _local_9.rect.clone();
                        if (_local_5.height > (50 - 3))
                        {
                            _local_2.offset(0, ((_local_5.height - 50) + 3));
                        };
                        _local_9.copyPixels(_local_3, _local_2, new Point(0, 0));
                        _local_6 = _local_9;
                    }
                    else
                    {
                        _local_6 = _local_3.clone();
                    };
                };
                _toolbar.setIconBitmap("HTIE_ICON_MEMENU", _local_6);
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            _SafeStr_3800 = "";
            setMeMenuToolbarIcon();
        }

        private function onUserObject(_arg_1:UserObjectEvent):void
        {
            setMeMenuToolbarIcon(_arg_1.getParser().figure);
        }

        private function onUserChange(_arg_1:UserChangeMessageEvent):void
        {
            if (_arg_1.id == -1)
            {
                setMeMenuToolbarIcon(_arg_1.figure);
            };
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_2351 != null)
            {
                _toolbar.communicationManager.removeHabboConnectionMessageEvent(_SafeStr_2351);
                _SafeStr_2351 = null;
            };
            if (_SafeStr_2352 != null)
            {
                _toolbar.communicationManager.removeHabboConnectionMessageEvent(_SafeStr_2352);
                _SafeStr_2352 = null;
            };
            _toolbar = null;
        }

        public function get disposed():Boolean
        {
            return (_toolbar == null);
        }


    }
}

