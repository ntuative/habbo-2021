package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarExpressionUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _expressionType:int = -1;

        public function RoomObjectAvatarExpressionUpdateMessage(_arg_1:int=-1)
        {
            _expressionType = _arg_1;
        }

        public function get expressionType():int
        {
            return (_expressionType);
        }


    }
}