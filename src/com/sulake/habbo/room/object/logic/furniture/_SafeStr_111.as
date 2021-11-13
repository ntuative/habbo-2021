package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
    import flash.utils.getTimer;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectBadgeAssetEvent;

    public class _SafeStr_111 extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROGBE_LOAD_BADGE", "ROWRE_BADGE_DISPLAY_ENGRAVING"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:StringArrayStuffData;
            super.processUpdateMessage(_arg_1);
            var _local_4:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_4 != null)
            {
                _local_2 = (_local_4.data as StringArrayStuffData);
                if (_local_2 != null)
                {
                    updateBadge(_local_2.getValue(1));
                };
            };
            var _local_3:RoomObjectGroupBadgeUpdateMessage = (_arg_1 as RoomObjectGroupBadgeUpdateMessage);
            if (_local_3 != null)
            {
                if (_local_3.assetName != "loading_icon")
                {
                    object.getModelController().setString("furniture_badge_asset_name", _local_3.assetName);
                    object.getModelController().setNumber("furniture_badge_image_status", 1);
                    this.update(getTimer());
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
                case "doubleClick":
                    useObject();
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
            };
        }

        override public function useObject():void
        {
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_BADGE_DISPLAY_ENGRAVING", object));
            };
        }

        protected function updateBadge(_arg_1:String):void
        {
            if (_arg_1 != "")
            {
                eventDispatcher.dispatchEvent(new RoomObjectBadgeAssetEvent("ROGBE_LOAD_BADGE", object, _arg_1, false));
            };
        }


    }
}

