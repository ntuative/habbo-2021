package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HumanThrowsSnowballAtHumanEventData extends SnowWarGameEventData 
    {

        private var _humanGameObjectId:int;
        private var _targetHumanGameObjectId:int;
        private var _trajectory:int;

        public function HumanThrowsSnowballAtHumanEventData(_arg_1:int)
        {
            super(_arg_1);
        }

        public function get humanGameObjectId():int
        {
            return (_humanGameObjectId);
        }

        public function get targetHumanGameObjectId():int
        {
            return (_targetHumanGameObjectId);
        }

        public function get trajectory():int
        {
            return (_trajectory);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            _humanGameObjectId = _arg_1.readInteger();
            _targetHumanGameObjectId = _arg_1.readInteger();
            _trajectory = _arg_1.readInteger();
        }


    }
}