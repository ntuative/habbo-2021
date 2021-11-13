package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.object.IRoomObjectModelController;
    import flash.utils.Timer;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import flash.events.TimerEvent;

    public class FurnitureEditableRoomLinkLogic extends FurnitureLogic 
    {


        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:XMLList = _arg_1.action;
            if (_local_2.length() != 0)
            {
                object.getModelController().setString("furniture_internal_link", _local_2.@link);
            };
        }

        public function setAnimationState(_arg_1:int):void
        {
            if (object == null)
            {
                return;
            };
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (_local_2 != null)
            {
                _local_2.setNumber("furniture_automatic_state_index", _arg_1, false);
            };
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["ROWRE_ROOM_LINK"]));
        }

        override public function useObject():void
        {
            setAnimationState(1);
            var _local_1:Timer = new Timer(2500);
            _local_1.addEventListener("timer", onFakeAnimationOver);
            _local_1.start();
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_ROOM_LINK", object));
            };
        }

        private function onFakeAnimationOver(_arg_1:TimerEvent):void
        {
            setAnimationState(0);
        }


    }
}