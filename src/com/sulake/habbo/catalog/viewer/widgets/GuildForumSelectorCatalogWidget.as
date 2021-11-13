package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetShowWarningTextEvent;

    public class GuildForumSelectorCatalogWidget extends GuildSelectorCatalogWidget 
    {

        public function GuildForumSelectorCatalogWidget(_arg_1:IWindowContainer, _arg_2:GuildMembershipsController)
        {
            super(_arg_1, _arg_2);
        }

        override protected function filterGroupMemberships(_arg_1:Array):Array
        {
            var _local_2:Array = [];
            var _local_4:int = _SafeStr_1566.catalog.sessionDataManager.userId;
            var _local_3:Boolean = _SafeStr_1566.catalog.sessionDataManager.hasSecurity(4);
            for each (var _local_5:HabboGroupEntryData in _arg_1)
            {
                if (!(((!(_local_5.hasForum)) && (!(_local_5.ownerId == _local_4))) && (!(_local_3))))
                {
                    _local_2.push(_local_5);
                };
            };
            return (_local_2);
        }

        override protected function selectGroup(_arg_1:HabboGroupEntryData):void
        {
            super.selectGroup(_arg_1);
            events.dispatchEvent(new CatalogWidgetShowWarningTextEvent(((_arg_1.hasForum) ? "${catalog.alert.group_has_forum}" : "")));
        }


    }
}

