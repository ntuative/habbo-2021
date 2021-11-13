package com.sulake.habbo.notifications.singular
{
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;

    public class HabboNotificationItemStyle 
    {

        private var _icon:BitmapData;
        private var _disposeIcon:Boolean;
        private var _iconSrc:String;
        private var _internalLink:String;
        private var _iconAssetUri:String;

        public function HabboNotificationItemStyle(_arg_1:Map, _arg_2:BitmapData, _arg_3:String, _arg_4:Boolean, _arg_5:String)
        {
            _iconAssetUri = _arg_3;
            if (((!(_arg_1 == null)) && (_arg_3 == null)))
            {
                _icon = _arg_1["icon"];
                _internalLink = _arg_1["internallink"];
            };
            if (_arg_2 != null)
            {
                _icon = _arg_2;
                _disposeIcon = _arg_4;
            }
            else
            {
                _disposeIcon = false;
            };
            _iconSrc = _arg_5;
        }

        public function dispose():void
        {
            if (((_disposeIcon) && (!(_icon == null))))
            {
                _icon.dispose();
                _icon = null;
            };
        }

        public function get icon():BitmapData
        {
            return (_icon);
        }

        public function get internalLink():String
        {
            return (_internalLink);
        }

        public function set internalLink(_arg_1:String):void
        {
            _internalLink = _arg_1;
        }

        public function get iconSrc():String
        {
            return (_iconSrc);
        }

        public function get iconAssetUri():String
        {
            return (_iconAssetUri);
        }


    }
}