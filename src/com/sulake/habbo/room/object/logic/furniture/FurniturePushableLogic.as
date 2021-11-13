package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.data.LegacyStuffData;

    public class FurniturePushableLogic extends FurnitureMultiStateLogic
    {

        private static const ANIMATION_NOT_MOVING:int = 0;
        private static const ANIMATION_MOVING:int = 1;
        private static const MAX_ANIMATION_COUNT:int = 10;

        private var _oldLocation:Vector3d = null;

        public function FurniturePushableLogic()
        {
            moveUpdateInterval = 500;
            _oldLocation = new Vector3d();
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:IVector3d;
            var _local_4:IVector3d;
            var _local_5:IVector3d;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:RoomObjectMoveUpdateMessage = (_arg_1 as RoomObjectMoveUpdateMessage);
            if (((!(object == null)) && (_local_3 == null)))
            {
                if (_arg_1.loc != null)
                {
                    _local_2 = object.getLocation();
                    _local_4 = Vector3d.dif(_arg_1.loc, _local_2);
                    if (_local_4 != null)
                    {
                        if (((Math.abs(_local_4.x) < 2) && (Math.abs(_local_4.y) < 2)))
                        {
                            _local_5 = _local_2;
                            if (((Math.abs(_local_4.x) > 1) || (Math.abs(_local_4.y) > 1)))
                            {
                                _local_5 = Vector3d.sum(_local_2, Vector3d.product(_local_4, 0.5));
                            };
                            _local_3 = new RoomObjectMoveUpdateMessage(_local_5, _arg_1.loc, _arg_1.dir);
                            super.processUpdateMessage(_local_3);
                            return;
                        };
                    };
                };
            };
            if (((!(_arg_1.loc == null)) && (_local_3 == null)))
            {
                _local_3 = new RoomObjectMoveUpdateMessage(_arg_1.loc, _arg_1.loc, _arg_1.dir);
                super.processUpdateMessage(_local_3);
            };
            var _local_6:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_6 != null)
            {
                if (_local_6.state > 0)
                {
                    moveUpdateInterval = (500 / getUpdateIntervalValue(_local_6.state));
                }
                else
                {
                    moveUpdateInterval = 1;
                };
                handleDataUpdateMessage(_local_6);
                return;
            };
            if (((_local_3) && (_local_3.isSlideUpdate)))
            {
                moveUpdateInterval = 500;
            };
            super.processUpdateMessage(_arg_1);
        }

        protected function getUpdateIntervalValue(_arg_1:int):int
        {
            return (_arg_1 / 10);
        }

        protected function getAnimationValue(_arg_1:int):int
        {
            return (_arg_1 % 10);
        }

        private function handleDataUpdateMessage(_arg_1:RoomObjectDataUpdateMessage):void
        {
            var _local_2:LegacyStuffData;
            var _local_3:int = getAnimationValue(_arg_1.state);
            if (_local_3 != _arg_1.state)
            {
                _local_2 = new LegacyStuffData();
                _local_2.setString(String(_local_3));
                _arg_1 = new RoomObjectDataUpdateMessage(_local_3, _local_2, _arg_1.extra);
            };
            super.processUpdateMessage(_arg_1);
        }

        override public function update(_arg_1:int):void
        {
            if (object != null)
            {
                _oldLocation.assign(object.getLocation());
                super.update(_arg_1);
                if (Vector3d.dif(object.getLocation(), _oldLocation).length == 0)
                {
                    if (object.getState(0) != 0)
                    {
                        object.setState(0, 0);
                    };
                };
            };
        }


    }
}
