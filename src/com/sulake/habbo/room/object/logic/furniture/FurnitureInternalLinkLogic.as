package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureInternalLinkLogic extends FurnitureLogic 
    {

        private var _SafeStr_3184:Boolean = false;
        private var _SafeStr_3185:int = 0;


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
                if (_local_2.@startState == "1")
                {
                    _SafeStr_3184 = true;
                };
            };
        }

        override public function getEventTypes():Array
        {
            return (getAllEventTypes(super.getEventTypes(), ["ROWRE_INTERNAL_LINK"]));
        }

        override public function useObject():void
        {
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_INTERNAL_LINK", object));
            };
        }

        override public function update(_arg_1:int):void
        {
            super.update(_arg_1);
            if (!_SafeStr_3184)
            {
                return;
            };
            _SafeStr_3185++;
            if (((_SafeStr_3184) && (_SafeStr_3185 == 20)))
            {
                setAnimationState(1);
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

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (((_arg_1.type == "doubleClick") && (_SafeStr_3184)))
            {
                setAnimationState(0);
            };
            super.mouseEvent(_arg_1, _arg_2);
        }


    }
}

