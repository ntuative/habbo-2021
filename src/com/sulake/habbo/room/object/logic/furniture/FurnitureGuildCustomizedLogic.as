package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
    import flash.utils.getTimer;
    import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.events.RoomObjectBadgeAssetEvent;

    public class FurnitureGuildCustomizedLogic extends FurnitureMultiStateLogic 
    {

        public static const GUILD_ID_STUFFDATA_KEY:int = 1;
        public static const BADGE_CODE_STUFFDATA_KEY:int = 2;
        public static const COLOR_1_STUFFDATA_KEY:int = 3;
        public static const COLOR_2_STUFFDATA_KEY:int = 4;


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROGBE_LOAD_BADGE", "ROWRE_GUILD_FURNI_CONTEXT_MENU", "ROWRE_CLOSE_FURNI_CONTEXT_MENU"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_3:StringArrayStuffData;
            var _local_6:RoomObjectEvent;
            super.processUpdateMessage(_arg_1);
            var _local_5:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_5 != null)
            {
                _local_3 = (_local_5.data as StringArrayStuffData);
                if (_local_3 != null)
                {
                    updateGuildId(_local_3.getValue(1));
                    updateGuildBadge(_local_3.getValue(2));
                    updateGuildColors(_local_3.getValue(3), _local_3.getValue(4));
                };
            };
            var _local_4:RoomObjectGroupBadgeUpdateMessage = (_arg_1 as RoomObjectGroupBadgeUpdateMessage);
            if (_local_4 != null)
            {
                if (_local_4.assetName != "loading_icon")
                {
                    object.getModelController().setString("furniture_guild_customized_asset_name", _local_4.assetName);
                    this.update(getTimer());
                };
            };
            var _local_2:RoomObjectSelectedMessage = (_arg_1 as RoomObjectSelectedMessage);
            if (_local_2)
            {
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    if (!_local_2.selected)
                    {
                        _local_6 = new RoomObjectWidgetRequestEvent("ROWRE_CLOSE_FURNI_CONTEXT_MENU", object);
                        eventDispatcher.dispatchEvent(_local_6);
                    };
                };
            };
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "click":
                    openContextMenu();
                default:
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
            };
        }

        protected function openContextMenu():void
        {
            var _local_1:RoomObjectEvent = new RoomObjectWidgetRequestEvent("ROWRE_GUILD_FURNI_CONTEXT_MENU", object);
            eventDispatcher.dispatchEvent(_local_1);
        }

        private function updateGuildColors(_arg_1:String, _arg_2:String):void
        {
            object.getModelController().setNumber("furniture_guild_customized_color_1", parseInt(_arg_1, 16));
            object.getModelController().setNumber("furniture_guild_customized_color_2", parseInt(_arg_2, 16));
        }

        private function updateGuildBadge(_arg_1:String):void
        {
            eventDispatcher.dispatchEvent(new RoomObjectBadgeAssetEvent("ROGBE_LOAD_BADGE", object, _arg_1, true));
        }

        protected function updateGuildId(_arg_1:String):void
        {
            object.getModelController().setNumber("furniture_guild_customized_guild_id", parseInt(_arg_1));
        }


    }
}