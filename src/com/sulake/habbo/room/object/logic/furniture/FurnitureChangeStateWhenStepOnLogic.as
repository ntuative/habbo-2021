package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.events.RoomToObjectOwnAvatarMoveEvent;

    public class FurnitureChangeStateWhenStepOnLogic extends FurnitureLogic 
    {


        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            eventDispatcher.addEventListener("ROAME_MOVE_TO", onOwnAvatarMove);
        }

        override public function tearDown():void
        {
            eventDispatcher.removeEventListener("ROAME_MOVE_TO", onOwnAvatarMove);
            super.tearDown();
        }

        private function onOwnAvatarMove(_arg_1:RoomToObjectOwnAvatarMoveEvent):void
        {
            var _local_6:int;
            var _local_5:int;
            var _local_7:IVector3d;
            var _local_3:int;
            var _local_4:int;
            if (object == null)
            {
                return;
            };
            var _local_2:IVector3d = object.getLocation();
            if (_arg_1.targetLoc)
            {
                _local_6 = object.getModel().getNumber("furniture_size_x");
                _local_5 = object.getModel().getNumber("furniture_size_y");
                _local_7 = object.getDirection();
                _local_3 = 0;
                _local_4 = int((((_local_7.x + 45) % 360) / 90));
                if (((_local_4 == 1) || (_local_4 == 3)))
                {
                    _local_3 = _local_6;
                    _local_6 = _local_5;
                    _local_5 = _local_3;
                };
                if ((((_arg_1.targetLoc.x >= _local_2.x) && (_arg_1.targetLoc.x < (_local_2.x + _local_6))) && ((_arg_1.targetLoc.y >= _local_2.y) && (_arg_1.targetLoc.y < (_local_2.y + _local_5)))))
                {
                    object.setState(1, 0);
                }
                else
                {
                    object.setState(0, 0);
                };
            };
        }


    }
}