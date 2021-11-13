package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;

    public class GuildBadgeViewCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _SafeStr_1566:GuildMembershipsController;

        public function GuildBadgeViewCatalogWidget(_arg_1:IWindowContainer, _arg_2:GuildMembershipsController)
        {
            super(_arg_1);
            _SafeStr_1566 = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _SafeStr_1566 = null;
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("guildBadgeViewWidget");
            events.addEventListener("GUILD_SELECTED", onGuildSelected);
            return (true);
        }

        private function onGuildSelected(_arg_1:CatalogWidgetGuildSelectedEvent):void
        {
            if (disposed)
            {
                return;
            };
            var _local_2:IBadgeImageWidget = (IWidgetWindow(_window.findChildByName("badge")).widget as IBadgeImageWidget);
            if (_local_2 != null)
            {
                _local_2.badgeId = _arg_1.badgeCode;
                _local_2.groupId = _arg_1.guildId;
            };
        }


    }
}

