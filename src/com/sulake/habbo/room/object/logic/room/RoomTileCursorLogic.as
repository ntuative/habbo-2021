package com.sulake.habbo.room.object.logic.room
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.messages.RoomObjectTileCursorUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomTileCursorLogic extends ObjectLogicBase 
    {

        private static const STATE_ENABLED:int = 0;
        private static const STATE_DISABLED:int = 1;
        private static const STATE_SHOW_TILE_HEIGHT:int = 6;

        private var _SafeStr_3213:String;
        private var _hiddenOnPurpose:Boolean;


        override public function initialize(_arg_1:XML):void
        {
            var _local_2:IRoomObjectModelController;
            if (object != null)
            {
                _local_2 = object.getModelController();
                if (_local_2 != null)
                {
                    _local_2.setNumber("furniture_alpha_multiplier", 1);
                    object.setState(1, 0);
                };
            };
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_3:Number;
            var _local_4:int;
            var _local_2:RoomObjectTileCursorUpdateMessage = (_arg_1 as RoomObjectTileCursorUpdateMessage);
            if (_local_2 == null)
            {
                return;
            };
            if (((!(_SafeStr_3213 == null)) && (_SafeStr_3213 == _local_2.sourceEventId)))
            {
                return;
            };
            if (_local_2.toggleVisibility)
            {
                _hiddenOnPurpose = (!(_hiddenOnPurpose));
            };
            super.processUpdateMessage(_arg_1);
            if (object != null)
            {
                if (_hiddenOnPurpose)
                {
                    object.setState(1, 0);
                }
                else
                {
                    if (!_local_2.visible)
                    {
                        object.setState(1, 0);
                    }
                    else
                    {
                        _local_3 = _local_2.height;
                        object.getModelController().setNumber("tile_cursor_height", _local_3);
                        _local_4 = ((_local_3 > 0.8) ? 6 : 0);
                        object.setState(_local_4, 0);
                    };
                };
            };
            _SafeStr_3213 = _local_2.sourceEventId;
        }


    }
}

