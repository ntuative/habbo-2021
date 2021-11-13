package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class GuildInfoCtrl implements IDisposable 
    {

        private static const GUILD_INFO_NAME:String = "guild_info";

        private var _navigator:IHabboTransitionalNavigator;
        private var _groupId:int;

        public function GuildInfoCtrl(_arg_1:IHabboTransitionalNavigator)
        {
            _navigator = _arg_1;
        }

        public function dispose():void
        {
            _navigator = null;
        }

        public function get disposed():Boolean
        {
            return (_navigator == null);
        }

        public function refresh(_arg_1:IWindowContainer, _arg_2:GuestRoomData, _arg_3:Boolean=false):void
        {
            var _local_5:IWindowContainer = IWindowContainer(_arg_1.findChildByName("guild_info"));
            if (_local_5 == null)
            {
                _local_5 = IWindowContainer(_navigator.getXmlWindow("guild_info"));
                _local_5.name = "guild_info";
                _arg_1.addChild(_local_5);
                _local_5.addEventListener("WME_CLICK", onGuildInfo);
            };
            if (((_arg_2 == null) || (_arg_2.habboGroupId < 1)))
            {
                _local_5.visible = false;
                return;
            };
            _local_5.visible = true;
            _navigator.registerParameter("navigator.guildbase", "groupName", _arg_2.groupName);
            _local_5.findChildByName("guild_base_txt").caption = _navigator.getText("navigator.guildbase");
            var _local_4:IBadgeImageWidget = (IWidgetWindow(_arg_1.findChildByName("guild_badge")).widget as IBadgeImageWidget);
            _local_4.badgeId = _arg_2.groupBadgeCode;
            _local_4.groupId = _arg_2.habboGroupId;
            _groupId = _arg_2.habboGroupId;
        }

        private function onGuildInfo(_arg_1:WindowEvent):void
        {
            _navigator.send(new GetHabboGroupDetailsMessageComposer(_groupId, true));
        }


    }
}