package com.sulake.habbo.catalog.guilds
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembershipsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;

    public class GuildMembershipsController 
    {

        private var _catalog:HabboCatalog;
        private var _SafeStr_1448:GuildSelectorCatalogWidget;

        public function GuildMembershipsController(_arg_1:HabboCatalog)
        {
            _catalog = _arg_1;
        }

        public function dispose():void
        {
            _catalog = null;
            _SafeStr_1448 = null;
        }

        public function get catalog():HabboCatalog
        {
            return (_catalog);
        }

        public function registerGuildSelectorWidget(_arg_1:GuildSelectorCatalogWidget):void
        {
            _SafeStr_1448 = _arg_1;
            _catalog.connection.send(new GetGuildMembershipsMessageComposer());
        }

        public function unregisterGuildSelectorWidget(_arg_1:GuildSelectorCatalogWidget):void
        {
            if (_SafeStr_1448 == _arg_1)
            {
                _SafeStr_1448 = null;
            }
            else
            {
                Logger.log("ERROR: Tried to unregister a nonregistered group selector catalog widget");
            };
        }

        public function onGuildMembershipsMessageEvent(_arg_1:GuildMembershipsMessageEvent):void
        {
            var _local_2:Array = _arg_1.guilds.slice(0, _arg_1.guilds.length);
            if (((_SafeStr_1448) && (!(_SafeStr_1448.disposed))))
            {
                _SafeStr_1448.populateAndSelectFavorite(_local_2);
                _SafeStr_1448.selectFirstOffer();
            };
        }

        public function onGuildVisualSettingsChanged(_arg_1:int):void
        {
            if (_SafeStr_1448 != null)
            {
                _catalog.connection.send(new GetGuildMembershipsMessageComposer());
            };
        }


    }
}

