package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;

    public class FurnitureFriendFurniLogic extends FurnitureMultiStateLogic 
    {

        private static const STATE_UNINITIALIZED:int = -1;
        private static const STATE_UNLOCKED:int = 0;
        private static const STATE_LOCKED:int = 1;

        private var _SafeStr_448:int = -1;


        protected function get engravingDialogType():int
        {
            return (0);
        }

        override public function get contextMenu():String
        {
            return ((_SafeStr_448 == 0) ? "FRIEND_FURNITURE" : "DUMMY");
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["ROWRE_FRIEND_FURNITURE_ENGRAVING"]));
        }

        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            object.getModelController().setNumber("furniture_friendfurni_engraving_type", engravingDialogType);
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:StringArrayStuffData;
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null)
            {
                _local_2 = (_local_3.data as StringArrayStuffData);
                if (_local_2 != null)
                {
                    _SafeStr_448 = _local_2.state;
                }
                else
                {
                    _SafeStr_448 = _local_3.state;
                };
            };
            super.processUpdateMessage(_arg_1);
        }

        override public function useObject():void
        {
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                if (_SafeStr_448 == 1)
                {
                    eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_FRIEND_FURNITURE_ENGRAVING", object));
                }
                else
                {
                    super.useObject();
                };
            };
        }


    }
}

