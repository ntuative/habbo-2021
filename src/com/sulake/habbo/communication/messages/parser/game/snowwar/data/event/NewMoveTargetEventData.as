package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NewMoveTargetEventData extends SnowWarGameEventData 
    {

        private var _humanGameObjectId:int;
        private var _x:int;
        private var _y:int;

        public function NewMoveTargetEventData(_arg_1:int)
        {
            super(_arg_1);
        }

        public function get humanGameObjectId():int
        {
            return (_humanGameObjectId);
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            _humanGameObjectId = _arg_1.readInteger();
            _x = _arg_1.readInteger();
            _y = _arg_1.readInteger();
        }


    }
}