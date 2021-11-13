package com.sulake.habbo.room.messages
{
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectAvatarUpdateMessage extends RoomObjectMoveUpdateMessage 
    {

        private var _dirHead:int;
        private var _canStandUp:Boolean;
        private var _baseY:Number;

        public function RoomObjectAvatarUpdateMessage(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:int, _arg_5:Boolean, _arg_6:Number)
        {
            super(_arg_1, _arg_2, _arg_3);
            _dirHead = _arg_4;
            _canStandUp = _arg_5;
            _baseY = _arg_6;
        }

        public function get dirHead():int
        {
            return (_dirHead);
        }

        public function get canStandUp():Boolean
        {
            return (_canStandUp);
        }

        public function get baseY():Number
        {
            return (_baseY);
        }


    }
}