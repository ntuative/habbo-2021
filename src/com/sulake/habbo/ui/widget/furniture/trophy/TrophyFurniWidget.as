package com.sulake.habbo.ui.widget.furniture.trophy
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;

    public class TrophyFurniWidget extends RoomWidgetBase implements ITrophyFurniWidget 
    {

        public static const VIEW_NIKO_SILVER:int = 10;
        public static const VIEW_NIKO_GOLD:int = 20;

        private var _name:String;
        private var _date:String;
        private var _message:String;
        private var _color:int;
        private var _configuration:ICoreConfiguration;
        private var _SafeStr_570:ITrophyView;
        private var _SafeStr_4134:int;

        public function TrophyFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:ICoreConfiguration)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _configuration = _arg_5;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get date():String
        {
            return (_date);
        }

        public function get message():String
        {
            return (_message);
        }

        public function get color():int
        {
            return (_color);
        }

        public function get configuration():ICoreConfiguration
        {
            return (_configuration);
        }

        override public function dispose():void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            _configuration = null;
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWTDUE_TROPHY_DATA", onObjectUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWTDUE_TROPHY_DATA", onObjectUpdate);
        }

        private function onObjectUpdate(_arg_1:RoomWidgetTrophyDataUpdateEvent):void
        {
            _name = _arg_1.name;
            _date = _arg_1.date;
            _message = _arg_1.message;
            _color = (_arg_1.color - 1);
            _SafeStr_4134 = _arg_1.viewType;
            if (((_color < 0) || (_color > 2)))
            {
                _color = 0;
            };
            updateInterface();
        }

        private function updateInterface():void
        {
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.dispose();
            };
            switch (_SafeStr_4134)
            {
                case 10:
                case 20:
                    _SafeStr_570 = new NikoTrophyView(this, _SafeStr_4134);
                    break;
                default:
                    _SafeStr_570 = new TrophyView(this);
            };
            _SafeStr_570.showInterface();
        }


    }
}

