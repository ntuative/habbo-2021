package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureHighScoreLogic extends FurnitureLogic 
    {

        private static const SHOW_WIDGET_IN_STATE:int = 1;

        private var _SafeStr_448:int = -1;


        override public function getEventTypes():Array
        {
            return (["ROWRE_HIGH_SCORE_DISPLAY", "ROWRE_HIDE_HIGH_SCORE_DISPLAY"]);
        }

        override public function tearDown():void
        {
            if (object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
                eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_HIDE_HIGH_SCORE_DISPLAY", object));
            };
            super.tearDown();
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            if (object.getModelController().getNumber("furniture_real_room_object") != 1)
            {
                return;
            };
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null)
            {
                if (_local_2.state == 1)
                {
                    eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_HIGH_SCORE_DISPLAY", object));
                }
                else
                {
                    eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_HIDE_HIGH_SCORE_DISPLAY", object));
                };
                _SafeStr_448 = _local_2.state;
                return;
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


    }
}

