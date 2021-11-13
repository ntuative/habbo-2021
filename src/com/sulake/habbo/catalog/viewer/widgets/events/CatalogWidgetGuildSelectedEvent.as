package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetGuildSelectedEvent extends Event 
    {

        public static const _SafeStr_1538:int = -1;

        private var _guildId:int;
        private var _color1:String;
        private var _color2:String;
        private var _badgeCode:String;

        public function CatalogWidgetGuildSelectedEvent(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String)
        {
            _guildId = _arg_1;
            _color1 = _arg_2;
            _color2 = _arg_3;
            _badgeCode = _arg_4;
            super("GUILD_SELECTED");
        }

        public function get guildId():int
        {
            return (_guildId);
        }

        public function get color1():String
        {
            return (_color1);
        }

        public function get color2():String
        {
            return (_color2);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }


    }
}

